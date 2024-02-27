import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project/screens/auth/login.dart';
import 'package:project/screens/auth/register.dart';
import 'package:project/screens/on_boarding_screens/on_boarding_screen.dart';
import 'package:project/shared_preferences_helper.dart';
import 'package:project/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_nav.dart';


late SharedPreferences _prefs;
bool? isFirstTime = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  try {
    await _initializePrefs();
  } catch (e) {
    log(e.toString());
  }
  runApp(const MyApp());
}

Future<void> _initializePrefs() async {
  _prefs = await SharedPreferences.getInstance();

  isFirstTime = _prefs.getBool('isFirstTime');
  if (kDebugMode) {
    print('isFirstTime: $isFirstTime');
    print(SharedPreferencesHelper.getApiKey());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MPR',
          theme: ThemeData(
            highlightColor: AppColors.primary,
            colorScheme: ColorScheme.fromSwatch().copyWith(primary: AppColors.primary),
            useMaterial3: true,
          ),
          home: (isFirstTime == null || isFirstTime == true)
              ? const OnBoardingScreen()
              : (SharedPreferencesHelper.getIsLoggedIn() == true)
                ? BottomNav(currentIndex: 0)
                  : const LoginScreen(),
          //home: BottomNav(currentIndex: 0,),
        );
      },
    );
  }
}

