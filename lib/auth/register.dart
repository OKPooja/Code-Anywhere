import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project/auth/login.dart';

import '../utils/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 60.h, left: 30.w),
                        child: Text(
                          "LET'S \nGET\nSTARTED",
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/auth/top_circle.png',
                    width: 150.w,
                    height: 160.h,
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      suffixIcon: Icons.person,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'E-mail',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      suffixIcon: Icons.email,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      suffixIcon: Icons.remove_red_eye_sharp,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomElevatedButton(
                      text: 'Create an Account',
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  'or',
                  style: TextStyle(
                    fontSize: 20.sp
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/auth/google logo.png',
                    width: 45.w,
                    height: 45.h,
                  ),
                  SizedBox(width: 30.w,),
                  Image.asset(
                    'assets/auth/facebook.png',
                    width: 45.w,
                    height: 45.h,
                  ),
                  SizedBox(width: 30.w,),
                  const Icon(
                    Icons.call,
                    size: 42,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        fontSize: 14.sp
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => const LoginScreen());
                    },
                    child: Text(
                      ' Sign in',
                      style: TextStyle(
                          fontSize: 14.sp,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset(
                  'assets/auth/bottom_circle.png',
                  width: 100.w,
                  height: 70.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
