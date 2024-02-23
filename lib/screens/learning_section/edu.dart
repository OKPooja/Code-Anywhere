import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/utils/colors.dart';

class Edu extends StatefulWidget {
  const Edu({super.key});

  @override
  State<Edu> createState() => _EduState();
}

class _EduState extends State<Edu> {
  List<Map<String, String>> dataList = [
    {
      'title': 'Arrays',
      'description':
      'An array is a data structure with elements of the same memory size..',
    },
    {
      'title': 'Lists',
      'description':
      'A list is an ordered collection that allows duplicates and nulls..',
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
      'A queue is a collection that orders its elements in a specific order. Queues typically follow the FIFO (First In First Out) order..',
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
                'Video \nTutorial',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40.sp,
                    fontFamily: 'PragatiNarrow',
                    color: Colors.white
                ),
              ),
              Image.asset(
                'assets/learn/bg.png',
                width: 370.w,
                height: 240.h,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       // Padding(
              //       //   padding: EdgeInsets.only(top: 10.h),
              //       //   child: const Icon(
              //       //     Icons.arrow_back_ios,
              //       //     color: Colors.white,
              //       //     size: 35,
              //       //   ),
              //       // ),
              //       Text(
              //         'Video \nTutorial',
              //         style: TextStyle(
              //           fontWeight: FontWeight.w700,
              //           fontSize: 36.sp,
              //           fontFamily: 'PragatiNarrow',
              //           color: Colors.white
              //         ),
              //       )
              //     ],
              //   ),
              // ),

              Container(
                //height: 550,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 8.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.play_circle,
                                size: 55,
                                color: Color(0XFF29277A),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataList[index]['title']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 36.sp,
                                      fontFamily: 'PragatiNarrow',
                                      color: Colors.black87,
                                      height: 1.2,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    child: Text(
                                      dataList[index]['description']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15.sp,
                                        fontFamily: 'Nunito',
                                        color: Color(0XFF8C8888),
                                        height: 1.0,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10.h),
                          if(index != dataList.length - 1)
                            const Divider(color: Colors.black87, thickness: 1.0)
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 50.h,),
            ],
          ),
        ),
      )
    );
  }
}
