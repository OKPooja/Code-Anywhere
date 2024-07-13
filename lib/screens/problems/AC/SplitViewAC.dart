import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:split_view/split_view.dart';
import '../../../models/descACProblem.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_header.dart';
import '../../compiler/compiler.dart';

class SplitViewACScreen extends StatefulWidget {
  final ProblemDesc? problemDesc;
  final String problemName;
  const SplitViewACScreen(
      {Key? key,
      this.title,
      required this.problemDesc,
      required this.problemName})
      : super(key: key);

  final String? title;

  @override
  _SplitViewACScreenState createState() => _SplitViewACScreenState();
}

class _SplitViewACScreenState extends State<SplitViewACScreen> {
  ProblemDesc? problem;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    problem = widget.problemDesc;
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
          widget.problemName,
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
        controller: SplitViewController(
            limits: [null, WeightLimit(max: 0.9, min: 0.1)]),
        onWeightChanged: (w) => print("Vertical $w"),
        gripColor: Colors.black87,
        gripColorActive: Colors.grey,
        gripSize: 8,
        children: [
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child:
              problem != null?
              SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                height: 40.h,
                                color: const Color(0xffFFE5E5),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          customButton(
                                            icon: Icons.play_arrow,
                                            text: 'Code',
                                            onTap: () {
                                              Get.back();
                                            },
                                          ),
                                          verticalDivider(),
                                          customButton(
                                            icon: Icons.file_upload_outlined,
                                            text: 'Submit',
                                            onTap: () {},
                                          ),
                                          verticalDivider(),
                                          customButton(
                                            icon: Icons.access_time_outlined,
                                            text: 'Submissions',
                                            onTap: () {},
                                          ),
                                        ],
                                      ),
                                      customButton(
                                        icon: Icons.check_circle,
                                        text: '',
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Description',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'PragatiNarrow',
                                            fontSize: 28.sp,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Rating:',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'PragatiNarrow',
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              problem!.rating,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'PragatiNarrow',
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      problem!.description,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    const Text(
                                      'Input Format:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      problem!.inputFormat,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    const Text(
                                      'Output Format:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      problem!.outputFormat,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Center(
                          child: Text("Problem details not available")),
            ),
          ),
          const CodeInputScreen()
        ],
      ),
    );
  }
}
