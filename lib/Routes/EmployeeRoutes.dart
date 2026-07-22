import 'package:employee_monitoring_system/Panel/Employee/Application%20Tracking/ApplicationTracking.dart';
import 'package:employee_monitoring_system/Panel/Employee/Dashboard/DashboardScreen.dart';
import 'package:employee_monitoring_system/Panel/Employee/Team/Team.dart';
import 'package:employee_monitoring_system/Panel/Employee/Team/TeamMember/TeamMember.dart';
import 'package:employee_monitoring_system/Panel/Employee/TimeSheet/MyTimeSheet/MyTimeSheet.dart';
import 'package:employee_monitoring_system/Panel/Employee/Url%20Tracking/UrlTracking.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:employee_monitoring_system/Panel/Employee/SidebarScreen/SidebarScreen.dart';
import 'package:employee_monitoring_system/Panel/Employee/ActivityTracking/ActivityTracking.dart';
import 'package:employee_monitoring_system/Panel/Employee/Screenshot/ScreenshotScreen.dart';

class EmployeeRoutes {
  static final ShellRoute shellRoute = ShellRoute(
    builder: (context, state, child) {
      return SidebarScreen(
        onTap: (title) => print("Employee Navigated to: $title"),
        child: child,
      );
    },
    routes: [
      // Dashboard
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      // Team
      GoRoute(
        path: '/team',
        builder: (context, state) => const TeamScreen(),
      ),
      GoRoute(
        path: '/teamMember',
        builder: (context, state) => const TeamMembersScreen(),
      ),
      // Time Sheet
      GoRoute(
        path: '/time-sheet',
        redirect: (context, state) => '/time-sheet/my-timesheet',
      ),
      GoRoute(
        path: '/time-sheet/my-timesheet',
        builder: (context, state) => const MyTimeSheet(),
      ),
      // Activity Tracking
      GoRoute(
        path: '/activityTracking',
        builder: (context, state) => const ActivityTracking(),
      ),
      // Screenshot
      GoRoute(
        path: '/screenshot',
        builder: (context, state) => ScreenshotScreen(),
      ),
      // Application Tracking
      GoRoute(
        path: '/applicationTracking',
        builder: (context, state) => ApplicationTracking(),
      ),
      // Url Tracking
      GoRoute(
        path: '/urlTracking',
        builder: (context, state) => UrlTracking(),
      ),

      _buildRoute('/meeting', "Meeting Content"),
      _buildRoute('/projects', "Project Management Content"),
      _buildRoute('/report', "Report Content"),
      _buildRoute('/settings', "Settings Content"),
      _buildRoute('/help', "Help & Support Content"),
    ],
  );

  static GoRoute _buildRoute(String path, String text) {
    return GoRoute(
      path: path,
      builder: (context, state) => Center(child: Text(text)),
    );
  }
}