import 'package:flutter/material.dart';
import 'package:get/get.dart';

void _showOutputBottomSheet(String output) {
  Get.bottomSheet(
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Output',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              output,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
    enterBottomSheetDuration: const Duration(milliseconds: 300),
  );
}