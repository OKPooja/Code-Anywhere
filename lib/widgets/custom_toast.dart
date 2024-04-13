import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showCustomToast({
  required BuildContext context,
  required String message,
  Duration autoCloseDuration = const Duration(seconds: 5),
  Alignment alignment = Alignment.bottomCenter,
  Color primaryColor = Colors.green,
  Color backgroundColor = Colors.white,
  Color foregroundColor = Colors.black,
  bool showProgressBar = false,
}) {
  toastification.show(
    context: context,
    title: Text(message),
    autoCloseDuration: autoCloseDuration,
    alignment: alignment,
    primaryColor: primaryColor,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    showProgressBar: showProgressBar,
  );
}
