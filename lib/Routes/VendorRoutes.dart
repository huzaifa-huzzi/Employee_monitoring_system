import 'package:employee_monitoring_system/Panel/Vendor/Employee/Employee.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Employee/EmployeeController.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Employee/EmployeeDetail/EmployeeDetail.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Employee/Invitation/EmployeeInvitation.dart';
import 'package:employee_monitoring_system/Panel/Vendor/SidebarVendor/SidebarVendorScreen.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Team/AddTeamVendor/AddTeamVendor.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Team/EditTeam/EditTeamVendor.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Team/Team.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Team/TeamViewVendor/TeamViewVendor.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorSnapshot/VendorSnapshot.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorTimeSheet/VendorTeamTimeSheet/VendorTeamTimeSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../Panel/Vendor/Employee/EditEmployee/EditEmployee.dart';

class VendorRoutes {
  static final ShellRoute shellRoute = ShellRoute(
    builder: (context, state, child) {
      return SidebarVendorScreen(
        onTap: (title) => print("Vendor Navigated to: $title"),
        child: child,
      );
    },
    routes: [
      // Vendor Dashboard
      GoRoute(
        path: '/vendor/dashboard',
        builder: (context, state) => const Center(child: Text("Vendor Dashboard")),
      ),

       // Vendor Employee
      GoRoute(
        path: '/vendor/employee',
        builder: (context, state) => EmployeeScreen()),
      GoRoute(
        path: '/vendor/employeeDetail',
        builder: (context, state) {
          final controller = Get.find<EmployeeController>();
          EmployeeModel? employee = state.extra as EmployeeModel?;
          if (employee == null) {
            final email = state.uri.queryParameters['email'];
            employee = controller.allEmployees.firstWhere(
                  (e) => e.email == email,
              orElse: () => controller.allEmployees.first,
            );
          }

          return EmployeeDetail(employee: employee);
        },
      ),
      GoRoute(
          path: '/vendor/employeeInvitation',
          builder: (context, state) => EmployeeInvitation()),
      GoRoute(
        path: '/vendor/editEmployee',
        builder: (context, state) {
          final controller = Get.find<EmployeeController>();
          EmployeeModel? employee = state.extra as EmployeeModel?;
          if (employee == null) {
            final email = state.uri.queryParameters['email'];
            employee = controller.allEmployees.firstWhere(
                  (e) => e.email == email,
              orElse: () => controller.allEmployees.first,
            );
          }
          controller.prepareEmployeeForEditing(employee);

          return const EditEmployee();
        },
      ),

      // vendor Team
      GoRoute(
          path: '/vendor/Team',
          builder: (context, state) => Team()),
      GoRoute(
          path: '/vendor/EditTeam',
          builder: (context, state) => EditTeamVendor()),
      GoRoute(
          path: '/vendor/TeamMembers',
          builder: (context, state) => TeamViewVendor()),

      GoRoute(
          path: '/vendor/addTeam',
          builder: (context, state) => AddTeamVendor()),

        // Team TimeSheet
      GoRoute(
          path: '/vendor/TeamTimeSheet',
          builder: (context, state) => VendorTeamTimeSheet()),

       // Vendor Snapshot
      GoRoute(
          path: '/vendor/ScreenShot',
          builder: (context, state) => VendorSnapShot()),



    ],
  );
}