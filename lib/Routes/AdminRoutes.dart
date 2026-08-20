
import 'package:employee_monitoring_system/Panel/Admin/Companies/Companies.dart';
import 'package:employee_monitoring_system/Panel/Admin/SidebarAdmin/SidebarAdmin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminRoutes {
  static final ShellRoute shellRoute = ShellRoute(
    builder: (context, state, child) {
      return SidebarAdminScreen(
        onTap: (title) => print("Admin Navigated to: $title"),
        child: child,
      );
    },
    routes: [
      // Admin Dashboard
      GoRoute(
        path: '/Admin/dashboard',
        builder: (context, state) => const Center(child: Text("Admin Dashboard")),
      ),

      // Companies
      GoRoute(
        path: '/Admin/companies',
        builder: (context, state) => Companies(),
      ),

      // Reports
      GoRoute(
        path: '/Admin/reports',
        builder: (context, state) => const Center(child: Text("Reports Screen")),
      ),

      // Subscription
      GoRoute(
        path: '/Admin/subscription',
        builder: (context, state) => const Center(child: Text("Subscription Screen")),
      ),

      // Pricing Plans
      GoRoute(
        path: '/Admin/pricing-plans',
        builder: (context, state) => const Center(child: Text("Pricing Plans Screen")),
      ),

      // Demo Requests
      GoRoute(
        path: '/Admin/demo-requests',
        builder: (context, state) => const Center(child: Text("Demo Requests Screen")),
      ),

      // Payment
      GoRoute(
        path: '/Admin/payment',
        builder: (context, state) => const Center(child: Text("Payment Screen")),
      ),

      // User and Role
      GoRoute(
        path: '/Admin/user-and-role',
        builder: (context, state) => const Center(child: Text("User and Role Screen")),
      ),

      // Help Center
      GoRoute(
        path: '/Admin/help-center',
        builder: (context, state) => Text('Help Center'),
      ),
    ],
  );
}