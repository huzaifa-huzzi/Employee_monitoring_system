import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Employee/EmployeeController.dart' show EmployeeController;
import 'package:employee_monitoring_system/Panel/Vendor/Employee/Invitation/Widget/EmployeeInvitationWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeInvitation extends StatefulWidget {
  const EmployeeInvitation({super.key});

  @override
  State<EmployeeInvitation> createState() => _EmployeeInvitationState();
}

class _EmployeeInvitationState extends State<EmployeeInvitation> {
  late final EmployeeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EmployeeController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: EmployeeInvitationWidget(),
    );
  }
}