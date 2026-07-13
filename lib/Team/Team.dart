import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Team/Widget/TeamWidget.dart';
import 'package:flutter/material.dart';


class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: TeamWidget(),
    );
  }
}