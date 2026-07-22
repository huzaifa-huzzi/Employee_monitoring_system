


import 'package:employee_monitoring_system/Panel/Vendor/SidebarVendor/SidebarVendorScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

    ],
  );
}