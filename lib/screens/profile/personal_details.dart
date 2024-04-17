import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../shared_preferences_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class PersonalDetails extends StatelessWidget {

   PersonalDetails({super.key});
   late final File _profileImage;
   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController mobileController = TextEditingController();
   TextEditingController dobController = TextEditingController();
   TextEditingController collegeNameController = TextEditingController();
   TextEditingController branchController = TextEditingController();


   _uploadImage() async {
     FilePickerResult? result = await FilePicker.platform.pickFiles(
       type: FileType.custom,
       allowedExtensions: ['jpeg', 'png', 'jpg'],
     );

     if (result != null) {
       File file = File(result.files.single.path!);
       _profileImage = file;
     }
   }
   _save(){

   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Personal Details',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h,),
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 60,
                      backgroundImage:
                      AssetImage('assets/home/dummy_profile.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _uploadImage();
                        },
                        child: Image.asset(
                          'assets/profile/edit_profile.png',
                          width: 40.w,
                          height: 40.h,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
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
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 10.h,
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
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Mobile No.',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Date of Birth',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: dobController,
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'College Name',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: collegeNameController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Branch of Study',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: branchController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 50.h,
              ),
              CustomElevatedButton(
                text: 'Save',
                onPressed: () {
                  _save();
                },
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        )
      ),
    );
  }
}
