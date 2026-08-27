import 'package:employee_monitoring_system/Panel/Admin/Subscription/SubscriptionController.dart';
import 'package:employee_monitoring_system/Panel/Admin/Subscription/Widget/SubscriptionWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SubscriptionController());

    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: SubscriptionWidget(),
        ),
      ),
    );
  }
}