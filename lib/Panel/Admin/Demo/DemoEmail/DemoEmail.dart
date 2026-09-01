import 'package:employee_monitoring_system/Panel/Admin/Demo/DemoController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class DemoEmail extends StatelessWidget {
  const DemoEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DemoController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  context.go('/Admin/demo-requests');
                }
                ,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.borderColor.withValues(alpha: 0.6),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 18,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     TextString.adminDemoRequestTitle,
                      style: TTextTheme.titleFive(context).copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      TextString.adminDemoRequestSubtitle,
                      style: TTextTheme.titleSix(context).copyWith(
                        fontSize: 13,
                        color: AppColors.textColor.withValues(alpha: 0.6),
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
              border: Border.all(
                color: AppColors.borderColor.withValues(alpha: 0.6),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextString.adminDemoSendEmail,
                  style: TTextTheme.titleFive(context).copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  TextString.adminDemoSendEmailSubtitle,
                  style: TTextTheme.titleSix(context).copyWith(
                    fontSize: 13,
                    color: AppColors.textColor.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                 TextString.adminDemoFieldOne,
                  style: TTextTheme.titleSix(context)
                ),
                const SizedBox(height: 8),

                TextField(
                  cursorColor: AppColors.textColor,
                  controller: controller.subjectController,
                  style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: TextString.adminDemoFieldOneSubtilte ,
                    hintStyle: TTextTheme.InsideAlreadyWrittenText(context),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.borderColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.borderColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  TextString.adminDemoFieldTwo,
                  style: TTextTheme.titleSix(context)
                ),
                const SizedBox(height: 8),
                TextField(
                  cursorColor: AppColors.textColor,
                  controller: controller.messageController,
                  maxLines: 5,
                  style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
                  decoration: InputDecoration(
                    hintText:TextString.adminDemoFieldTwoSubtitle ,
                    hintStyle: TTextTheme.InsideAlreadyWrittenText(context),
                    contentPadding: const EdgeInsets.all(16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.borderColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.borderColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: Obx(
                  () => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.sendEmail(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.whiteColor,
                  ),
                )
                    : Text(
                  "Save",
                  style: TTextTheme.titleSix(context).copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
