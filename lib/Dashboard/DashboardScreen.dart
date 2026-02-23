import 'package:employee_monitoring_system/SidebarScreen/SidebarController.dart';
import 'package:employee_monitoring_system/SidebarScreen/Widget/WebAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column( // Column rakhein taake upar se gap control kar saken
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // YAHAN SE WEBAPPBAR HATA DIYA HAI

            Text(
              "Dashboard Overview",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

}
