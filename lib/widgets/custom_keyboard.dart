// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class Keyboard extends StatefulWidget {
//   const Keyboard({super.key});
//
//   @override
//   State<Keyboard> createState() => _KeyboardState();
// }
//
// class _KeyboardState extends State<Keyboard> {
//   final focusNode = FocusNode();
//   final TextEditingController textEditingController = TextEditingController();
//   bool isKeyboardVisible = false;
//
//   @override
//   void initState() {
//     super.initState();
//     focusNode.addListener(() {
//       setState(() {
//         isKeyboardVisible = focusNode.hasFocus;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     focusNode.dispose();
//     textEditingController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Keyboard'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20),
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20)
//                       .copyWith(top: 30, bottom: 20),
//                   child: TextField(
//                     focusNode: focusNode,
//                     controller: textEditingController,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       hintText: 'Type here...',
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                       fillColor: Colors.white.withOpacity(0.08),
//                       filled: true,
//                     ),
//                     onTap: () {
//                       setState(() {
//                         isKeyboardVisible = !isKeyboardVisible;
//                         if (isKeyboardVisible) {
//                           FocusScope.of(context).requestFocus(FocusNode());
//                         }
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             Visibility(
//               visible: isKeyboardVisible,
//               child: Container(
//                 color: Colors.grey.shade800,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     _buildKeyboardRow(['0','1', '2', '3', '4', '5', '6', '7', '8', '9']),
//                     _buildKeyboardRow(['{', '}', '[', ']', '(', ')', '<', '>', '.', ';']),
//                     _buildKeyboardRow(['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p']),
//                     _buildKeyboardRow(['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', '"']),
//                     _buildKeyboardRow(['!', 'z', 'x', 'c', 'v', 'b', 'n', 'm', '|', '&']),
//
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 4,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           buildButton(label: '#',),
//                           buildButton(label: '+', ),
//                           buildButton(label: '=', ),
//                           buildButton(label: '-', ),
//                           buildButton(label: 'Space', iconData: Icons.space_bar),
//                           buildButton(label: '_', ),
//                           buildButton(label: 'Shift', iconData: Icons.arrow_upward),
//                           buildButton(label: 'Backspace', iconData: Icons.backspace),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
//
//   ///button keyboard row
//   _buildKeyboardRow(List<String> rowValues) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
//       child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: rowValues.map((e) => buildButton(label: e)).toList()),
//     );
//   }
//
//   ///button design
//   InkWell buildButton({required String label, IconData? iconData}) {
//     return InkWell(
//       onTap: () {
//         _onButtonTap(label);
//       },
//       child: Material(
//         color: Colors.grey.shade200,
//         borderRadius: BorderRadius.circular(2),
//         elevation: 2,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade200,
//             borderRadius: BorderRadius.circular(8)
//           ),
//           child: iconData != null
//               ? Icon(
//             iconData,
//             size: 18,
//             color: Colors.black,
//           )
//               : Text(
//             label,
//             style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//                 fontFamily: 'Nunito',
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   ///on button tap
//   _onButtonTap(var value) {
//     setState(() {
//       if (value == 'Backspace') {
//         if (textEditingController.text.isNotEmpty) {
//           textEditingController.text = textEditingController.text
//               .substring(0, textEditingController.text.length - 1);
//         }
//       } else if (value == 'Enter') {
//         final int cursorPosition = textEditingController.selection.baseOffset;
//         textEditingController.text = '${textEditingController.text.substring(0, cursorPosition)}\n${textEditingController.text.substring(cursorPosition)}';
//         textEditingController.selection = TextSelection.fromPosition(
//             TextPosition(offset: cursorPosition + 1));
//       } else if (value == "Space") {
//         textEditingController.text += " ";
//       } else {
//         textEditingController.text += value;
//       }
//     });
//   }
// }
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';

class Keyboard extends StatefulWidget {
  final CodeController? codeController;
  const Keyboard({super.key, this.codeController});

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  final focusNode = FocusNode();
  bool isKeyboardVisible = false;
  CodeController? _codeController;


  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Visibility(
          visible: isKeyboardVisible,
          child: Container(
            color: Colors.grey.shade800,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildKeyboardRow(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']),
                _buildKeyboardRow(['{', '}', '[', ']', '(', ')', '<', '>', '.', ';']),
                _buildKeyboardRow(['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p']),
                _buildKeyboardRow(['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', '"']),
                _buildKeyboardRow(['!', 'z', 'x', 'c', 'v', 'b', 'n', 'm', '|', '&']),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton(label: '#'),
                      buildButton(label: '+'),
                      buildButton(label: '='),
                      buildButton(label: '-'),
                      buildButton(label: 'Space', iconData: Icons.space_bar),
                      buildButton(label: '_'),
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
    );
  }

  _buildKeyboardRow(List<String> rowValues) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowValues.map((e) => buildButton(label: e)).toList(),
      ),
    );
  }

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
            borderRadius: BorderRadius.circular(8),
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

  _onButtonTap(String value) {
    setState(() {
      final int cursorPosition = widget.codeController!.selection.baseOffset;
      final String currentText = widget.codeController!.text;

      if (value == 'Backspace') {
        if (currentText.isNotEmpty && cursorPosition > 0) {
          final newText = currentText.substring(0, cursorPosition - 1) +
              currentText.substring(cursorPosition);
          widget.codeController!.text = newText;
          widget.codeController!.selection = TextSelection.fromPosition(
            TextPosition(offset: cursorPosition - 1),
          );
        }
      } else if (value == 'Enter') {
        final newText = '${currentText.substring(0, cursorPosition)}\n${currentText.substring(cursorPosition)}';
        widget.codeController!.text = newText;
        widget.codeController!.selection = TextSelection.fromPosition(
          TextPosition(offset: cursorPosition + 1),
        );
      } else if (value == "Space") {
        final newText = '${currentText.substring(0, cursorPosition)} ${currentText.substring(cursorPosition)}';
        widget.codeController!.text = newText;
        widget.codeController!.selection = TextSelection.fromPosition(
          TextPosition(offset: cursorPosition + 1),
        );
      } else {
        final newText = currentText.substring(0, cursorPosition) +
            value +
            currentText.substring(cursorPosition);
        widget.codeController!.text = newText;
        widget.codeController!.selection = TextSelection.fromPosition(
          TextPosition(offset: cursorPosition + value.length),
        );
      }
    });
  }
}
