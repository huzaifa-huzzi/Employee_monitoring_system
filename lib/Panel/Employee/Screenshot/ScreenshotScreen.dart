import 'package:employee_monitoring_system/Panel/Employee/Screenshot/Widget/ScreenshotWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class ScreenshotScreen extends StatelessWidget {
  const ScreenshotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextString.mainSnapshotTitle,
              style: TTextTheme.h1Style(context).copyWith(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              TextString.mainSnapshotSubtitle,
              style: TTextTheme.titleSix(context).copyWith(color: AppColors.tertiaryTextColor),
            ),
            const SizedBox(height: 24),
            const ScreenshotWidget(),
          ],
        ),
      ),
    );
  }
}