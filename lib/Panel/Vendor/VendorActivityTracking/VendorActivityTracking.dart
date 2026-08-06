import 'package:employee_monitoring_system/Panel/Vendor/VendorActivityTracking/VendorActivityController.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorActivityTracking/Widget/vendorActivityTrackingWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Resources/Colors.dart';


class VendorActivityTracking extends StatelessWidget {
  const VendorActivityTracking({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VendorActivityController());
    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: VendorActivityTrackingWidget(),
      ),
    );
  }
}