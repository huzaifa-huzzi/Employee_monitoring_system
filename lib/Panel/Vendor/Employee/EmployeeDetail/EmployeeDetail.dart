import 'package:employee_monitoring_system/Panel/Vendor/Employee/EmployeeController.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Employee/EmployeeDetail/Widget/EmployeeDetailWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmployeeDetail extends StatelessWidget {
  final EmployeeModel employee;

  const EmployeeDetail({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/vendor/employee');
                      }
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                   Text(
                    TextString.employeeDetailTitle,
                    style: TTextTheme.h1Style(context)
                  ),
                ],
              ),
              const SizedBox(height: 4),
               Padding(
                padding: EdgeInsets.only(left: 32),
                child: Text(
                  TextString.employeeDetailSubtitle,
                  style: TTextTheme.titleFour(context),
                ),
              ),
              const SizedBox(height: 20),

              EmployeeDetailWidget(employee: employee),
            ],
          ),
        ),
      ),
    );
  }
}
