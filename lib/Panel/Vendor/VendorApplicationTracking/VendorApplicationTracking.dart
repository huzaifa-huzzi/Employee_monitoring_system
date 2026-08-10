import 'package:employee_monitoring_system/Panel/Vendor/VendorApplicationTracking/Widget/VendorApplicationTrackingWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';


class VendorApplicationTracking extends StatelessWidget {
  const VendorApplicationTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: VendorApplicationTrackingWidget(),
      ),
    );
  }
}