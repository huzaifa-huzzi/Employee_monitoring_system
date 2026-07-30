import 'package:employee_monitoring_system/Panel/Vendor/VendorTimeSheet/VendorTeamTimeSheet/Widget/VendorTeamTimeSheetWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';

class VendorTeamTimeSheet extends StatelessWidget {
  const VendorTeamTimeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: VendorTeamTimeSheetWidget(),
    );
  }
}