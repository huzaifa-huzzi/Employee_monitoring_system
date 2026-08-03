import 'package:employee_monitoring_system/Panel/Vendor/VendorSnapshot/VendorSnapshotController.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorSnapshot/Widget/VendorSnapShotWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class VendorSnapShot extends StatelessWidget {
  const VendorSnapShot({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX Controller Register
    Get.put(VendorSnapshotController());

    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: VendorSnapshotWidget(),
      ),
    );
  }
}