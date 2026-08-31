import 'package:employee_monitoring_system/Panel/Admin/Pricing/PricingController.dart';
import 'package:employee_monitoring_system/Panel/Admin/Pricing/Widget/PricingWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class Pricing extends StatelessWidget {
  const Pricing({super.key});

  @override
  Widget build(BuildContext context) {
    final PricingController controller = Get.put(PricingController());

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 550;

                  final titleSection = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       TextString.adminPricingTitle,
                        style: TTextTheme.titleFive(context).copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        TextString.adminPricingSubtitle,
                        style: TTextTheme.titleSix(context).copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  );

                  final createBtn = SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/Admin/pricing-plans/CreatePlan');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Create Plan",
                        style: TTextTheme.whiteColorBtn(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );

                  if (isMobile) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleSection,
                        const SizedBox(height: 12),
                        createBtn,
                      ],
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleSection,
                      createBtn,
                    ],
                  );
                },
              ),
              const SizedBox(height: 28),

              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  if (width < 768) {
                    return Column(
                      children: List.generate(
                        controller.plans.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: PricingWidget(
                            plan: controller.plans[index],
                            onToggle: () => controller.togglePlanStatus(index),
                          ),
                        ),
                      ),
                    );
                  }
                  final itemWidth = (width - ((controller.plans.length - 1) * 20)) / controller.plans.length;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      controller.plans.length,
                          (index) => Container(
                        width: itemWidth,
                        margin: EdgeInsets.only(
                          right: index == controller.plans.length - 1 ? 0 : 20,
                        ),
                        child: PricingWidget(
                          plan: controller.plans[index],
                          onToggle: () => controller.togglePlanStatus(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
