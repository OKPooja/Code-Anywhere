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
    Category(title: 'Data Structures and \nAlgorithms', image: 'assets/home/dsa.png'),
    Category(title: 'Competitive \nProgramming', image: 'assets/home/cp.png'),
    Category(title: 'Data Structures and \nAlgorithms', image: 'assets/home/dsa.png'),
  ];
  //
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Appbar
                Row(
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
                            fontFamily: 'PragatiNarrow'
                          ),
                        ),
                        Text(
                          'Let’s start learning!',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22.sp,
                            color: Colors.black,
                            fontFamily: 'Nunito'
                          ),
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
                SizedBox(height: 20.h,),
                ///Categories
                Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 38.sp,
                    color: Colors.white,
                    fontFamily: 'PragatiNarrow'
                  ),
                ),
                SizedBox(height: 10.h,),
                SizedBox(
                  height: 300.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0),
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
              ],
            ),
          )
        )
      ),
    );
  }
}
class Category {
  final String title;
  final String image;

  Category({required this.title, required this.image});
}
