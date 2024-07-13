import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
  Color backgroundColor = Colors.white,
  Color textColor = Colors.black,
  Color iconColor = Colors.black87,
  double borderRadius = 10.0,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 4.0),
  double iconSize = 18.0,
  double textSize = 18.0,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Icon(
              icon,
              size: iconSize,
              color: text == '' ? Colors.green: iconColor,
            ),
            SizedBox(width: 3.w),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w800,
                fontSize: textSize.sp,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget verticalDivider() {
  return Container(
    width: 1,
    height: 16.h,
    color: Colors.black87,
    margin: EdgeInsets.symmetric(horizontal: 2.w),
  );
}