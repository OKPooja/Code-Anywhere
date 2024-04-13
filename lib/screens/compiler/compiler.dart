import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/java.dart';
import 'package:project/screens/compiler/syntax_highlight.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';
import 'package:share_plus/share_plus.dart';
import '../../api.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_toast.dart';

class CodeInputScreen extends StatefulWidget {
  const CodeInputScreen({Key? key}) : super(key: key);

  @override
  _CodeInputScreenState createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  CodeController? _codeController;
  //Map<String, TextStyle>? theme = monokaiSublimeTheme;
  String _selectedLanguage = 'C++';

  void _showOutputBottomSheet(String output) {
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Output',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                output,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  void initState() {
    _codeController?.addListener(() {});
    super.initState();
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/codeAnywhere');
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print("Cannot get download folder path $err");
      }
    }
    return directory?.path;
  }

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      if (kDebugMode) {
        print('Storage permission granted');
      }
    } else if (status.isDenied) {
      if (kDebugMode) {
        print('Storage permission denied');
      }
    } else if (status.isPermanentlyDenied) {
      if (kDebugMode) {
        print('Storage permission permanently denied');
      }
      openAppSettings();
    }
  }

  _download() async {
    print("Hit download");
    await requestStoragePermission();

    String? path = await getDownloadPath();
    if (path != null) {
      print("Directory: $path");
      try {
        String? fileName = await _promptFileName(context);
        if(fileName!.isNotEmpty){
          File f;
          if (_selectedLanguage == "C++") {
            f = File("$path/$fileName.cpp");
          } else if (_selectedLanguage == "Python") {
            f = File("$path/$fileName.py");
          } else {
            f = File("$path/$fileName.java");
          }
          await f.writeAsString(_codeController!.text);
          showCustomToast(
            context: context,
            message: 'File saved successfully',
          );
        }
      } catch (e) {
        print("Error writing file: $e");
      }
    } else {
      print("Download path is null");
    }
  }

  Future<String?> _promptFileName(BuildContext context) async {
    TextEditingController fileNameController = TextEditingController();
    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: Text(
            'Enter File Name',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: Colors.black,
                fontFamily: 'Nunito'),
          ),
          content: TextField(
            controller: fileNameController,
            decoration: InputDecoration(
              hintText: 'File Name',
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Colors.grey,
                  fontFamily: 'Nunito',
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, fileNameController.text.trim());
              },
              child: Text(
                'Save',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontFamily: 'Nunito'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontFamily: 'Nunito',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _share() async {
    if (kDebugMode) {
      print(_codeController!.text);
    }
    if (_codeController!.text.isNotEmpty) {
      await Share.share(_codeController!.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    var source = '';
    if (_selectedLanguage == 'C++') {
      source =
          '#include<iostream> \nusing namespace std; \n\nint main(){ \n  cout << "hello"; \n  return 0;\n}';
    } else if (_selectedLanguage == 'Java') {
      source =
          'import java.util.*;\npublic class Main {\n  public static void main(String[] args) {\n    // Your code here\n    System.out.println("Hello, World!");\n  }\n}';
    } else if (_selectedLanguage == 'Python') {
      source = 'print("Enjoy coding")';
    }
    _codeController = CodeController(
      text: source,
      language: cpp,
      patternMap: {
        r'".*"': const TextStyle(color: Colors.white),
        r'[a-zA-Z0-9]+\(.*\)': const TextStyle(color: Colors.white),
        r'^\s*//.*$':
            const TextStyle(color: Colors.grey), // Single-line comment
        r'/\*[\s\S]*?\*/':
            const TextStyle(color: Colors.grey), // Multi-line comment
      },
      stringMap: theme,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 22,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: AppColors.primary,
        title: Text(
          "Code",
          style: TextStyle(
            fontFamily: 'PragatiNarrow',
            fontSize: 26.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _download();
            },
            child: const Icon(
              Icons.file_download_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          GestureDetector(
            onTap: () {
              _share();
            },
            child: const Icon(
              Icons.share,
              color: Colors.white,
              size: 22,
            ),
          ),
          PopupMenuButton<String>(
            color: Colors.white,
            iconColor: Colors.white,
            onSelected: (String value) {
              setState(() {
                _selectedLanguage = value;
                if (value == 'C++') {
                  _codeController?.language = cpp;
                  _selectedLanguage = "C++";
                } else if (value == 'Java') {
                  _codeController?.language = java;
                  _selectedLanguage = "Java";
                } else if (value == 'Python') {
                  _codeController?.language = python;
                  _selectedLanguage = "Python";
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'C++',
                child: Text('C++'),
              ),
              const PopupMenuItem<String>(
                value: 'Java',
                child: Text('Java'),
              ),
              const PopupMenuItem<String>(
                value: 'Python',
                child: Text('Python'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: CodeField(
          onChanged: (String text) {
            if (text == '(') {
              _addClosingBracket();
            }
          },
          controller: _codeController!,
          cursorColor: AppColors.primary,
          textStyle: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: AppColors.primary,
        onPressed: () async {
          print("Code:");
          print(_codeController?.text);
          String encodedCode = Uri.encodeComponent(_codeController!.text);
          print(encodedCode);
          var response =
              await api.compileCode(encodedCode, "", _selectedLanguage);
          _showOutputBottomSheet(response);
        },
        child: const Icon(
          Icons.play_arrow_sharp,
        ),
      ),
    );
  }

  void _addClosingBracket() {
    setState(() async {
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('That is correct!'),
              content: const Text('13 is the right answer.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
    });
  }
}
