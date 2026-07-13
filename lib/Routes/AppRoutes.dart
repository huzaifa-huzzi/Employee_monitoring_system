import 'package:employee_monitoring_system/Authentication/ForgotPasswrod/ForgotPassword.dart';
import 'package:employee_monitoring_system/Authentication/Invitation/InvitationScreen.dart';
import 'package:employee_monitoring_system/Authentication/Login/LoginScreen.dart';
import 'package:employee_monitoring_system/Authentication/OtpVerification/OtpVerificationScreen.dart';
import 'package:employee_monitoring_system/Authentication/ResetPassword/ResetPassword.dart';
import 'package:employee_monitoring_system/Authentication/Signup/SignUpScreen.dart';
import 'package:employee_monitoring_system/Team/Team.dart';
import 'package:employee_monitoring_system/TimeSheet/Approval/Approval.dart';
import 'package:employee_monitoring_system/TimeSheet/MyTimeSheet/MyTimeSheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Dashboard/DashboardScreen.dart';
import '../SidebarScreen/SidebarScreen.dart';


class AppNavigation {
  static final router = GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      GoRoute(
        path: '/otpVerification',
        builder: (context, state) => const OtpVerificationScreen(),
      ),

      GoRoute(
        path: '/resetPassword',
        builder: (context, state) => const ResetPassword(),
      ),
      GoRoute(
        path: '/invitation',
        builder: (context, state) => const InvitationScreen(),
      ),

      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),



      ShellRoute(
        builder: (context, state, child) {
          return SidebarScreen(
            onTap: (title) => print("Navigated to: $title"),
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
            builder: (context, state) => const TeamScreen(),
          ),
            // Time Sheet
          GoRoute(
            path: '/time-sheet',
            redirect: (context, state) => '/time-sheet/my-timesheet',
          ),
          GoRoute(
            path: '/time-sheet/my-timesheet',
            builder: (context, state) => const MyTimeSheet()),
          GoRoute(
            path: '/time-sheet/approvals',
            builder: (context, state) => Approval()),


          _buildRoute('/screenshots', "Screen Shots Content"),
          _buildRoute('/activity', "Activity Tracking Content"),
          _buildRoute('/app-tracking', "Application Tracking Content"),
          _buildRoute('/url-tracking', "URL Tracking Content"),
          _buildRoute('/meeting', "Meeting Content"),
          _buildRoute('/projects', "Project Management Content"),
          _buildRoute('/report', "Report Content"),
          _buildRoute('/settings', "Settings Content"),
          _buildRoute('/help', "Help & Support Content"),
        ],
      ),
    ],
  );

  // Helper method
  static GoRoute _buildRoute(String path, String text) {
    return GoRoute(
      path: path,
      builder: (context, state) => Center(child: Text(text)),
    );
  }
}