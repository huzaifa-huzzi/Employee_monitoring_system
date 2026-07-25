import 'package:employee_monitoring_system/Panel/Vendor/Employee/EmployeeController.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Employee/Widget/EmployeeWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  late final EmployeeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EmployeeController());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: EmployeeWidget(),
    );
  }
}