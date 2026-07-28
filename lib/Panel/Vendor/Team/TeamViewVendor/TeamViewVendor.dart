import 'package:employee_monitoring_system/Panel/Vendor/Team/TeamViewVendor/Widget/TeamViewVendorWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';


class TeamViewVendor extends StatelessWidget {
  const TeamViewVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: TeamViewVendorWidget(),
    );
  }
}