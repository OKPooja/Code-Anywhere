import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project/screens/learning_section/topics.dart';
import 'package:project/screens/problems/problems.dart';
import 'package:project/utils/colors.dart';
import 'dart:math' as math;
import '../../api.dart';

class ProblemsTopics extends StatefulWidget {
   ProblemsTopics({Key? key}) : super(key: key);

  @override
  State<ProblemsTopics> createState() => _ProblemsTopicsState();
}

class _ProblemsTopicsState extends State<ProblemsTopics> {
  List<dynamic> arrays = [];
  List<dynamic> strings = [];
  List<dynamic> trees = [];
  List<dynamic> linkedList = [];
  List<dynamic> greedy = [];
  double progressArrays = 0.0;
  double progressStrings = 0.0;
  double progressTrees = 0.0;
  double progressLinkedList = 0.0;
  double progressGreedy = 0.0;
  double progressStack = 0.0;
  List<Map<String, dynamic>> problemDataList = [
    {
      'problem_name': 'Largest element in an array',
      'solved': true,
      'bookmarked': false,
    },
    {
      'problem_name': 'Smallest element in an array',
      'solved': false,
      'bookmarked': true,
    },
    {
      'problem_name': 'Merge two sorted arrays',
      'solved': true,
      'bookmarked': true,
    },
    {
      'problem_name': 'Reverse an array',
      'solved': true,
      'bookmarked': false,
    },
    {
      'problem_name': 'Find the missing number in an array',
      'solved': false,
      'bookmarked': false,
    },
    {
      'problem_name': 'Remove duplicates from a sorted array',
      'solved': true,
      'bookmarked': true,
    },
    {
      'problem_name': 'Count frequency of elements in an array',
      'solved': false,
      'bookmarked': false,
    },
  ];
  final List<Map<String, String>> dataList = [
    {
      'title': 'Arrays',
      'description':
      'An array is a data structure with elements of the same memory size..',
    },
    {
      'title': 'Strings',
      'description':
      'A string in one line is a sequence of characters enclosed within single or double quotation marks. It can include letters, numbers, symbols, and whitespace characters.',
    },
    {
      'title': 'Trees',
      'description':
      'A queue orders its elements in a specific order. Queues typically follow the FIFO (First In First Out) order..',
    },
    {
      'title': 'Linked List',
      'description':
      'A set is an unordered collection of unique items. Sets do not allow duplicates..',
    },
    {
      'title': 'Greedy',
      'description':
      'Solve greedy problems greedily..',
    },
    {
      'title': 'Stacks',
      'description':
      'A stack is a collection that follows the LIFO (Last In First Out) principle..',
    },
  ];

  @override
  void initState(){
    super.initState();
    initializePrefs();
  }

  initializePrefs()async{
    arrays = await api.fetchProblemsWithDesc("Arrays");
    strings = await api.fetchProblemsWithDesc("Strings");
    trees = await api.fetchProblemsWithDesc("Trees");
    linkedList = await api.fetchProblemsWithDesc("Linked List");
    greedy = await api.fetchProblemsWithDesc("Greedy");

    int count = 0;
    for(int i = 0; i < arrays.length; i++){
      if(arrays[i]['solved'] == true){
        count++;
      }
    }
    progressArrays = count/arrays.length;
    count = 0;
    for(int i = 0; i < strings.length; i++){
      if(strings[i]['solved'] == true){
        count++;
      }
    }
    progressStrings = count/strings.length;
    count = 0;
    for(int i = 0; i < trees.length; i++){
      if(trees[i]['solved'] == true){
        count++;
      }
    }
    progressTrees = count/trees.length;
    count = 0;
    for(int i = 0; i < linkedList.length; i++){
      if(linkedList[i]['solved'] == true){
        count++;
      }
    }
    progressLinkedList = count/linkedList.length;
    count = 0;
    for(int i = 0; i < greedy.length; i++){
      if(greedy[i]['solved'] == true){
        count++;
      }
    }
    progressGreedy = count/greedy.length;
    count = 0;
    for(int i = 0; i < problemDataList.length; i++){
      if(problemDataList[i]['solved'] == true){
        count++;
      }
    }
    progressStack = count/problemDataList.length;
    setState(() {});
  }
  double calcValue(String title){
    double value = 0.0;
    if(title == 'Arrays'){
      value = progressArrays;
    } else if(title == 'Strings'){
      value = progressStrings;
    } else if(title == 'Greedy'){
      value = progressGreedy;
    } else if(title == 'Linked List'){
      value = progressLinkedList;
    } else if(title == 'Trees'){
      value = progressTrees;
    } else if(title == 'Stacks'){
      value = progressStack;
    }
    return value;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Problems',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40.sp,
                    fontFamily: 'PragatiNarrow',
                    color: Colors.white),
              ),
              Image.asset(
                'assets/problems/problem_solving.png',
                width: 370.w,
                height: 240.h,
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
                      if(dataList[index]['title'] == 'Arrays'){
                        problems = arrays;
                      } else if(dataList[index]['title'] == 'Strings'){
                        problems = strings;
                      } else if(dataList[index]['title'] == 'Greedy'){
                        problems = greedy;
                      } else if(dataList[index]['title'] == 'Linked List'){
                        problems = linkedList;
                      } else if(dataList[index]['title'] == 'Trees'){
                        problems = trees;
                      } else if(dataList[index]['title'] == 'Stacks'){
                        problems = problemDataList;
                      }
                      Get.to(() => Problems(category: dataList[index]['title']!, problemsList: problems));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircularProgressIndicator(
                                  value: calcValue(dataList[index]['title']!),
                                  color: AppColors.primary,
                                  backgroundColor: const Color(0xFFC4C8F8),
                                  strokeWidth: 8.0,
                                ),
                                SizedBox(width: 12.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.19,
                                      child: Text(
                                        dataList[index]['title']!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 28.sp,
                                          fontFamily: 'PragatiNarrow',
                                          color: Colors.black87,
                                          height: 1.2,
                                        ),
                                        overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.19,
                                      child: Text(
                                        dataList[index]['description']!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 15.sp,
                                          fontFamily: 'Nunito',
                                          color: Color(0XFF8C8888),
                                          height: 1.0,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
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
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
