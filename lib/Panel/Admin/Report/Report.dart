import 'package:employee_monitoring_system/Panel/Admin/Report/Widget/ReportWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: ReportScreenWidget(),
    );
  }
}