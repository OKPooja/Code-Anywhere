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
import 'package:share_plus/share_plus.dart';
import '../../api.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_toast.dart';

class DummyCodeScreen extends StatefulWidget {
  const DummyCodeScreen({Key? key}) : super(key: key);

  @override
  _DummyCodeScreenState createState() => _DummyCodeScreenState();
}

class _DummyCodeScreenState extends State<DummyCodeScreen> {
  CodeController? _codeController;
  //Map<String, TextStyle>? theme = monokaiSublimeTheme;
  String _selectedLanguage = 'C++';
  TextEditingController inputTextController = TextEditingController();
  bool isKeyboardVisible = false;
  final focusNode = FocusNode();

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
    focusNode.addListener(() {
      setState(() {
        isKeyboardVisible = focusNode.hasFocus;
      });
    });
  }
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
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
        if (fileName!.isNotEmpty) {
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
                showCustomToast(
                    context: context, message: "Now, click on Run button!");
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

  void _executeCode() async {
    print("Code:");
    print(_codeController?.text);
    print("Input:");
    print(inputTextController.text);
    if (inputTextController.text.isEmpty) {
      inputTextController.text = '';
    }
    String encodedCode = Uri.encodeComponent(_codeController!.text);
    print(encodedCode);
    var response = await api.compileCode(
        encodedCode, inputTextController.text, _selectedLanguage);
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
        child: Column(
          children: [
            CodeField(
              onTap: () {
                setState(() {
                  isKeyboardVisible = !isKeyboardVisible;
                  if (isKeyboardVisible) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                });
              },
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
            Visibility(
              visible: isKeyboardVisible,
              child: Container(
                color: Colors.grey.shade800,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildKeyboardRow(['0','1', '2', '3', '4', '5', '6', '7', '8', '9']),
                    _buildKeyboardRow(['{', '}', '[', ']', '(', ')', '<', '>', '.', ';']),
                    _buildKeyboardRow(['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p']),
                    _buildKeyboardRow(['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', '"']),
                    _buildKeyboardRow(['!', 'z', 'x', 'c', 'v', 'b', 'n', 'm', '|', '&']),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildButton(label: '#',),
                          buildButton(label: '+', ),
                          buildButton(label: '=', ),
                          buildButton(label: '-', ),
                          buildButton(label: 'Space', iconData: Icons.space_bar),
                          buildButton(label: '_', ),
                          buildButton(label: 'Shift', iconData: Icons.arrow_upward),
                          buildButton(label: 'Backspace', iconData: Icons.backspace),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primary,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white,
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
              icon: Icon(Icons.input_outlined), label: 'Input'),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow_sharp), label: 'Run')
        ],
      ),
    );
  }
  ///button keyboard row
  _buildKeyboardRow(List<String> rowValues) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rowValues.map((e) => buildButton(label: e)).toList()),
    );
  }

  ///button design
  InkWell buildButton({required String label, IconData? iconData}) {
    return InkWell(
      onTap: () {
        _onButtonTap(label);
      },
      child: Material(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(2),
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8)
          ),
          child: iconData != null
              ? Icon(
            iconData,
            size: 18,
            color: Colors.black,
          )
              : Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ),
    );
  }


  ///on button tap
  _onButtonTap(var value) {
    // setState(() {
    //   if (value == 'Backspace') {
    //     if (_codeController?.isNotEmpty) {
    //       textEditingController.text = textEditingController.text
    //           .substring(0, textEditingController.text.length - 1);
    //     }
    //   } else if (value == 'Enter') {
    //     final int cursorPosition = textEditingController.selection.baseOffset;
    //     textEditingController.text = '${textEditingController.text.substring(0, cursorPosition)}\n${textEditingController.text.substring(cursorPosition)}';
    //     textEditingController.selection = TextSelection.fromPosition(
    //         TextPosition(offset: cursorPosition + 1));
    //   } else if (value == "Space") {
    //     textEditingController.text += " ";
    //   } else {
    //     textEditingController.text += value;
    //   }
    // });
  }
}
