import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Category> categories = [
    Category(
        title: 'Data Structures and \nAlgorithms',
        image: 'assets/home/dsa.png'),
    Category(title: 'Competitive \nProgramming', image: 'assets/home/cp.png'),
    Category(
        title: 'Data Structures and \nAlgorithms',
        image: 'assets/home/dsa.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        backgroundColor: AppColors.primary,
          body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),

              ///Appbar
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hey User!',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 38.sp,
                              color: Colors.white,
                              fontFamily: 'PragatiNarrow'),
                        ),
                        Text(
                          'Let’s start learning!',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 22.sp,
                              color: Colors.black,
                              fontFamily: 'Nunito'),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/home/dummy_profile.png',
                      width: 80.w,
                      height: 90.h,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              ///Categories
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: Text(
                  'Categories',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 38.sp,
                      color: Colors.white,
                      fontFamily: 'PragatiNarrow'),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: SizedBox(
                  height: 250.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w, left: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 150.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(categories[index].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              categories[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontFamily: 'PragatiNarrow'),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: 500,
                width: double.infinity,
                decoration:  BoxDecoration(
                  //color: AppColors.primary,
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(
                    //     'Topics',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: 30.sp,
                    //         color: Colors.black,
                    //         fontFamily: 'PragatiNarrow',
                    //     ),
                    //   ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          'assets/home/card.png',
                          width: 330.w,
                        ),
                        Positioned(
                          left: 20.w,
                          top: 15.h,
                          child: Text(
                            'Arrays',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 45.sp,
                                color: Colors.white,
                                fontFamily: 'PragatiNarrow'),
                          ),
                        ),
                        Positioned(
                          left: 20.w,
                          top: 60.h,
                          child: Text(
                            'Start learning',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25.sp,
                                color: Colors.white,
                                fontFamily: 'PragatiNarrow'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          'assets/home/card.png',
                          width: 330.w,
                        ),
                        Positioned(
                          left: 20.w,
                          top: 15.h,
                          child: Text(
                            'Strings',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 45.sp,
                                color: Colors.white,
                                fontFamily: 'PragatiNarrow'),
                          ),
                        ),
                        Positioned(
                          left: 20.w,
                          top: 60.h,
                          child: Text(
                            'Start learning',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25.sp,
                                color: Colors.white,
                                fontFamily: 'PragatiNarrow'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),),),
    );
  }
}

class Category {
  final String title;
  final String image;

  Category({required this.title, required this.image});
}
