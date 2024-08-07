import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/screens/profile/personal_details.dart';
import 'package:project/screens/profile/profile_page_card.dart';
import 'package:project/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_preferences_helper.dart';
import '../../widgets/custom_toast.dart';
import '../auth/login.dart';
import 'getAllFiles.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final File _profileImage;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _refreshProfile() async {
    await _initializePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: Colors.white,
                fontFamily: 'Lato'),
          ),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshProfile,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                      const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 60,
                          backgroundImage:
                              AssetImage('assets/home/dummy_profile.png'),
                      ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          SharedPreferencesHelper.getUserName(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontFamily: 'Lato',
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '+91 9898765432',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: const Color.fromRGBO(0, 0, 0, 0.6),
                              fontFamily: 'Lato'),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.to(() => const PersonalDetails());
                  },
                  child: ProfilePageCards(
                    image: 'assets/profile/Person.png',
                    title: 'Personal Details',
                    onTap: () {},
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: (){
                    Get.to(() => const GetAllFiles());
                  },
                  child: ProfilePageCards(
                      image: 'assets/profile/files.png',
                      title: 'Files',
                      onTap: () {
                        Get.to(() => const GetAllFiles());
                      },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ProfilePageCards(
                    image: 'assets/profile/rate.png',
                    title: 'Rate our app',
                    onTap: () {}),
                SizedBox(
                  height: 10.h,
                ),
                ProfilePageCards(
                    image: 'assets/profile/help_and_support.png',
                    title: 'Help',
                    onTap: () {}),
                SizedBox(
                  height: 10.h,
                ),
                ProfilePageCards(
                    image: 'assets/profile/privacy_policy.png',
                    title: 'Privacy Policy',
                    onTap: () {}),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          title: Text("Confirm Logout"),
                          content: Text("Are you sure you want to log out?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                SharedPreferencesHelper.setIsLoggedIn(
                                    status: false);
                                _prefs.setBool('isFirstTime', false);
                                print(_prefs.getBool('isFirstTime'));
                                showCustomToast(
                                  context: context,
                                  message: 'Logout Successful',
                                );
                                Get.offAll(() => const LoginScreen());
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ProfilePageCards(
                      image: 'assets/profile/logout.png',
                      title: 'Log Out',
                      onTap: () {}),
                ),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'png', 'jpg'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _profileImage = file;
      });
    }
  }
}
