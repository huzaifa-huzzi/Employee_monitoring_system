import 'package:employee_monitoring_system/Panel/Admin/Demo/DemoController.dart';
import 'package:employee_monitoring_system/Panel/Admin/Demo/ReusableWidget/CustomDatePickerDemoDialog.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart' show AppColors;
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../ReusableWidget/CustomTimePickerDemoDialog.dart';


class DemoRequest extends StatelessWidget {
  const DemoRequest({super.key});

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
                },
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
                 TextString.adminDemoSchedule,
                  style: TTextTheme.titleFive(context).copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  TextString.adminDemoScheduleSubtitle,
                  style: TTextTheme.titleSix(context).copyWith(
                    fontSize: 13,
                    color: AppColors.textColor.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 24),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isSmallScreen = constraints.maxWidth < 650;

                    if (isSmallScreen) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDateField(context, controller),
                          const SizedBox(height: 16),
                          _buildTimeField(context, controller),
                          const SizedBox(height: 16),
                          _buildDurationField(context, controller),
                          const SizedBox(height: 16),
                          _buildMeetingTypeDropdown(context, controller),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildDateField(context, controller)),
                            const SizedBox(width: 20),
                            Expanded(child: _buildTimeField(context, controller)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildDurationField(context, controller)),
                            const SizedBox(width: 20),
                            Expanded(child: _buildMeetingTypeDropdown(context, controller)),
                          ],
                        ),
                      ],
                    );
                  },
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
                    : () => controller.scheduleDemo(),
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

  /// ---------- Extra Widget -------------- ///

   // Date Field
  Widget _buildDateField(BuildContext context, DemoController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.adminDemoDate, style: TTextTheme.titleSix(context)),
        const SizedBox(height: 8),
        TextField(
          controller: controller.demoDateController,
          readOnly: true,
          style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomDatePickerDemoDialog(
                    initialDate: DateTime.now(),
                    onCancel: () {
                      Navigator.pop(dialogContext);
                    },
                    onDateSelected: (DateTime selectedDate) {
                      controller.demoDateController.text =
                      "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year.toString().substring(2)}";
                      Navigator.pop(dialogContext);
                    },
                  ),
                );
              },
            );
          },
          decoration: InputDecoration(
            hintText:TextString.adminDemoDateField,
            hintStyle: TTextTheme.InsideAlreadyWrittenText(context),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                IconString.calendarIcon,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  AppColors.textColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
          ),
        ),
      ],
    );
  }

  // Time Field
  Widget _buildTimeField(BuildContext context, DemoController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.adminDemoTime, style: TTextTheme.titleSix(context)),
        const SizedBox(height: 8),
        TextField(
          controller: controller.demoTimeController,
          readOnly: true,
          style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return CustomTimePickerDialog(
                  initialTime: controller.demoTimeController.text.isNotEmpty
                      ? controller.demoTimeController.text
                      : '12:00 PM',
                  onTimeSelected: (String selectedTime) {
                    controller.demoTimeController.text = selectedTime;
                  },
                );
              },
            );
          },
          decoration: InputDecoration(
            hintText: TextString.adminDemoSelectTime,
            hintStyle: TTextTheme.InsideAlreadyWrittenText(context),
            suffixIcon: const Icon(
              Icons.unfold_more,
              size: 18,
              color: AppColors.textColor,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
          ),
        ),
      ],
    );
  }

   // Duration Field
  Widget _buildDurationField(BuildContext context, DemoController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.adminDemoDuration, style: TTextTheme.titleSix(context)),
        const SizedBox(height: 8),
        TextField(
          controller: controller.durationController,
          cursorColor: AppColors.textColor,
          style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
          decoration: InputDecoration(
            hintText:TextString.adminDurationField ,
            hintStyle: TTextTheme.InsideAlreadyWrittenText(context),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
          ),
        ),
      ],
    );
  }

   // Meeting Type Dropdown
  Widget _buildMeetingTypeDropdown(BuildContext context, DemoController controller) {
    const options = [
      'Google Meet',
      'Zoom',
      'Microsoft Teams',
      'Phone Call',
      'In Person'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.adminDemoMeeting, style: TTextTheme.titleSix(context)),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            return Obx(
                  () => PopupMenuButton<String>(
                onOpened: () => controller.isMeetingTypeDropdownOpen.value = true,
                onCanceled: () => controller.isMeetingTypeDropdownOpen.value = false,
                onSelected: (val) {
                  controller.isMeetingTypeDropdownOpen.value = false;
                  controller.selectedMeetingType.value = val;
                },
                constraints: BoxConstraints.tightFor(width: constraints.maxWidth),
                offset: const Offset(0, 52),
                color: AppColors.whiteColor,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                itemBuilder: (context) => options
                    .map(
                      (e) => PopupMenuItem<String>(
                    value: e,
                    height: 40,
                    child: Text(
                      e,
                      style: TTextTheme.titleSix(context).copyWith(
                        fontSize: 13,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                )
                    .toList(),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.selectedMeetingType.value,
                        style: controller.selectedMeetingType.value == 'Enter Type'
                            ? TTextTheme.InsideAlreadyWrittenText(context)
                            : TTextTheme.titleSix(context).copyWith(fontSize: 13),
                      ),
                      Icon(
                        controller.isMeetingTypeDropdownOpen.value
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 18,
                        color: AppColors.textColor,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
