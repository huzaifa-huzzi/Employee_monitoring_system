import 'package:employee_monitoring_system/Panel/Vendor/VendorUrlTracking/Widget/VendorUrlTrackingWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';


class VendorUrlTracking extends StatelessWidget {
  const VendorUrlTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: VendorUrlTrackingWidget(),
      ),
    );
  }
}
