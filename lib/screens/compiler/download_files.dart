import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../widgets/custom_toast.dart';

Future<String?> getDownloadPath() async {
  Directory? directory;
  try {
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/codeAnywhere');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
    }
  } catch (err) {
    if (kDebugMode) {
      print("Cannot get download folder path $err");
    }
  }
  return directory?.path;
}

Future<void> requestStoragePermission() async {
  PermissionStatus status = await Permission.manageExternalStorage.request();

  if (status.isGranted) {
    if (kDebugMode) {
      print('Storage permission granted');
    }
  } else if (status.isDenied) {
    if (kDebugMode) {
      print('Storage permission denied');
    }
  } else if (status.isPermanentlyDenied) {
    if (kDebugMode) {
      print('Storage permission permanently denied');
    }
    openAppSettings();
  }
}

