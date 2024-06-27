import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project/shared_preferences_helper.dart';
import 'package:project/widgets/custom_toast.dart';
import '../../../api.dart';
import '../../../models/descACProblem.dart';
import '../../../utils/colors.dart';
import 'fetchProblems.dart';

class ACProblemDescription extends StatefulWidget {
  final String problemName;
  final String problemId;
  const ACProblemDescription({
    Key? key,
    required this.problemName,
    required this.problemId,
  }) : super(key: key);

  @override
  State<ACProblemDescription> createState() => _ProblemDescriptionState();
}

class _ProblemDescriptionState extends State<ACProblemDescription> {
  ProblemDesc? problem;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProblemDetails();
  }

  void fetchProblemDetails() async {
    problem = await fetchDetailedProblem(problemId: widget.problemId);
    setState(() {
      isLoading = false;
    });
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
          'Problem Details',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : problem != null
              ? SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              widget.problemName,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'PragatiNarrow',
                                fontSize: 28.sp,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                 Text(
                                  'Rating:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'PragatiNarrow',
                                    fontSize: 20.sp,
                                  ),
                                ),
                                SizedBox(height: 10.h,),
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
                        SizedBox(height: 16.h,),
                        // const Text(
                        //   'Description:',
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontFamily: 'Lato',
                        //     fontWeight: FontWeight.w800,
                        //     fontSize: 24,
                        //   ),
                        // ),
                        SizedBox(height: 10.h,),
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
                        SizedBox(height: 10.h,),
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
                        SizedBox(height: 10.h,),
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
              )
              : const Center(child: Text("Problem details not available")),
    );
  }
}
