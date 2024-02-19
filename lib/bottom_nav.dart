import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/profile/profile.dart';
import 'package:project/screens/home/home.dart';
import 'package:project/screens/learning_section/edu.dart';
import 'package:project/screens/problems/problems.dart';


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
      body: Stack(
        children: [
          pages.elementAt(_selectedIndex),
          Padding(
            padding: EdgeInsets.only(bottom: 18.h, left: 10.w, right: 10.w),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70.h,
                //duration: Duration(milliseconds: 500),
                //curve: Curves.easeInOut,
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
                        'assets/bottom_nav_icons/home_filled.png',
                        width: 24,
                        height: 24,
                      ),
                      icon: Image.asset(
                        'assets/bottom_nav_icons/home_outlined.png',
                        width: 24,
                        height: 24,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/bottom_nav_icons/owners_filled.png',
                        width: 26,
                        height: 26,
                      ),
                      icon: Image.asset(
                        'assets/bottom_nav_icons/owners_outlined.png',
                        width: 26,
                        height: 26,
                      ),
                      label: 'Problems',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/bottom_nav_icons/add_filled.png',
                        width: 24,
                        height: 24,
                      ),
                      icon: Image.asset(
                        'assets/bottom_nav_icons/add_outlined.png',
                        width: 24,
                        height: 24,
                      ),
                      label: 'Learn',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Image.asset(
                        'assets/bottom_nav_icons/profile_filled.png',
                        width: 24,
                        height: 24,
                      ),
                      icon: Image.asset(
                        'assets/bottom_nav_icons/profile_outlined.png',
                        width: 24,
                        height: 24,
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