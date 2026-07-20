import 'package:employee_monitoring_system/Panel/Employee/Team/TeamMember/Widget/TeamMemberWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';


class TeamMembersScreen extends StatelessWidget {
  const TeamMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: TeamMembersWidget(),
    );
  }
}