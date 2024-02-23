import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/java.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/darcula.dart';

import '../../utils/colors.dart';

class CodeInputScreen extends StatefulWidget {
  const CodeInputScreen({Key? key}) : super(key: key);

  @override
  _CodeInputScreenState createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  CodeController? _codeController;
  Map<String, TextStyle>? theme = monokaiSublimeTheme;
  String _selectedLanguage = 'C++';

  @override
  Widget build(BuildContext context) {
    const source = "void main() {\n    cout<<\"Hello, world!\";\n}";
    _codeController = CodeController(
      text: source,
      language: cpp,
      patternMap: {
        r'".*"': const TextStyle(color: Colors.white),
        r'[a-zA-Z0-9]+\(.*\)': const TextStyle(color: Colors.white),
      },
      stringMap: {
        "void": const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFEF9A9A)),
        "cout": const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFF9C4)),
      },
    );

    return Scaffold(
      backgroundColor: Color(0xFF212121),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
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
            fontSize: 30.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
            GestureDetector(
              onTap: (){

              },
              child: Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: (String value) {
              setState(() {
                _selectedLanguage = value;
                if (value == 'C++') {
                  _codeController?.language = cpp;
                } else if (value == 'Java') {
                  _codeController?.language = java;
                } else if (value == 'Python') {
                  _codeController?.language = python;
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
          controller: _codeController!,
          cursorColor: AppColors.primary,
          textStyle: const TextStyle(fontFamily: 'Nunito', fontSize: 20,),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: AppColors.primary,
        onPressed: () {},
        child: const Icon(
          Icons.play_arrow_sharp,
        ),
      ),
    );
  }
}
