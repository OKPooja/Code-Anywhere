import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/python.dart';
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

  @override
  Widget build(BuildContext context) {
    const source = "void main() {\n    print(\"Hello, world!\");\n}";
    _codeController = CodeController(
      text: source,
      language: dart,
      patternMap: {
        r'".*"': const TextStyle(color: Colors.white),
        r'[a-zA-Z0-9]+\(.*\)': const TextStyle(color: Colors.white),
      },
      stringMap: {
        "void": const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFEF9A9A)),
        "print": const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFF9C4)),
      },
    );

    return Scaffold(
      backgroundColor: Color(0xFF212121) ,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
            "Code",
            style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 30.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: CodeField(
          //background: Colors.white10,
          controller: _codeController!,
          cursorColor: AppColors.primary,
          textStyle: const TextStyle(fontFamily: 'Nunito', fontSize: 20,),
          // lineNumberStyle: const LineNumberStyle(
          //     textStyle: TextStyle(fontFamily: 'Nunito', fontSize: 20, color: Colors.black),
          // ),
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