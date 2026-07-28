import 'package:employee_monitoring_system/Panel/Vendor/Team/AddTeamVendor/Widget/AddTeamVendorWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';

class AddTeamVendor extends StatelessWidget {
  const AddTeamVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: AddTeamVendorWidget(),
    );
  }
}
