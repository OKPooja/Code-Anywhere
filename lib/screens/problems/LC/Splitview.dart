import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:split_view/split_view.dart';
import '../../../api.dart';
import '../../../shared_preferences_helper.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/custom_toast.dart';
import '../../compiler/compiler.dart';
import '../submissions.dart';

class SplitViewScreen extends StatefulWidget {
  final Map<String, dynamic> problemDesc;
  const SplitViewScreen({Key? key, this.title, required this.problemDesc}) : super(key: key);

  final String? title;

  @override
  _SplitViewScreenState createState() => _SplitViewScreenState();
}

class _SplitViewScreenState extends State<SplitViewScreen> {
  late final Map<String, dynamic> problemDesc;
  String description = '';
  List<String> examples = [];
  List<String> constraints = [];
  String userId = "";
  String problemId = "";

  @override
  void initState() {
    super.initState();
    problemDesc = widget.problemDesc;
    userId = SharedPreferencesHelper.getUserId();
    problemId = problemDesc['_id'];
    print("Problem id: ");
    print(problemId);
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

    // print("Split data: ");
    // print('Description:\n$description\n');
    // print('Examples:\n$examples\n');
    // print('Constraints:\n$constraints\n');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: true,
      ),
      body: SplitView(
        viewMode: SplitViewMode.Vertical,
        indicator: const SplitIndicator(viewMode: SplitViewMode.Vertical),
        activeIndicator: const SplitIndicator(
          viewMode: SplitViewMode.Vertical,
          isActive: true,
        ),
        controller: SplitViewController(limits: [null, WeightLimit(max: 0.9, min: 0.1)]),
        onWeightChanged: (w) => print("Vertical $w"),
        gripColor: Colors.black87,
        gripColorActive: Colors.grey,
        gripSize: 8,
        children: [
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    height: 40.h,
                    color: const Color(0xffFFE5E5),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              customButton(
                                icon: Icons.play_arrow,
                                text: 'Code',
                                onTap: () {
                                },
                              ),
                              verticalDivider(),
                              customButton(
                                icon: Icons.file_upload_outlined ,
                                text: 'Submit',
                                onTap: () {},
                              ),
                              verticalDivider(),
                              customButton(
                                icon: Icons.access_time_outlined ,
                                text: 'Submissions',
                                onTap: () {
                                  Get.to(() => SubmissionsScreen(problemId: problemId, userId: userId, problemName: problemDesc['problem_name']));
                                },
                              ),
                            ],
                          ),
                          customButton(
                            icon: Icons.check_circle ,
                            text: '',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
              
                        SizedBox(height: 10.h),
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
                                    onTap: () async{
                                      var result = await api.markBookmarked(problemDesc['problem_name']);
                                      if(result['status'] == 'success'){
                                        showCustomToast(context: context, message: "Bookmarked status updated successfully");
                                      }
                                      setState(() {
                                        problemDesc['bookmarked'] = !problemDesc['bookmarked'];
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
                ],
              ),
            ),
          ),
          const CodeInputScreen()
        ],
      ),
    );
  }
}