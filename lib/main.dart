import 'dart:developer';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
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
          title: 'Code Anywhere',
          theme: ThemeData(
            highlightColor: AppColors.primary,
            colorScheme: ColorScheme.fromSwatch().copyWith(primary: AppColors.primary),
            useMaterial3: true,
          ),
          home: child,
          //home: BottomNav(currentIndex: 0,),
        );
      },
      child: Scaffold(
        body: DoubleBackToCloseApp(
            snackBar: SnackBar(
              backgroundColor: AppColors.primary,
              shape: ShapeBorder.lerp(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                const StadiumBorder(),
                0.2,
              )!,
              width: 300,
              behavior: SnackBarBehavior.floating,
              content: const Text(
                'Double tap to exit app',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              duration: const Duration(seconds: 1),
            ),
            child: (isFirstTime == null || isFirstTime == true)
                ? const OnBoardingScreen()
                : (SharedPreferencesHelper.getIsLoggedIn() == true)
                ? BottomNav(currentIndex: 0)
                : const LoginScreen(),
        ),
      ),
    );
  }
}
