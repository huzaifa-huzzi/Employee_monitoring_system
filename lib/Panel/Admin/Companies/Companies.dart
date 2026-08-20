import 'package:employee_monitoring_system/Panel/Admin/Companies/Widget/CompaniesWidget.dart';
import 'package:flutter/material.dart';


class Companies extends StatelessWidget {
  const Companies({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CompaniesWidget(),
    );
  }
}
