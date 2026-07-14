import 'package:employee_monitoring_system/TimeSheet/MyTimeSheet/Widget/TimeSheetWidget.dart';
import 'package:flutter/material.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';

class MyTimeSheet extends StatelessWidget {
  const MyTimeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title
            Text(
              "Time Sheet",
              style: TTextTheme.titleOne(context).copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),

            // Page Subtitle
            Text(
              "You can see your time Sheet Here",
              style: TTextTheme.titleTwo(context).copyWith(
                fontSize: 14,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),

            // Main TimeSheet Widget Container
            TimeSheetWidget(),
          ],
        ),
      ),
    );
  }
}