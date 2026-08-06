import 'package:employee_monitoring_system/Panel/Vendor/Employee/EditEmployee/Widget/EditEmployeeWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';

class EditEmployee extends StatelessWidget {
  const EditEmployee({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: EditEmployeeWidget(),
      ),
    );
  }
}
