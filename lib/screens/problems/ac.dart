import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project/screens/problems/problems.dart';
import 'package:project/utils/colors.dart';

import '../../api.dart';

class AlgoChief extends StatefulWidget {
  const AlgoChief({super.key});

  @override
  State<AlgoChief> createState() => _AlgoChiefState();
}

class _AlgoChiefState extends State<AlgoChief> {
  final List<Map<String, String>> dataList = [
    {
      'title': 'Binary Search',
      'description':
          'Efficiently finds the position of a target value within a sorted array.',
    },
    {
      'title': 'Hashing',
      'description':
          'Transforms data into a fixed-size value, usually for fast data retrieval.',
    },
    {
      'title': 'Two Pointers',
      'description':
          'Uses two indices to traverse data structures for solving various problems.',
    },
    {
      'title': 'Math',
      'description':
          'Involves mathematical concepts and techniques to solve computational problems.',
    },
    {
      'title': 'Greedy',
      'description':
          'Makes the locally optimal choice at each stage to find a global optimum.',
    },
    {
      'title': 'Graphs',
      'description':
          'Represents relationships between pairs of objects using nodes and edges.',
    },
    {
      'title': 'Sorting',
      'description':
          'Arranges elements in a particular order, typically ascending or descending.',
    },
    {
      'title': 'DP',
      'description':
          'Solves problems by breaking them down into simpler subproblems using recursion and memoization.',
    },
    {
      'title': 'Data Structures',
      'description':
          'Organizes and stores data efficiently for various operations and algorithms.',
    },
  ];
  List<dynamic> list = [];
  List<dynamic> hashing = [];
  List<dynamic> twoPointers = [];
  List<dynamic> bs = [];
  List<dynamic> math = [];
  List<dynamic> greedy = [];
  List<dynamic> graphs = [];
  List<dynamic> sorting = [];
  List<dynamic> dp = [];
  List<dynamic> ds = [];

  @override
  void initState() {
    initializePrefs();
    super.initState();
  }
  initializePrefs () async {
    hashing = await api.getAlgoChiefProblems(tag: "Hashing");
    twoPointers = await api.getAlgoChiefProblems(tag: "Two Pointers");
    bs = await api.getAlgoChiefProblems(tag: "Binary Search");
    math = await api.getAlgoChiefProblems(tag: "Math");
    greedy = await api.getAlgoChiefProblems(tag: "Greedy");
    graphs = await api.getAlgoChiefProblems(tag: "Graphs");
    sorting = await api.getAlgoChiefProblems(tag: "Sortings");
    ds = await api.getAlgoChiefProblems(tag: "Data Structures");
    dp = await api.getAlgoChiefProblems(tag: "DP");

    print(ds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined,
              color: Colors.white, size: 20),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: AppColors.primary,
        title: Text(
          "AlgoChief",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 28.sp,
            fontFamily: 'PragatiNarrow',
            color: Colors.white,
            // height: 1.2,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.sp, top: 10.sp),
            child: Image.asset(
              "assets/problems/algochief_logo.png",
              width: 80,
              height: 50,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.h,
                childAspectRatio: 1.5,
              ),
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    List<dynamic> problems = [];
                    if(dataList[index]['title'] == 'Hashing'){
                      problems = hashing;
                    } else if(dataList[index]['title'] == 'Two Pointers'){
                      problems = twoPointers;
                    } else if(dataList[index]['title'] == 'Binary Search'){
                      problems = bs;
                    } else if(dataList[index]['title'] == 'Math'){
                      problems = math;
                    } else if(dataList[index]['title'] == 'Greedy'){
                      problems = greedy;
                    } else if(dataList[index]['title'] == 'Graphs'){
                      problems = graphs;
                    } else if(dataList[index]['title'] == 'Sorting'){
                      problems = sorting;
                    } else if(dataList[index]['title'] == 'Data Structures'){
                      problems = ds;
                    } else if(dataList[index]['title'] == 'DP'){
                      problems = dp;
                    }
                    Get.to(() => Problems(category: dataList[index]['title']!, problemsList: problems));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  dataList[index]['title']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.sp,
                                    fontFamily: 'PragatiNarrow',
                                    color: Colors.black87,
                                    height: 1.2,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 12.h),
                              CircularProgressIndicator(
                                value: 0.2,
                                color: AppColors.progressColor,
                                backgroundColor: Colors.white,
                                strokeWidth: 8.0,
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  dataList[index]['description']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 15.sp,
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    height: 1.0,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
