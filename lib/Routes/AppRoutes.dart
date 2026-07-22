

import 'package:go_router/go_router.dart';
import 'package:employee_monitoring_system/Routes/AuthRoutes.dart';
import 'package:employee_monitoring_system/Routes/EmployeeRoutes.dart';
import 'package:employee_monitoring_system/Routes/VendorRoutes.dart';

class AppNavigation {
  static final router = GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      ///  Authentication Routes
      ...AuthRoutes.routes,

      ///  Employee Panel Shell Route
      EmployeeRoutes.shellRoute,

      /// Vendor Panel Shell Route
      VendorRoutes.shellRoute,
    ],
  );
}