import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import '../../utils/colors.dart';

class GetAllFiles extends StatefulWidget {
  const GetAllFiles({Key? key}) : super(key: key);

  @override
  State<GetAllFiles> createState() => _GetAllFilesState();
}

class _GetAllFilesState extends State<GetAllFiles> {
  late List<File> files;

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  Future<String?> getPath() async {
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
      print("Cannot get download folder path $err");
    }
    return directory?.path;
  }

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      print('Storage permission granted');
    } else if (status.isDenied) {
      print('Storage permission denied');
    } else if (status.isPermanentlyDenied) {
      print('Storage permission permanently denied');
      openAppSettings();
    }
  }

  Future<void> loadFiles() async {
    String? path = await getPath();
    if (path != null) {
      Directory directory = Directory(path);
      List<FileSystemEntity> fileList = directory.listSync();

      setState(() {
        files = fileList.whereType<File>().toList();
      });
    } else {
      print("Download path is null");
    }
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
          'Your Files',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading:
              Icon(
                Icons.file_copy_sharp,
                color: Colors.grey.shade800,
              ),
            title: Text(
              files[index].path.split('/').last,
            ),
            onTap: () {
              OpenFile.open(files[index].path);
            },
          );
        },
      ),
    );
  }
}
