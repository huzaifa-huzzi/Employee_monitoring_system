import 'package:employee_monitoring_system/Panel/Vendor/Team/EditTeam/Widget/EditTeamVendorWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';

class EditTeamVendor extends StatelessWidget {
  const EditTeamVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: EditTeamVendorWidget(),
    );
  }
}
