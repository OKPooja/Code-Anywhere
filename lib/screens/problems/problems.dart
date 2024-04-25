import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/screens/problems/problem_description.dart';
import 'package:project/utils/colors.dart';

class Problems extends StatefulWidget {
  final String category;
  final List<dynamic> problemsList;
  const Problems({Key? key, required this.category, required this.problemsList})
      : super(key: key);

  @override
  State<Problems> createState() => _ProblemsState();
}

class _ProblemsState extends State<Problems> {
  List<dynamic> problemsList = [];

  List<Map<String, dynamic>> problemDataList = [
    {
      'problem': 'Largest element in an array',
      'solved': true,
      'bookmarked': false,
    },
    {
      'problem': 'Smallest element in an array',
      'solved': false,
      'bookmarked': true,
    },
    {
      'problem': 'Merge two sorted arrays',
      'solved': true,
      'bookmarked': true,
    },
    {
      'problem': 'Reverse an array',
      'solved': true,
      'bookmarked': false,
    },
    {
      'problem': 'Find the missing number in an array',
      'solved': false,
      'bookmarked': false,
    },
    {
      'problem': 'Remove duplicates from a sorted array',
      'solved': true,
      'bookmarked': true,
    },
    {
      'problem': 'Count frequency of elements in an array',
      'solved': false,
      'bookmarked': false,
    },
    {
      'problem': 'Rotate an array',
      'solved': false,
      'bookmarked': true,
    },
    {
      'problem': 'Find maximum sum subarray',
      'solved': true,
      'bookmarked': false,
    },
    {
      'problem': 'Search in a rotated sorted array',
      'solved': false,
      'bookmarked': true,
    },
    {
      'problem': 'Find common elements in multiple arrays',
      'solved': true,
      'bookmarked': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    problemsList = problemDataList;
    problemsList = widget.problemsList;
    if(problemsList.isEmpty){
      problemsList = problemDataList;
    }
    print("Here is the problems list");
    print(problemsList[0]['solved']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          widget.category,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.w),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    problemsList.length >= 100 ? 100 : problemsList.length,
                //itemCount: problemDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Get.to(() => ProblemDescription(problemDesc: problemsList[index],));
                    },
                    child: Card(
                      color: const Color(0xFFECF7FD),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                problemsList[index]['problem_name'],
                                //problemDataList[index]['problem'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22.sp,
                                  fontFamily: 'PragatiNarrow',
                                  color: AppColors.primary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                    problemsList[index]['solved']
                                        ? Icons.check_circle
                                        : Icons.circle,
                                        color: problemsList[index]['solved']
                                        ? Colors.green
                                        : Colors.transparent,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      problemsList[index]['bookmarked'] =
                                      !problemsList[index]['bookmarked'];
                                    });
                                  },
                                  child: Icon(
                                    problemsList[index]['bookmarked']
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: problemsList[index]['bookmarked']
                                        ? Colors.black87
                                        : Colors.black87,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
