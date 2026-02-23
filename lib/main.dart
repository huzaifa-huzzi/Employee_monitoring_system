import 'package:employee_monitoring_system/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'Resources/Theme.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme(context),
      routerDelegate: AppNavigation.router.routerDelegate,
      routeInformationParser: AppNavigation.router.routeInformationParser,
      routeInformationProvider: AppNavigation.router.routeInformationProvider,
    );
  }
}