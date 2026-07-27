import 'package:employee_monitoring_system/Panel/Vendor/Employee/EmployeeController.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

import '../../../../../Resources/Colors.dart' show AppColors;


class EmployeeDetailWidget extends StatelessWidget {
  final EmployeeModel employee;

  const EmployeeDetailWidget({
    super.key,
    required this.employee,
  });

  Map<String, dynamic> _getStatusConfig(EmployeeStatus status) {
    switch (status) {
      case EmployeeStatus.online:
        return {
          "text": "Active",
          "bgColor": AppColors.approvedColor,
          "dotColor": AppColors.approvedColor,
        };
      case EmployeeStatus.offline:
        return {
          "text": "Offline",
          "bgColor": AppColors.rejectedColor,
          "dotColor": AppColors.rejectedColor,
        };
      case EmployeeStatus.invited:
        return {
          "text": "Invited",
          "bgColor": AppColors.pendingColor,
          "dotColor": AppColors.pendingColor,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusConfig = _getStatusConfig(employee.status);

    List<String> nameParts = employee.name.split(" ");
    String firstName = nameParts.isNotEmpty ? nameParts[0] : "";
    String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor.withValues(alpha: 0.7),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      employee.name.isNotEmpty ? employee.name[0].toUpperCase() : "E",
                      style: TTextTheme.h4Style(context)
                    ),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: statusConfig["dotColor"],
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.whiteColor, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: TTextTheme.h4Style(context)
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Employee  •  Since, ${employee.joiningDate}",
                      style: TTextTheme.titleThree(context),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: statusConfig["bgColor"],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusConfig["text"],
                  style: TTextTheme.btnTextOne(context),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                TextString.employeeInfo,
                style: TTextTheme.h2Style(context),
              ),
              const SizedBox(height: 28),

              LayoutBuilder(
                builder: (context, constraints) {
                  double totalWidth = constraints.maxWidth;
                  bool isMobile = totalWidth < 700;

                  double itemWidth = isMobile ? totalWidth : (totalWidth - 48) / 3;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: [
                      _buildInfoField(context,TextString.employeeDetailFirst, firstName, itemWidth),
                      _buildInfoField(context,TextString.employeeDetailLast, lastName, itemWidth),
                      _buildInfoField(context,TextString.employeeDetailEmail, employee.email, itemWidth),
                      _buildInfoField(context,TextString.employeeDetailPhone, "+61430042030", itemWidth),
                      _buildInfoField(context,TextString.employeeDetailRole, employee.role, itemWidth),
                      _buildInfoField(context,TextString.employeeDetailDept, employee.department, itemWidth),
                      _buildInfoField(context,TextString.employeeDetailJoining, employee.joiningDate, itemWidth),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ----------- Extra Widget ----------- ///

  // Field
  Widget _buildInfoField(BuildContext context,String label, String value, double width) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TTextTheme.titleFour(context)
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Text(
              value.isEmpty ? "-" : value,
              style: TTextTheme.titleThree(context),
            ),
          ),
        ],
      ),
    );
  }
}