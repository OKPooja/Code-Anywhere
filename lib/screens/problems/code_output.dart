import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/shared_preferences_helper.dart';
import 'package:project/widgets/custom_header.dart';
import '../../models/submissionsModel.dart';
import '../../utils/colors.dart';

class CodeOutput extends StatelessWidget {
  final SubmissionsData submission;
  final String problemName;

  const CodeOutput({super.key, required this.problemName, required this.submission});

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Copied to clipboard')),
      // );
    });
  }
  String formatTimestamp(String? timestamp) {
    if (timestamp == null) return '';
    DateTime dateTime = DateTime.parse(timestamp);
    String date = DateFormat.yMMMd().format(dateTime);
    String time = DateFormat.Hm().format(dateTime);
    return '$date $time';
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
          problemName,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'PragatiNarrow',
            fontWeight: FontWeight.w700,
            fontSize: 28.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        submission.verdict ?? '',
                        style: TextStyle(
                            color: submission.verdict == 'Accepted' ? Colors.green: Colors.redAccent,
                            fontFamily: 'Lato',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w800
                        ),
                      ),
                      SizedBox(height: 3.h,),
                      Row(
                        children: [
                          Text(
                            SharedPreferencesHelper.getUserName(),
                            style: TextStyle(
                              color: Colors.grey.shade200,
                              fontFamily: 'Lato',
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            ' submitted at ',
                            style: TextStyle(
                              color: Colors.grey.shade200,
                              fontFamily: 'Lato',
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            formatTimestamp(submission.timestamp),
                            style: TextStyle(
                              color: Colors.grey.shade200,
                              fontFamily: 'Lato',
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Code',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      verticalDivider(),
                      SizedBox(width: 10.w,),
                      Text(
                        submission.language ?? '',
                        style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Nunito',
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      if (submission.code != null) {
                        _copyToClipboard(context, Uri.decodeComponent(submission.code!));
                      }
                    },
                    icon: Icon(
                        Icons.copy_sharp,
                        size: 18.sp,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Uri.decodeComponent(submission.code!) ?? '',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h,),
              Text(
                'Output',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 10.h,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    submission.output ?? '',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      ),
    );
  }
}
