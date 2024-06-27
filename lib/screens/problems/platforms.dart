import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/screens/problems/AC/ac.dart';

import '../../utils/colors.dart';
import 'LC/ProblemsTopics.dart';

class Platforms extends StatefulWidget {
  const Platforms({super.key});

  @override
  State<Platforms> createState() => _PlatformsState();
}

class _PlatformsState extends State<Platforms> {

  final List<Map<String, String>> platformsList = [
    {
      "image" : "assets/problems/algochief_logo.png",
      "title" : "AlgoChief"
    },
    {
      "image" : "assets/problems/codeforces_logo.png",
      "title" : "Codeforces"
    },
    {
      "image" : "assets/problems/leetcode_logo.jpg",
      "title" : "Leetcode"
    },
    {
      "image" : "assets/problems/codechef_logo.png",
      "title" : "Codechef"
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
              Center(
                child: Text(
                  'Platforms',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 40.sp,
                      fontFamily: 'PragatiNarrow',
                      color: Colors.white),
                ),
              ),
              Image.asset(
                'assets/problems/platforms.png',
                width: 400.w,
                height: 260.h,
              ),
              GridView.builder(shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.h,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: platformsList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> platform = platformsList[index];
                    return GestureDetector(
                      onTap: () {
                        if(platform['title'] == 'AlgoChief'){
                          Get.to(() => const AlgoChief());
                        } else if(platform['title'] == 'Codeforces'){
                        } else if(platform['title'] == 'Leetcode'){
                          Get.to(() => const ProblemsTopics());
                        } else if(platform['title'] == 'Codechef'){
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16.r)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                platform["image"],
                                width: platform["title"] == "Codechef" ? 140.w: 60.w,
                                height: 60.h,
                            ),
                            Text(
                                platform["title"],
                                style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22.sp,
                                fontFamily: 'PragatiNarrow',
                                color: Colors.black87,
                                // height: 1.2,
                              ),
                            )
                          ],
                        )
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
