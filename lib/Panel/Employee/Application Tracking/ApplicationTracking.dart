import 'package:employee_monitoring_system/Panel/Employee/Application%20Tracking/ApplicationTrackingController.dart';
import 'package:employee_monitoring_system/Panel/Employee/Application%20Tracking/Widget/ApplicationTrackingWidget.dart';
import 'package:employee_monitoring_system/Resources/AppSizes.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationTracking extends StatelessWidget {
  const ApplicationTracking({super.key});

  @override
  Widget build(BuildContext context) {
    final ApplicationTrackingController controller = Get.put(ApplicationTrackingController());
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
                       TextString.appTitle,
                        style: webMode
                            ? TTextTheme.h1Style(context)
                            : TTextTheme.h2Style(context).copyWith(
                          fontSize: isMobile ? 18 : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        TextString.appSubtitle,
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
                        _buildTopTabButton(context, TextString.dayTitle, 0, controller, isMobile),
                        _buildTopTabButton(context, TextString.weekTitle, 1, controller, isMobile),
                        _buildTopTabButton(context, TextString.month, 2, controller, isMobile),
                      ],
                    )),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const ApplicationTrackingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  /// ------------  Extra Widgets ----------- ///

   // Top tab Buttons
  Widget _buildTopTabButton(
      BuildContext context,
      String label,
      int index,
      ApplicationTrackingController controller,
      bool isMobile,
      ) {
    final isSelected = controller.selectedViewIndex.value == index;
    return InkWell(
      onTap: () => controller.toggleView(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 16,
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