import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project/bottom_nav.dart';
import 'package:project/screens/auth/register.dart';
import 'package:project/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _controller;
  late SharedPreferences _prefs;
  String apiKey = '';
  int currentIndex = 0;
  late int currentPage;
  int indexVal = 0;
  double progress = 1 / content.length;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
    currentPage = 0;
    initializePrefs();
  }

  Future<void> initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefs.setBool('isFirstTime', false);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onChanged(int index) {
    setState(() {
      currentIndex = index;
      progress = (index + 1) / content.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: _controller,
          itemCount: content.length,
          onPageChanged: onChanged,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Stack(
                  children:[
                    Image.asset(
                      'assets/onboarding_screens/upper_bg.png',
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Center(
                        child: Image.asset(
                          content[index].image,
                          width: 280.w,
                          height: 280.h,
                        ),
                      ),
                    ),
                  ]
                ),
                SizedBox(height: 20.h,),
                Center(
                  child: Text(
                    content[index].title,
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PragatiNarrow'
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      content[index].description,
                      style: TextStyle(
                          fontSize: 16.sp,
                        fontFamily: 'Nunito'
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 30.h,),
                //_buildDots(),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      currentIndex++;
                    });
                    if(currentIndex == content.length){
                      Get.offAll(() => const RegisterScreen());
                    } else {
                      _controller.animateToPage(
                        currentIndex,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: CircularProgressIndicator(
                          backgroundColor: const Color(0xFFE0E0E0),
                          value: progress,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary ,
                          ),
                          strokeWidth: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(() => BottomNav(currentIndex: 0));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   width: 50,
                    //   height: 50,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: AppColors.primary,
                    //   ),
                    //   child: const Icon(
                    //     Icons.arrow_forward_ios_rounded,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    Image.asset(
                      'assets/onboarding_screens/bottom_right.png',
                      width: 140.w,
                      height: 100.h,
                    ),
                  ],
                ),
              ],
            );
          }
        ),
    );
  }

  Widget _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < content.length; i++) {
      bool isSelected = i == currentIndex;
      Color fillColor = AppColors.primary;

      dots.add(
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: isSelected
            ? Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(5),
              ),
            )
            : Container(
              width: 15,
              height: 5,
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }
}

class OnBoardingContent {
  String image;
  String title;
  String description;

  OnBoardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoardingContent> content = [
  OnBoardingContent(
    image: 'assets/onboarding_screens/screen_1.png',
    title: "Built in Compiler",
    description: "Experience coding convenience with our built-in compiler for C++, Java, and Python. Enjoy a seamless coding journey without the hassle of switching environments. Let's code efficiently and effortlessly together.",
  ),
  OnBoardingContent(
    image: 'assets/onboarding_screens/screen_2.png',
    title: 'DSA & CP Videos',
    description: "Explore DSA and CP concepts through  curated YouTube educational videos. Elevate your coding skills with our app – your gateway to a world of knowledge",
  ),
  OnBoardingContent(
    image: 'assets/onboarding_screens/screen_3.png',
    title:  '450+ DSA Problems',
    description: "Access 450+ DSA problems and the best CP sheet with just one click! Elevate your coding proficiency effortlessly.",
  ),
];
