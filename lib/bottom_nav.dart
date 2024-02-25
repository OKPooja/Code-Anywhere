import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project/screens/compiler/compiler.dart';
import 'package:project/screens/home/home.dart';
import 'package:project/screens/learning_section/edu.dart';
import 'package:project/screens/problems/problems.dart';
import 'package:project/screens/profile/profile.dart';
import 'package:project/utils/colors.dart';


class BottomNav extends StatefulWidget {
  int currentIndex;
  BottomNav({required this.currentIndex, super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  List<Widget> pages = [
    const Home(),
    const Problems(),
    const Edu(),
    const Profile(),
  ];

  void _onItemTapped(int index) async {
    if (index >= 0 && index < pages.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 60.h),
        child: FloatingActionButton(
          isExtended: true,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 8,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          backgroundColor: AppColors.primary,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onPressed: () async {
            Get.to(() => const CodeInputScreen());
          },
          child: Center(
            child: Image.asset(
              "assets/bottom_nav_icons/Console.png",
              width: 20.w,
              height: 20.h,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          pages.elementAt(_selectedIndex),
          Padding(
            padding: EdgeInsets.only(bottom: 18.h, left: 10.w, right: 10.w),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      //spreadRadius: 23,
                      color: Colors.black.withOpacity(0.26),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  unselectedItemColor: const Color(0xff959595),
                  selectedItemColor: Colors.black54,
                  selectedFontSize: 10,
                  unselectedFontSize: 10,
                  unselectedLabelStyle: const TextStyle(
                    color: Color(0xff959595),
                    fontFamily: "Lato",
                  ),
                  selectedLabelStyle: const TextStyle(
                    color: Colors.black54,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.w500,
                  ),
                  backgroundColor: Colors.transparent,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/bottom_nav_icons/Home.png',
                        width: 24,
                        height: 24,
                        color: AppColors.primary,
                      ),
                      icon: Image.asset(
                        'assets/bottom_nav_icons/Home.png',
                        width: 24,
                        height: 24,
                        color: Colors.grey,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/bottom_nav_icons/problems.png',
                        width: 26,
                        height: 26,
                        color: AppColors.primary,
                      ),
                      icon: Image.asset(
                        'assets/bottom_nav_icons/problems.png',
                        width: 26,
                        height: 26,
                        color: Colors.grey,
                      ),
                      label: 'Problems',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/bottom_nav_icons/learn.png',
                        width: 24,
                        height: 24,
                        color: AppColors.primary,
                      ),
                      icon: Image.asset(
                        'assets/bottom_nav_icons/learn.png',
                        width: 24,
                        height: 24,
                        color: Colors.grey,
                      ),
                      label: 'Learn',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/bottom_nav_icons/profile.png',
                        width: 24,
                        height: 24,
                        color: AppColors.primary,
                      ),
                      icon: Image.asset(
                        'assets/bottom_nav_icons/profile.png',
                        width: 24,
                        height: 24,
                        color: Colors.grey,
                      ),
                      label: 'My Profile',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}