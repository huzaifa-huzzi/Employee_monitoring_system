
import 'package:employee_monitoring_system/Panel/Admin/Companies/Add%20Company/AddCompany.dart';
import 'package:employee_monitoring_system/Panel/Admin/Companies/Companies.dart';
import 'package:employee_monitoring_system/Panel/Admin/Companies/CompaniesController.dart';
import 'package:employee_monitoring_system/Panel/Admin/Companies/ViewCompany/ViewCompany.dart';
import 'package:employee_monitoring_system/Panel/Admin/Report/Report.dart';
import 'package:employee_monitoring_system/Panel/Admin/Report/ReportDetails/ReportDetails.dart';
import 'package:employee_monitoring_system/Panel/Admin/SidebarAdmin/SidebarAdmin.dart';
import 'package:employee_monitoring_system/Panel/Admin/Subscription/Subscription.dart';
import 'package:employee_monitoring_system/Panel/Admin/Subscription/SubscriptionController.dart';
import 'package:employee_monitoring_system/Panel/Admin/Subscription/SubscriptionInvoice/SubscriptionInvoice.dart';
import 'package:employee_monitoring_system/Panel/Admin/Subscription/SubscriptionInvoice/SubscriptionInvoiceDetail.dart';
import 'package:employee_monitoring_system/Panel/Admin/Subscription/SubscriptionView/SubscriptionView.dart';
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
        builder: (context, state) => const Companies(),
        routes: [
          GoRoute(
            path: 'view/:id',
            builder: (context, state) {
              final company = state.extra as CompanyModel;
              return ViewCompany(company: company);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/Admin/companies-add',
        builder: (context, state) => const AddCompanyUI(),
      ),

      // Reports
      GoRoute(
        path: '/Admin/reports',
        builder: (context, state) =>   ReportScreen(),
      ),

      GoRoute(
        path: '/Admin/reportsDetails',
        builder: (context, state) =>   ReportDetailScreen(),
      ),

      // Subscription
      GoRoute(
        path: '/Admin/subscription',
        builder: (context, state) => const Subscription(),
        routes: [
          GoRoute(
            path: 'view',
            builder: (context, state) {
              final item = state.extra as SubscriptionItem?;
              return SubscriptionView(item: item);
            },
          ),
          GoRoute(
            path: 'invoice',
            builder: (context, state) {
              final item = state.extra as SubscriptionItem?;
              return SubscriptionInvoice(item: item);
            },
          ),

          GoRoute(
            path: 'invoiceDetails',
            builder: (context, state) {
              final item = state.extra as SubscriptionItem?;
              return SubscriptionInvoiceDetail(item: item);
            },
          ),
        ],
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