import 'package:employee_monitoring_system/ActivityTracking/ActivityTrackingController.dart';
import 'package:employee_monitoring_system/ActivityTracking/Widget/ActivityTrackingWidget.dart';
import 'package:employee_monitoring_system/Resources/AppSizes.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityTracking extends StatelessWidget {
  const ActivityTracking({super.key});

  @override
  Widget build(BuildContext context) {
    final ActivityController controller = Get.put(ActivityController());
    final bool webMode = AppSizes.isWeb(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(webMode ? 24.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Activity Tracking",
                        style: webMode
                            ? TTextTheme.h1Style(context)
                            : TTextTheme.h2Style(context).copyWith(
                          fontSize: isMobile ? 18 : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Track your activity efficiently here",
                        style: TTextTheme.titleSix(context).copyWith(
                          fontSize: isMobile ? 12 : null,
                        ),
                      ),
                    ],
                  ),
                  if (isMobile) const SizedBox(height: 16),
                  Container(
                    height: 45,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Obx(() => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTopTabButton(context, "Day", 0, controller, isMobile),
                        _buildTopTabButton(context, "Week", 1, controller, isMobile),
                        _buildTopTabButton(context, "Month", 2, controller, isMobile),
                      ],
                    )),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const ActivityTrackingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  /// ------------ Extra Widgets ----------- ///

  // Top Buttons
  Widget _buildTopTabButton(
      BuildContext context,
      String label,
      int index,
      ActivityController controller,
      bool isMobile,
      ) {
    final isSelected = controller.selectedViewIndex.value == index;
    return InkWell(
      onTap: () => controller.toggleView(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 10),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 14,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: isSelected
              ? TTextTheme.TabsSelectedText(context).copyWith(fontSize: isMobile ? 12 : null)
              : TTextTheme.titleThree(context).copyWith(fontSize: isMobile ? 12 : null),
        ),
      ),
    );
  }
}