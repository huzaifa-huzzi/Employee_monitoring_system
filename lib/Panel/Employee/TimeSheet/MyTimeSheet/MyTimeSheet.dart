import 'package:employee_monitoring_system/Panel/Employee/TimeSheet/MyTimeSheet/Widget/TimeSheetWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:flutter/material.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';

class MyTimeSheet extends StatelessWidget {
  const MyTimeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextString.timeSheetTitle,
              style: TTextTheme.h1Style(context)
            ),
            const SizedBox(height: 4),
            Text(
              TextString.timeSheetSubtitle,
              style: TTextTheme.titleTwo(context),
            ),
            const SizedBox(height: 24),
            TimeSheetWidget(),
          ],
        ),
      ),
    );
  }
}