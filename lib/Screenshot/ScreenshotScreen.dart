import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:employee_monitoring_system/Screenshot/Widget/ScreenshotWidget.dart';
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
            // Screen Outer Titles
            Text(
              "Work Snap Shots",
              style: TTextTheme.h1Style(context).copyWith(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              "Here are your Work Snap Shots",
              style: TTextTheme.titleSix(context).copyWith(color: AppColors.tertiaryTextColor),
            ),
            const SizedBox(height: 24),

            // Main Custom Graphic View Box Wrapper
            const ScreenshotWidget(),
          ],
        ),
      ),
    );
  }
}