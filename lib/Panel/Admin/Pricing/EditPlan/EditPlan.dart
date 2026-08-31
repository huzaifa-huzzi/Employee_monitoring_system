import 'package:employee_monitoring_system/Panel/Admin/Pricing/PricingController.dart';
import 'package:employee_monitoring_system/Panel/Admin/Pricing/ReusableWidget/PrimaryBtnOfPricing.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class EditPlan extends StatelessWidget {
  const EditPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PricingController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      context.go('/Admin/pricing-plans');
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.whiteColor,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 18,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         TextString.adminPricingEditTitle,
                          style: TTextTheme.titleFive(context).copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          TextString.adminPricingEditSubtitle,
                          style: TTextTheme.titleSix(context).copyWith(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextString.adminPricingPlanDetails,
                      style: TTextTheme.titleFive(context).copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      TextString.adminPricingPlanDetailsSubtitle,
                      style: TTextTheme.titleSix(context).copyWith(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildFieldLabel(context, TextString.adminFieldLAbelOne),
                    const SizedBox(height: 8),
                    _buildTextField(
                      context: context,
                      controller: controller.planNameController,
                      hintText: TextString.adminFieldLAbelOneSubtitle,
                    ),
                    const SizedBox(height: 20),
                    _buildFieldLabel(context, TextString.adminFieldLAbelTwo),
                    const SizedBox(height: 8),
                    _buildTextField(
                      context: context,
                      controller: controller.descriptionController,
                      hintText: TextString.adminFieldLAbelTwoSubtitle,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isSmallScreen = constraints.maxWidth < 600;

                        if (isSmallScreen) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(context, TextString.adminFirldLabelThree),
                              const SizedBox(height: 8),
                              _buildTextField(
                                context: context,
                                controller: controller.monthlyPriceController,
                                hintText: TextString.adminFirldLabelThreeSubtitle,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 20),
                              _buildFieldLabel(context, TextString.adminFieldLabelFour),
                              const SizedBox(height: 8),
                              _buildTextField(
                                context: context,
                                controller: controller.yearlyPriceController,
                                hintText: TextString.adminFieldLabelFourSubtitle,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFieldLabel(context, TextString.adminFieldLabelFive),
                                  const SizedBox(height: 8),
                                  _buildTextField(
                                    context: context,
                                    controller: controller.monthlyPriceController,
                                    hintText: TextString.adminFieldLabelFiveSubtitle,
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFieldLabel(context, TextString.adminFieldLabelSix),
                                  const SizedBox(height: 8),
                                  _buildTextField(
                                    context: context,
                                    controller: controller.yearlyPriceController,
                                    hintText: TextString.adminFieldLabelSixSubtitle,
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildFieldLabel(context, TextString.adminFieldLabelSeven),
                    const SizedBox(height: 8),
                    _buildTextField(
                      context: context,
                      controller: controller.employeeLimitController,
                      hintText: TextString.adminFieldLabelSevenSubtitle,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isSmallScreen = constraints.maxWidth < 600;

                        final trailDurationField = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel(context, TextString.adminTrailDuration),
                            const SizedBox(height: 8),
                            _buildTextField(
                              context: context,
                              controller: controller.trialDurationController,
                              hintText: TextString.adminTrailDurationSubtitle,
                            ),
                          ],
                        );

                        final trailSwitch = Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() => Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: controller.isTrialAvailable.value,
                                onChanged: controller.toggleTrial,
                                activeThumbColor: AppColors.primaryColor,
                              ),
                            )),
                            const SizedBox(width: 4),
                            Text(
                              TextString.adminTrailAvailable,
                              style: TTextTheme.titleFive(context).copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );

                        if (isSmallScreen) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              trailDurationField,
                              const SizedBox(height: 16),
                              trailSwitch,
                            ],
                          );
                        }

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(child: trailDurationField),
                            const SizedBox(width: 24),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: trailSwitch,
                            ),
                            const Spacer(),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _buildFieldLabel(context, TextString.adminLabelFeature),
                        Text(
                          TextString.adminLabelFeatureSubtitle,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      context: context,
                      controller: controller.featuresController,
                      hintText: TextString.adminLabelFeatureSubtitleTwo,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: PrimaryBtnOfPricing(
                  text: "Save",
                  width: 100,
                  height: 40,
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    controller.updatePlan();
                    context.go('/Admin/pricing-plans');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --------- Extra Helpers ------------- ///

  Widget _buildFieldLabel(BuildContext context, String title) {
    return Text(
      title,
      style: TTextTheme.titleFive(context).copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      cursorColor: AppColors.textColor,
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TTextTheme.InsideAlreadyWrittenText(context),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
      ),
    );
  }
}
