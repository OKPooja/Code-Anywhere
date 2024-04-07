import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project/screens/learning_section/topics.dart';
import 'package:project/screens/problems/problems.dart';
import 'package:project/utils/colors.dart';

class ProblemsTopics extends StatelessWidget {
   ProblemsTopics({Key? key}) : super(key: key);

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
      'title': 'Maps',
      'description':
      'A map is an object that maps keys to values. A map cannot contain duplicate keys..',
    },
    {
      'title': 'Sets',
      'description':
      'A set is an unordered collection of unique items. Sets do not allow duplicates..',
    },
    {
      'title': 'Queues',
      'description':
      'A queue orders its elements in a specific order. Queues typically follow the FIFO (First In First Out) order..',
    },
    {
      'title': 'Stacks',
      'description':
      'A stack is a collection that follows the LIFO (Last In First Out) principle..',
    },
  ];

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
                      Get.to(() => Problems(category: dataList[index]['title']!));
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
                                  value: 0.1,
                                  color: AppColors.primary,
                                  backgroundColor: const Color(0xFFC4C8F8),
                                  strokeWidth: 8.0,
                                ),
                                SizedBox(width: 12.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataList[index]['title']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 28.sp,
                                        fontFamily: 'PragatiNarrow',
                                        color: Colors.black87,
                                        height: 1.2,
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
