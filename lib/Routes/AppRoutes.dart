import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Dashboard/DashboardScreen.dart';
import '../SidebarScreen/SidebarScreen.dart';

class AppNavigation {
  static final router = GoRouter(
    initialLocation: '/dashboard',
    debugLogDiagnostics: true,
    routes: [
      /// LOGIN route
      GoRoute(
        path: '/login',
        builder: (context, state) => const Scaffold(body: Center(child: Text("Login Screen"))),
      ),

      /// SHELL ROUTE
      ShellRoute(
        builder: (context, state, child) {
          return SidebarScreen(
            onTap: (title) => print("Navigated to: $title"),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          _buildRoute('/team', "Team Content"),
          _buildRoute('/time-sheet', "Time Sheet Content"),
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