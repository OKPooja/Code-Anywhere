import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project/utils/colors.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import '../../api.dart';
import '../../shared_preferences_helper.dart';
import '../../widgets/custom_keyboard.dart';
import '../problems/problems.dart';
import '../profile/getAllFiles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> strings = [];
  List<dynamic> trees = [];
  List<dynamic> arrays = [];


  final List<Category> categories = [
    Category(
        title: 'Data Structures and \nAlgorithms',
        image: 'assets/home/dsa.png'),
    Category(title: 'Competitive \nProgramming', image: 'assets/home/cp.png',),
    Category(
        title: 'Data Structures and \nAlgorithms',
        image: 'assets/home/dsa.png',),
  ];

  @override
  void initState(){
    super.initState();
    initializePrefs();
  }

  initializePrefs()async{
    print("Inside init prefs");
    arrays = await api.fetchProblems("arrays");
    strings = await api.fetchProblems("strings");
    trees = await api.fetchProblems("trees");
    print("Output inside init prefs");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
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
                        'Hey ${SharedPreferencesHelper.getUserName()}',
                        //'Hey User!',
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
                  GestureDetector(
                    onTap: (){
                    },
                    child: Image.asset(
                      'assets/home/dummy_profile.png',
                      width: 80.w,
                      height: 90.h,
                    ),
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
                    fontFamily: 'PragatiNarrow',
                ),
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
                child: GestureDetector(
                  onTap: (){
                    // Get.to(const Keyboard());
                     Get.to(GetAllFiles());
                  },
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
                                  fontFamily: 'PragatiNarrow'
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: 550,
              width: double.infinity,
              decoration: const BoxDecoration(
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
                  GestureDetector(
                    onTap: (){

                      Get.to(() => Problems(category: 'Arrays', problemsList: arrays));
                    },
                    child: Stack(
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
                        ),
                         Positioned(
                          right: 20.w,
                          top: 30.h,
                          child: const SemicircularIndicator(
                            radius: 50,
                            color: Colors.white,
                            backgroundColor: Color(0XFF12223C),
                            strokeWidth: 12,
                            bottomPadding: 0,
                            progress: 0.10,
                            child: Text(
                              '10%',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: 'Nunito'
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => Problems(category: 'Strings', problemsList: strings));
                    },
                    child: Stack(
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
                        ),
                        Positioned(
                          right: 20.w,
                          top: 30.h,
                          child: const SemicircularIndicator(
                            radius: 50,
                            color: Colors.white,
                            backgroundColor: Color(0XFF12223C),
                            strokeWidth: 12,
                            bottomPadding: 0,
                            progress: 0.3,
                            child: Text(
                              '30%',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: 'Nunito'
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => Problems(category: 'Trees', problemsList: trees));
                    },
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/home/card.png',
                          width: 330.w,
                        ),
                        Positioned(
                          left: 20.w,
                          top: 15.h,
                          child: Text(
                            'Trees',
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
                        ),
                        Positioned(
                          right: 20.w,
                          top: 30.h,
                          child: const SemicircularIndicator(
                            radius: 50,
                            color: Colors.white,
                            backgroundColor: Color(0XFF12223C),
                            strokeWidth: 12,
                            bottomPadding: 0,
                            progress: 0.40,
                            child: Text(
                              '40%',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: 'Nunito'
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Category {
  final String title;
  final String image;

  Category({required this.title, required this.image});
}
