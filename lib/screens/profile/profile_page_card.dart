import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/utils/colors.dart';

class ProfilePageCards extends StatelessWidget {
  final String image;
  final String title;
  final void Function()? onTap;

  const ProfilePageCards({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFc9ccf0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.only(left: 20.sp, right: 8.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  image,
                  height: 20.h,
                  width: 20.h,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontFamily: 'Nunito'
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onTap,
                  //Arrow button shouldn't be visible for logout.. Hence the condition..
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: title != 'Log Out'
                        ? AppColors.primary
                        : Colors.transparent,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
