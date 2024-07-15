import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/problems/code_output.dart';
import '../../api.dart';
import '../../models/submissionsModel.dart';
import '../../utils/colors.dart';

class SubmissionsScreen extends StatefulWidget {
  final String problemId;
  final String userId;
  final String problemName;

  const SubmissionsScreen({
    super.key,
    required this.problemId,
    required this.userId,
    required this.problemName,
  });

  @override
  State<SubmissionsScreen> createState() => _SubmissionsScreenState();
}

class _SubmissionsScreenState extends State<SubmissionsScreen> {
  List<SubmissionsData>? submissions;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubmissions();
  }

  Future<void> fetchSubmissions() async {
    submissions = await api.getAllSubmissions(widget.userId, widget.problemId);
    setState(() {
      isLoading = false;
    });
  }

  String formatTimestamp(String? timestamp) {
    if (timestamp == null) return '';
    DateTime dateTime = DateTime.parse(timestamp);
    String date = DateFormat.yMMMd().format(dateTime);
    String time = DateFormat.Hm().format(dateTime);
    return '$date\n$time';
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
          widget.problemName,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'PragatiNarrow',
            fontWeight: FontWeight.w700,
            fontSize: 28.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Your Submissions',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w900,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  const Divider(color: Colors.grey, indent: 9, endIndent: 9,),
                  Table(
                    columnWidths: const {
                      0: FixedColumnWidth(100.0),
                      1: FixedColumnWidth(100.0),
                      2: FixedColumnWidth(60.0),
                      3: FixedColumnWidth(150.0),
                    },
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Text(
                              'Language',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Text(
                              'Code',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Text(
                              'When',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey, indent: 9, endIndent: 9,),
                  submissions != null
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: submissions!.length,
                          itemBuilder: (context, index) {
                            SubmissionsData submission = submissions![index];
                            return Table(
                              columnWidths: const {
                                0: FixedColumnWidth(100.0),
                                1: FixedColumnWidth(100.0),
                                2: FixedColumnWidth(60.0),
                                3: FixedColumnWidth(150.0),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.sp),
                                      child: Text(
                                        submission.verdict ?? '',
                                        style: TextStyle(
                                          color: submission.verdict == 'Accepted' ? Colors.green: Colors.redAccent,
                                          fontFamily: 'Lato',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical:8.sp, horizontal: 20.sp),
                                      child: Text(
                                        submission.language ?? '',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Lato',
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.sp),
                                      child: GestureDetector(
                                        onTap: () {
                                          String? code = Uri.decodeComponent(submission.code!);
                                          String? output = submission.output;
                                          Get.to(() => CodeOutput(problemName: widget.problemName, submission: submissions![index],));
                                        },
                                        child: Text(
                                          'View',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Lato',
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.sp),
                                      child: Text(
                                        formatTimestamp(submission.timestamp),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Lato',
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            'No submissions found',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontSize: 24.sp,
                            ),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
