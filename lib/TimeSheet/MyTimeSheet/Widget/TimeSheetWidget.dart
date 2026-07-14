import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/TimeSheet/ReusableWidget/CustomDatePickerDialog.dart';
import 'package:employee_monitoring_system/TimeSheet/ReusableWidget/EditTimeSheetDialog.dart';
import 'package:employee_monitoring_system/TimeSheet/TimeSheetController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:employee_monitoring_system/Resources/AppSizes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimeSheetWidget extends StatefulWidget {
  const TimeSheetWidget({super.key});

  @override
  State<TimeSheetWidget> createState() => _TimeSheetWidgetState();
}

class _TimeSheetWidgetState extends State<TimeSheetWidget> {
  final TimeSheetController controller = Get.put(TimeSheetController());

  @override
  Widget build(BuildContext context) {
    final bool webMode = AppSizes.isWeb(context);
    final double currentWidth = AppSizes.screenWidth(context);
    final double outerPadding =
    currentWidth < 350 ? 8.0 : (webMode ? 24.0 : 16.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(outerPadding),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderControls(context, webMode),
          const SizedBox(height: 20),
          Obx(() {
            final bool isWeekView = controller.selectedViewIndex.value == 1;
            final double minTableWidth = isWeekView ? 950 : 650;

            if (webMode && !isWeekView) {
              return _buildTableContent(context);
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: minTableWidth,
                child: _buildTableContent(context),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// -------- Header Controls ---------- ///
  Widget _buildHeaderControls(BuildContext context, bool webMode) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.spaceBetween,
        spacing: 16,
        runSpacing: 12,
        children: [
          Text(
            "Time Sheet",
            style: webMode
                ? TTextTheme.h1Style(context)
                : TTextTheme.h2Style(context),
          ),
          _buildFilterActionGroup(context),
        ],
      ),
    );
  }

  // Filter Action Group
  Widget _buildFilterActionGroup(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: PopupMenuButton<int>(
            offset: const Offset(0, 42),
            elevation: 12,
            shadowColor: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: AppColors.whiteColor,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<int>(
                enabled: false,
                padding: EdgeInsets.zero,
                child: CustomDatePickerDialog(
                  initialDate: controller.selectedDate.value,
                  isWeekMode: controller.isWeekMode,
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onDateSelected: (newDate, weekRange) {
                    controller.selectedDate.value = newDate;
                    controller.updateFormattedDate();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    IconString.calendarIcon,
                    height: 18,
                    width: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Pick Date",
                    style: TTextTheme.InsideAlreadyWrittenText(context),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_left,
                    size: 18, color: AppColors.tertiaryTextColor),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: controller.previousDate,
              ),
              const SizedBox(width: 4),
              Obx(() => Text(
                controller.formattedDate,
                style: TTextTheme.FieldWriteTheText(context),
              )),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.arrow_right,
                    size: 18, color: AppColors.tertiaryTextColor),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: controller.nextDate,
              ),
            ],
          ),
        ),
        Container(
          height: 38,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.backgroundOfScreenColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(() => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToggleButton("Day", 0, controller),
              _buildToggleButton("Week", 1, controller),
            ],
          )),
        ),
      ],
    );
  }

   // Table Content
  Widget _buildTableContent(BuildContext context) {
    return Obx(() {
      final bool isWeekView = controller.selectedViewIndex.value == 1;

      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfScreenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Checkbox(
                    value: controller.isAllSelected.value,
                    checkColor: AppColors.borderColor,
                    onChanged: controller.toggleAllCheckboxes,
                    side: const BorderSide(
                      color: AppColors.borderColor,
                      width: 1.5,
                    ),
                    activeColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (isWeekView) ...[
                  Expanded(
                      flex: 3,
                      child: Text("Project",
                          style: TTextTheme.titleSeven(context))),
                  Expanded(
                      flex: 2,
                      child: Text("Monday",
                          style: TTextTheme.titleSeven(context))),
                  Expanded(
                      flex: 2,
                      child: Text("Tuesday",
                          style: TTextTheme.titleSeven(context))),
                  Expanded(
                      flex: 2,
                      child: Text("Wednesday",
                          style: TTextTheme.titleSeven(context))),
                  Expanded(
                      flex: 2,
                      child: Text("Thursday",
                          style: TTextTheme.titleSeven(context))),
                  Expanded(
                      flex: 2,
                      child: Text("Friday",
                          style: TTextTheme.titleSeven(context))),
                  Expanded(
                      flex: 2,
                      child: Text("Saturday",
                          style: TTextTheme.titleSeven(context))),
                  Expanded(
                      flex: 2,
                      child: Text("Sunday",
                          style: TTextTheme.titleSeven(context))),
                  Expanded(
                      flex: 2,
                      child: Text("Total hours",
                          style: TTextTheme.titleSeven(context))),
                ] else ...[
                  Expanded(
                      flex: 3,
                      child: Text("Project",
                          style: TTextTheme.titleSeven(context))),
                  Expanded(
                      flex: 2,
                      child: Text("Start Time",
                          style: TTextTheme.titleSeven(context))),
                  Expanded(
                      flex: 2,
                      child: Text("Stop Time",
                          style: TTextTheme.titleSeven(context))),
                  Expanded(
                      flex: 2,
                      child: Text("Duration",
                          style: TTextTheme.titleSeven(context))),
                  SizedBox(
                      width: 50,
                      child: Text("Action",
                          style: TTextTheme.titleSeven(context))),
                ],
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Table Rows List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.timeSheetList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = controller.timeSheetList[index];

              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: Checkbox(
                        value: item.isSelected,
                        onChanged: (val) =>
                            controller.toggleItemCheckbox(index, val),
                        activeColor: AppColors.primaryColor,
                        side: const BorderSide(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),


                    if (isWeekView) ...[
                      Expanded(
                          flex: 3,
                          child: Text(item.project,
                              style: TTextTheme.titleEight(context))),
                      Expanded(
                          flex: 2,
                          child: Text(item.mondayHours ?? "6hrs",
                              style: TTextTheme.titleFour(context))),
                      Expanded(
                          flex: 2,
                          child: Text(item.tuesdayHours ?? "6hrs",
                              style: TTextTheme.titleFour(context))),
                      Expanded(
                          flex: 2,
                          child: Text(item.wednesdayHours ?? "6hrs",
                              style: TTextTheme.titleFour(context))),
                      Expanded(
                          flex: 2,
                          child: Text(item.thursdayHours ?? "6hrs",
                              style: TTextTheme.titleFour(context))),
                      Expanded(
                          flex: 2,
                          child: Text(item.fridayHours ?? "6hrs",
                              style: TTextTheme.titleFour(context))),
                      Expanded(
                          flex: 2,
                          child: Text(item.saturdayHours ?? "5hrs",
                              style: TTextTheme.titleFour(context))),
                      Expanded(
                          flex: 2,
                          child: Text(item.sundayHours ?? "5hrs",
                              style: TTextTheme.titleFour(context))),
                      Expanded(
                          flex: 2,
                          child: Text(item.totalHours ?? "40 hrs",
                              style: TTextTheme.titleFour(context))),
                    ] else ...[
                      Expanded(
                          flex: 3,
                          child: Text(item.project,
                              style: TTextTheme.titleEight(context))),
                      Expanded(
                          flex: 2,
                          child: Text(item.startTime,
                              style: TTextTheme.titleFour(context))),
                      Expanded(
                          flex: 2,
                          child: Text(item.stopTime,
                              style: TTextTheme.titleFour(context))),
                      Expanded(
                          flex: 2,
                          child: Text(item.duration,
                              style: TTextTheme.titleFour(context))),
                      SizedBox(
                        width: 50,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => EditTimeSheetDialog(
                                initialProject: item.project,
                                initialFromTime: item.startTime,
                                initialToTime: item.stopTime,
                                onSave: (project, fromTime, toTime, reason) {
                                  controller.updateTimeSheetEntry(
                                    index: index,
                                    project: project,
                                    startTime: fromTime,
                                    stopTime: toTime,
                                    reason: reason,
                                  );
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              IconString.editIcon,
                              height: 18,
                              width: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      );
    });
  }

  // Toggle Button
  Widget _buildToggleButton(
      String label, int index, TimeSheetController controller) {
    final isSelected = controller.selectedViewIndex.value == index;
    return InkWell(
      onTap: () => controller.toggleView(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: isSelected
              ? TTextTheme.TabsSelectedText(context)
              : TTextTheme.titleThree(context),
        ),
      ),
    );
  }
}