import 'package:employee_monitoring_system/ActivityTracking/ActivityTrackingController.dart';
import 'package:employee_monitoring_system/ActivityTracking/ReusableWidget/CustomDatePickerActivityDialog.dart';
import 'package:employee_monitoring_system/ActivityTracking/ReusableWidget/MonthlyActivityGraph.dart';
import 'package:employee_monitoring_system/ActivityTracking/ReusableWidget/WeeklyGraphActivity.dart';
import 'package:employee_monitoring_system/Resources/AppSizes.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ActivityTrackingWidget extends StatelessWidget {
  const ActivityTrackingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ActivityController controller = Get.put(ActivityController());
    final bool webMode = AppSizes.isWeb(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        _buildDateSelectorBar(context, controller),
        const SizedBox(height: 20),
        _buildStatsGrid(context, webMode),
        const SizedBox(height: 20),

        Obx(() {
          final int selectedIndex = controller.selectedViewIndex.value;
          final bool isDayMode = selectedIndex == 0;
          final bool isWeekMode = selectedIndex == 1;
          final bool isMonthMode = selectedIndex == 2;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isWeekMode) ...[
                WeeklyActivityGraphWidget(controller: controller),
                const SizedBox(height: 20),
              ],
              if (isMonthMode) ...[
                MonthlyActivityGraphWidget(controller: controller),
                const SizedBox(height: 20),
              ],
              if (isDayMode) ...[
                _buildActivityTimeline(context),
                const SizedBox(height: 20),
              ],
              _buildSessionBreakdownTable(context, webMode),
            ],
          );
        }),
      ],
    );
  }

   /// -------- Extra Widget ----------- ///
  // Date Selector
  Widget _buildDateSelectorBar(BuildContext context, ActivityController controller) {
    final RxBool isDropdownOpen = false.obs;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: isMobile ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                IconString.calendarIcon,
                height: 18,
                width: 18,
              ),
              const SizedBox(width: 8),
              Obx(() {
                final bool isMonthMode = controller.selectedViewIndex.value == 2;
                return Text(
                  isMonthMode ? TextString.selectedMonth : TextString.selectedDate ,
                  style: TTextTheme.titleSeven(context).copyWith(fontSize: 13),
                );
              }),
              Obx(() => Text(
                controller.selectedDateStr.value,
                style: TTextTheme.FieldWriteTheText(context).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
            ],
          ),
          if (isMobile) const SizedBox(height: 12),
          Obx(() {
            final bool isMonthMode = controller.selectedViewIndex.value == 2;

            if (isMonthMode) {
              final String currentMonth = DateFormat('MMMM').format(controller.currentSelectedDate.value);

              return PopupMenuButton<String>(
                constraints: BoxConstraints(
                  minWidth: isMobile ? screenWidth - 60 : 120,
                  maxWidth: isMobile ? screenWidth - 60 : 140,
                  maxHeight: 350,
                ),
                offset: const Offset(0, 42),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: AppColors.whiteColor,
                elevation: 4,
                onOpened: () => isDropdownOpen.value = true,
                onCanceled: () => isDropdownOpen.value = false,
                onSelected: (String val) {
                  controller.updateSelectedMonth(val);
                  isDropdownOpen.value = false;
                },
                child: Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.borderColor,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                    mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                    children: [
                      Text(
                        currentMonth,
                        style: TTextTheme.InsideAlreadyWrittenText(context).copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        isDropdownOpen.value
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textColor,
                        size: 18,
                      ),
                    ],
                  ),
                )),
                itemBuilder: (BuildContext context) {
                  return controller.monthsList.map((String month) {
                    final bool isSelected = month == currentMonth;

                    return PopupMenuItem<String>(
                      value: month,
                      height: 40,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor.withOpacity(0.08)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          month,
                          style: TTextTheme.titleSeven(context).copyWith(
                            color: isSelected ? AppColors.primaryColor : AppColors.textColor,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }).toList();
                },
              );
            } else {
              return OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: CustomDatePickerActivityDialog(
                          initialDate: controller.currentSelectedDate.value,
                          isWeekMode: controller.selectedViewIndex.value == 1,
                          onCancel: () => Navigator.pop(context),
                          onDateSelected: (DateTime selectedDate, DateTimeRange? weekRange) {
                            controller.updateSelectedDate(
                                selectedDate,
                                weekRange,
                                controller.selectedViewIndex.value == 1
                            );
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.borderColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      IconString.calendarIcon,
                      height: 14,
                      width: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      TextString.pickDateTitle,
                      style: TTextTheme.InsideAlreadyWrittenText(context).copyWith(fontSize: 12),
                    ),
                  ],
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  // Stats Cards Grid
  Widget _buildStatsGrid(BuildContext context, bool webMode) {
    final cards = [
      _buildStatCard(
        context: context,
        title:TextString.averageActivity ,
        value: "87%",
        color: AppColors.primaryColor,
        progress: 0.8,
        iconPath: IconString.averageActivity
      ),
      _buildStatCard(
        context: context,
        title:TextString.mouseActivity ,
        value: "77%",
        color: AppColors.approvedColor,
        progress: 0.77,
        iconPath: IconString.mouseActivity
      ),
      _buildStatCard(
        context: context,
        title:TextString.keyboardActivity,
        value: "45%",
        color: AppColors.graphColor,
        progress: 0.45,
        iconPath: IconString.keyboardActivity
      ),
      _buildStatCard(
        context: context,
        title:TextString.idleTime ,
        value: "45 minutes",
        color: AppColors.tertiaryTextColor,
        progress: 0.35,
        iconPath: IconString.idleTime
      ),
    ];

    if (webMode) {
      return Row(
        children: cards.map((card) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: card,
          ),
        )).toList(),
      );
    } else {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: MediaQuery.of(context).size.width > 550 ? 2 : 1,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: MediaQuery.of(context).size.width > 550 ? 2.3 : 2.8,
        children: cards,
      );
    }
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required Color color,
    required double progress,
    required String iconPath,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
                height: 16,
                width: 16,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TTextTheme.titleSeven(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              value,
              style: TTextTheme.h2Style(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          )
        ],
      ),
    );
  }

  //  Activity Timeline Chart Container
  Widget _buildActivityTimeline(BuildContext context) {
    final List<Map<String, dynamic>> blocks = [
      {'color': AppColors.approvedColor, 'type': 'high'},
      {'color': AppColors.approvedColor, 'type': 'high'},
      {'color': AppColors.approvedColor, 'type': 'high'},
      {'color':AppColors.approvedColor, 'type': 'high'},
      {'color': AppColors.pendingColor, 'type': 'low'},
      {'color': AppColors.pendingColor, 'type': 'low'},
      {'color': AppColors.approvedColor, 'type': 'high'},
      {'color': AppColors.borderColor, 'type': 'idle'},
      {'color': AppColors.approvedColor, 'type': 'high'},
      {'color': AppColors.approvedColor, 'type': 'high'},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.activityTimeline, style: TTextTheme.titleEight(context)),
          Text(TextString.activityTimelineSubtitle, style: TTextTheme.titleSix(context)),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildLegendItem(context,TextString.highActivity , AppColors.approvedColor),
              const SizedBox(width: 14),
              _buildLegendItem(context,TextString.lowActivity , AppColors.pendingColor),
              const SizedBox(width: 14),
              _buildLegendItem(context,TextString.idleTime , AppColors.borderColor),
            ],
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 800,
              child: Column(
                children: [
                  Row(
                    children: blocks.map((b) => Expanded(
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: b['color'],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("9:00", style: TTextTheme.titleSix(context)),
                      Text("12:00", style: TTextTheme.titleSix(context)),
                      Text("15:00", style: TTextTheme.titleSix(context)),
                      Text("18:00", style: TTextTheme.titleSix(context)),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 6),
        Text(label, style: TTextTheme.InsideAlreadyWrittenText(context)),
      ],
    );
  }

  //  Session Breakdown Data Table Container
  Widget _buildSessionBreakdownTable(BuildContext context, bool webMode) {
    final ActivityController controller = Get.find<ActivityController>();

    final tableWidget = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.sessionBreakdown, style: TTextTheme.titleEight(context)),
          Text(TextString.sessionBreakdownSubtitle, style: TTextTheme.titleSix(context)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfScreenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Obx(() => Checkbox(
                    value: controller.isAllSelected.value,
                    onChanged: controller.toggleAllCheckboxes,
                    side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                    activeColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  )),
                ),
                const SizedBox(width: 12),
                Expanded(flex: 3, child: Text(TextString.timeSlot, style: TTextTheme.titleSeven(context))),
                Expanded(flex: 2, child: Text(TextString.mousePercent, style: TTextTheme.titleSeven(context))),
                Expanded(flex: 2, child: Text(TextString.keyboardPercent, style: TTextTheme.titleSeven(context))),
                Expanded(flex: 2, child: Text(TextString.idlePercent, style: TTextTheme.titleSeven(context))),
                Expanded(flex: 2, child: Text(TextString.overall, style: TTextTheme.titleSeven(context))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.sessionList.length,
            itemBuilder: (context, index) {
              final item = controller.sessionList[index];
              Color overallColor = AppColors.approvedColor;
              if (item.overallPercentage == "60%") {
                overallColor = AppColors.pendingColor;
              }

              return _buildTableRow(
                context: context,
                index: index,
                slot: item.timeSlot,
                mouse: item.mousePercentage,
                kb: item.keyboardPercentage,
                idle: item.idlePercentage,
                overall: item.overallPercentage,
                overallColor: overallColor,
                isSelected: item.isSelected,
                controller: controller,
              );
            },
          )),
        ],
      ),
    );

    if (webMode) {
      return tableWidget;
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: SizedBox(width: 750, child: tableWidget),
      );
    }
  }

  Widget _buildTableRow({
    required BuildContext context,
    required int index,
    required String slot,
    required String mouse,
    required String kb,
    required String idle,
    required String overall,
    required Color overallColor,
    required bool isSelected,
    required ActivityController controller,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: isSelected,
              onChanged: (val) => controller.toggleItemCheckbox(index, val),
              side: const BorderSide(color: AppColors.borderColor, width: 1.5),
              activeColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(flex: 3, child: Text(slot, style: TTextTheme.titleEight(context))),
          Expanded(flex: 2, child: Text(mouse, style: TTextTheme.titleFour(context))),
          Expanded(flex: 2, child: Text(kb, style: TTextTheme.titleFour(context))),
          Expanded(flex: 2, child: Text(idle, style: TTextTheme.titleFour(context))),
          Expanded(
            flex: 2,
            child: Text(
              overall,
              style: TTextTheme.titleEight(context).copyWith(color: overallColor),
            ),
          ),
        ],
      ),
    );
  }
}
