import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/colors.dart';

class ProblemDescription extends StatefulWidget {
  final Map<String, dynamic> problemDesc;
  const ProblemDescription({Key? key, required this.problemDesc})
      : super(key: key);

  @override
  State<ProblemDescription> createState() => _ProblemDescriptionState();
}

class _ProblemDescriptionState extends State<ProblemDescription> {
  late final Map<String, dynamic> problemDesc;
  String description = '';
  List<String> examples = [];
  List<String> constraints = [];

  @override
  void initState() {
    super.initState();
    problemDesc = widget.problemDesc;
    //print(problemDesc['problem_description']);
    splitData();
  }

  void splitData() {
    List<String> lines = problemDesc['problem_description'].split('\n');

    bool desc = true;
    for (int i = 0; i < lines.length; i++) {
      String currentLine = lines[i].trimLeft();
      if (currentLine.startsWith('Example')) {
        desc = false;
        while (!currentLine.startsWith('Constraints') && i < lines.length) {
          currentLine = lines[i].trimLeft();
          examples.add(currentLine);
          i++;
        }
        i -= 2;
      } else if (desc) {
        description += lines[i];
      } else if (currentLine.startsWith('Constraints')) {
        i++;
        while (i < lines.length) {
          String current = lines[i].trimLeft();
          constraints.add(current);
          i++;
        }
        break;
      }
    }

    print("Split data: ");
    print('Description:\n$description\n');
    print('Examples:\n$examples\n');
    print('Constraints:\n$constraints\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          problemDesc['problem_name'],
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'PragatiNarrow',
            fontWeight: FontWeight.w700,
            fontSize: 38,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Description:',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        problemDesc['solved']
                            ? Icons.check_circle
                            : Icons.circle,
                        color: problemDesc['solved']
                            ? Colors.green
                            : Colors.transparent,
                      ),
                      SizedBox(width: 5.w,),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            problemDesc['bookmarked'] =
                            !problemDesc['bookmarked'];
                          });
                        },
                        child: Icon(
                          problemDesc['bookmarked']
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: problemDesc['bookmarked']
                              ? Colors.black87
                              : Colors.black87,
                        ),
                      )
                    ]
                  ),

                ],
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Examples:',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    examples.sublist(0, examples.length - 1).map((example) {
                  return Text(
                    example,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w100,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Constraints:',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: constraints.map((constraint) {
                  return Text(
                    constraint,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w100,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}