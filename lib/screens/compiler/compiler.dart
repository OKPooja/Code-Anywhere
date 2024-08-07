import 'dart:io';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/java.dart';
import 'package:project/screens/compiler/syntax_highlight.dart';
import 'package:share_plus/share_plus.dart';
import '../../api.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_toast.dart';
import 'download_files.dart';

class CodeInputScreen extends StatefulWidget {
  final String userId;
  final String problemId;

  const CodeInputScreen({Key? key, this.userId = "", this.problemId = ""}) : super(key: key);

  @override
  State<CodeInputScreen> createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  CodeController? _codeController;
  //Map<String, TextStyle>? theme = monokaiSublimeTheme;
  String _selectedLanguage = 'C++';
  TextEditingController inputTextController = TextEditingController();

  @override
  void initState() {
    _codeController?.addListener(() {});
    super.initState();
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
  Future<String?> _showInputContainer() {
    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: Text(
            'Enter input',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: Colors.black,
                fontFamily: 'Nunito',
            ),
          ),
          content: TextFormField(
            controller: inputTextController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Input',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: Colors.grey,
                fontFamily: 'Nunito',
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                print(inputTextController.text);
                showCustomToast(context: context, message: "Now, click on Run button!");
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontFamily: 'Nunito',
                ),
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
  _share() async {
    if (kDebugMode) {
      print(_codeController!.text);
    }
    if (_codeController!.text.isNotEmpty) {
      await Share.share(_codeController!.text);
    }
  }
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
  void _executeCode() async {
    print("Code:");
    print(_codeController?.text);
    print("Input:");
    print(inputTextController.text);
    if(inputTextController.text.isEmpty){
      inputTextController.text = '';
    }
    String encodedCode = Uri.encodeComponent(_codeController!.text);
    var response;
    if(widget.userId == "" && widget.problemId == "") {
      print("In compile code");
      response = await api.compileCode(encodedCode, inputTextController.text, _selectedLanguage);
    } else {
      print("In submit code");
      response = await api.submitCode(widget.userId, widget.problemId, encodedCode, _selectedLanguage);
    }
    _showOutputBottomSheet(response);
    inputTextController.text = '';
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
          lineNumbers: true,
          onChanged: (String text) {
            // if (text == '(') {
            //   _addClosingBracket();
            // }
          },
          controller: _codeController!,
          cursorColor: AppColors.primary,
          textStyle: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 20,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primary,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor:  Colors.white,
        selectedItemColor: Colors.white,
        onTap: (index) {
          if (index == 0) {
            _showInputContainer();
          } else if (index == 1) {
            _executeCode();
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.input_outlined
              ),
            label: 'Input'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.play_arrow_sharp
              ),
            label: 'Run'
          )
        ],
      ),
    );
  }
}
