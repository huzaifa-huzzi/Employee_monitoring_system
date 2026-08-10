import 'package:employee_monitoring_system/Panel/Vendor/VendorActivityTracking/ReusableWidget/customDatePickerVendorActivity.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorActivityTracking/VendorActivityController.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorActivityTracking/Widget/VendorActivityTeamTracking.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:intl/intl.dart';

class VendorActivityTrackingWidget extends StatelessWidget {
  const VendorActivityTrackingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VendorActivityController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(context, controller),
        const SizedBox(height: 20),
        _buildFilterBar(context, controller),
        const SizedBox(height: 20),
        _buildMetricsRow(context),
        const SizedBox(height: 24),
        Obx(() {
          if (controller.selectedMainTab.value == "Team") {
            return const VendorActivityTeamTracking();
          }

          if (controller.isDetailView.value) {
            return _buildEmployeeDetailView(context, controller);
          }
          return _buildTableCard(context, controller);
        }),
      ],
    );
  }

  /// -------- Extra Widget ------------///

  // Header Dynamic
  Widget _buildHeader(BuildContext context, VendorActivityController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        final titleSection = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final isTeamEmployeeDetail = controller.selectedTeamEmployeeDetail.value != null;
              final isShowingTeamEmp = controller.isShowingTeamEmployees.value;
              final isEmpDetail = controller.isDetailView.value;
              final currentTab = controller.selectedMainTab.value;

              final showBack = (currentTab == "Employees" && isEmpDetail) ||
                  (currentTab == "Team" && (isShowingTeamEmp || isTeamEmployeeDetail));

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showBack) ...[
                    InkWell(
                      onTap: () {
                        if (currentTab == "Team") {
                          if (isTeamEmployeeDetail) {
                            controller.hideTeamEmployeeDetail();
                          }
                          else if (isShowingTeamEmp) {
                            controller.isShowingTeamEmployees.value = false;
                          }
                        } else {
                          controller.backToEmployeeList();
                        }
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 6.0),
                        child: Icon(
                          Icons.chevron_left,
                          size: 28,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ],
                  Text(
                   TextString.vendorActivityTitle,
                    style: TTextTheme.h2Style(context).copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 4),
            Text(
              TextString.vendorActivitySubtitle,
              style: TTextTheme.titleSix(context).copyWith(
                color: AppColors.tertiaryTextColor,
                fontSize: 13,
              ),
            ),
          ],
        );

        final pillTabs = Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
          ),
          child: Obx(
                () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPillTab(
                  context: context,
                  title:TextString.vendorActivityTabOne ,
                  isSelected: controller.selectedMainTab.value == "Employees",
                  onTap: () => controller.selectedMainTab.value = "Employees",
                ),
                _buildPillTab(
                  context: context,
                  title:TextString.vendorActivityTabTwo ,
                  isSelected: controller.selectedMainTab.value == "Team",
                  onTap: () => controller.selectedMainTab.value = "Team",
                ),
              ],
            ),
          ),
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleSection,
              const SizedBox(height: 12),
              pillTabs,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            titleSection,
            pillTabs,
          ],
        );
      },
    );
  }

  Widget _buildPillTab({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TTextTheme.titleSix(context).copyWith(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.whiteColor : AppColors.tertiaryTextColor,
          ),
        ),
      ),
    );
  }

  // filter Bar
  Widget _buildFilterBar(BuildContext context, VendorActivityController controller) {
    String formatDisplayDate() {
      final DateTime date = controller.selectedDate.value;
      final String mode = controller.selectedTimeframe.value;

      if (mode == "Day") {
        return DateFormat('d MMMM, yyyy').format(date);
      } else if (mode == "Week") {
        int currentDayOfWeek = date.weekday;
        DateTime startOfWeek = date.subtract(Duration(days: currentDayOfWeek - 1));
        DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
        return "${DateFormat('d MMM').format(startOfWeek)} - ${DateFormat('d MMM, yyyy').format(endOfWeek)}";
      } else {
        int currentDayOfWeek = date.weekday;
        DateTime startOfWeek = date.subtract(Duration(days: currentDayOfWeek - 1));
        DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
        DateTime startOf4Weeks = endOfWeek.subtract(const Duration(days: 27));
        return "${DateFormat('d MMM').format(startOf4Weeks)} - ${DateFormat('d MMM, yyyy').format(endOfWeek)}";
      }
    }

    void openCustomDatePicker() {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: CustomDatePickerVendorActivity(
              initialDate: controller.selectedDate.value,
              timeFilterMode: controller.selectedTimeframe.value,
              onCancel: () => Navigator.pop(dialogContext),
              onDateSelected: (selectedDate, weekRange) {
                controller.selectedDate.value = selectedDate;
                Navigator.pop(dialogContext);
              },
            ),
          );
        },
      );
    }

    void navigateDate(bool isNext) {
      final mode = controller.selectedTimeframe.value;
      final currentDate = controller.selectedDate.value;
      final factor = isNext ? 1 : -1;

      if (mode == "Day") {
        controller.selectedDate.value = currentDate.add(Duration(days: 1 * factor));
      } else if (mode == "Week") {
        controller.selectedDate.value = currentDate.add(Duration(days: 7 * factor));
      } else {
        controller.selectedDate.value = currentDate.add(Duration(days: 28 * factor));
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          final datePicker = Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  icon: const Icon(
                    Icons.arrow_left_rounded,
                    size: 24,
                    color: AppColors.tertiaryTextColor,
                  ),
                  onPressed: () => navigateDate(false),
                ),
                InkWell(
                  onTap: openCustomDatePicker,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Obx(
                          () => Text(
                        formatDisplayDate(),
                        style: TTextTheme.titleSix(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  icon: const Icon(
                    Icons.arrow_right_rounded,
                    size: 24,
                    color: AppColors.tertiaryTextColor,
                  ),
                  onPressed: () => navigateDate(true),
                ),
              ],
            ),
          );

          final timeframeTabs = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Obx(
                    () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTimeframeTab(
                      context,
                      TextString.vendorActivityDay,
                      controller.selectedTimeframe.value == "Day",
                          () {
                        controller.selectedTimeframe.value = "Day";
                      },
                    ),
                    _buildTimeframeTab(
                      context,
                      TextString.vendorActivityWeek,
                      controller.selectedTimeframe.value == "Week",
                          () {
                        controller.selectedTimeframe.value = "Week";
                        controller.backToEmployeeList();
                      },
                    ),
                    _buildTimeframeTab(
                      context,
                      TextString.vendorActivityLast4week,
                      controller.selectedTimeframe.value == "Last 4 Week",
                          () {
                        controller.selectedTimeframe.value = "Last 4 Week";
                        controller.backToEmployeeList();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );

          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                datePicker,
                const SizedBox(height: 12),
                timeframeTabs,
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              datePicker,
              timeframeTabs,
            ],
          );
        },
      ),
    );
  }
  Widget _buildTimeframeTab(
      BuildContext context,
      String title,
      bool isSelected,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: TTextTheme.titleSix(context).copyWith(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.whiteColor : AppColors.textColor,
          ),
        ),
      ),
    );
  }

  // Metrics Row
  Widget _buildMetricsRow(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        int crossAxisCount = 4;
        if (width < 600) {
          crossAxisCount = 1;
        } else if (width < 950) {
          crossAxisCount = 2;
        }

        final cards = [
          _buildMetricCard(
            context: context,
            iconPath: IconString.averageActivity,
            title: TextString.vendorKpiOne,
            value: TextString.vendorKpiTwo,
            progress: 0.87,
            progressColor: AppColors.primaryColor,
          ),
          _buildMetricCard(
            context: context,
            iconPath: IconString.mouseActivity,
            title:TextString.vendorKpiThree,
            value:TextString.vendorKpiFour ,
            progress: 0.77,
            progressColor: AppColors.approvedColor,
          ),
          _buildMetricCard(
            context: context,
            iconPath: IconString.keyboardActivity,
            title:TextString.vendorKpiFive ,
            value:TextString.vendorKpiSix ,
            progress: 0.45,
            progressColor: AppColors.graphColor,
          ),
          _buildMetricCard(
            context: context,
            iconPath: IconString.idleTime,
            title:TextString.vendorKpiSeven,
            value:TextString.vendorKpiEight ,
            progress: 0.40,
            progressColor: AppColors.rejectedColor,
          ),
        ];

        if (crossAxisCount == 4) {
          return Row(
            children: cards
                .map((card) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: card,
              ),
            ))
                .toList()
              ..last = Expanded(child: cards.last),
          );
        } else {
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: cards
                .map((card) => SizedBox(
              width: crossAxisCount == 1 ? width : (width - 12) / 2,
              child: card,
            ))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildMetricCard({
    required BuildContext context,
    required String title,
    required String value,
    required double progress,
    required Color progressColor,
    required String iconPath,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  progressColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TTextTheme.titleSix(context).copyWith(
                    fontSize: 12,
                    color: AppColors.tertiaryTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.backgroundOfScreenColor,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
        ],
      ),
    );
  }

  // Employee Table Card
  Widget _buildTableCard(BuildContext context, VendorActivityController controller) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 650;

              final titleSection = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TextString.vendorActivityEmployeeActivity,
                    style: TTextTheme.h2Style(context).copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                   TextString.vendorActivityEmployeeActivitySubtitle,
                    style: TTextTheme.titleSix(context).copyWith(
                      color: AppColors.tertiaryTextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              );

              final searchField = SizedBox(
                width: isMobile ? double.infinity : 260,
                height: 42,
                child: TextField(
                  cursorColor: AppColors.textColor,
                  onChanged: (val) => controller.searchQuery.value = val,
                  style: TTextTheme.titleSix(context).copyWith(
                    fontSize: 13,
                    color: AppColors.textColor,
                  ),
                  decoration: InputDecoration(
                    hintText:TextString.vendorActivityEmployeeActiviyFieldText,
                    hintStyle: TTextTheme.titleSix(context).copyWith(
                      fontSize: 12,
                      color: AppColors.tertiaryTextColor,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                      color: AppColors.tertiaryTextColor,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
                    ),
                  ),
                ),
              );

              if (isMobile) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleSection,
                    const SizedBox(height: 16),
                    searchField,
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  titleSection,
                  searchField,
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final double minTableWidth = 780.0;
              final double currentTableWidth =
              constraints.maxWidth < minTableWidth ? minTableWidth : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: currentTableWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTableHeader(context, controller),
                      const SizedBox(height: 10),
                      Obx(
                            () => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.filteredList.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final member = controller.filteredList[index];
                            return _buildTableRow(
                              context: context,
                              controller: controller,
                              member: member,
                              index: index,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          _buildPagination(context, controller),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context, VendorActivityController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 20,
            child: Obx(
                  () => Checkbox(
                value: controller.isAllSelected.value,
                onChanged: (val) => controller.toggleSelectAll(val),
                activeColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.8)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              TextString.vendorActivityEmployeeTableOne,
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              TextString.vendorActivityEmployeeTableTwo,
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              TextString.vendorActivityEmployeeTableThree,
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              TextString.vendorActivityEmployeeTableFour,
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
             TextString.vendorActivityEmployeeTableFive,
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              TextString.vendorActivityEmployeeTableSix,
              textAlign: TextAlign.center,
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow({
    required BuildContext context,
    required VendorActivityController controller,
    required EmployeeActivityModel member,
    required int index,
  }) {
    Color overallColor = AppColors.approvedColor;
    if (member.overallPercent < 70) {
      overallColor = AppColors.pendingColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 20,
            child: Checkbox(
              value: member.isSelected,
              onChanged: (val) => controller.toggleSelectMember(index, val),
              activeColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.8)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                SvgPicture.asset(
                  IconString.employeePerson,
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        member.name,
                        style: TTextTheme.h2Style(context).copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        member.email,
                        style: TTextTheme.titleSix(context).copyWith(
                          fontSize: 11,
                          color: AppColors.tertiaryTextColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              member.mousePercent,
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              member.keyboardPercent,
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              member.idlePercent,
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "${member.overallPercent}%",
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: overallColor,
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: Center(
              child: InkWell(
                onTap: () => controller.openEmployeeDetail(member),
                child: const Icon(
                  Icons.visibility_outlined,
                  size: 18,
                  color: AppColors.textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(BuildContext context, VendorActivityController controller) {
    return Obx(
          () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: controller.currentPage.value > 1 ? () => controller.currentPage.value-- : null,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.chevron_left,
                size: 18,
                color: AppColors.textColor,
              ),
            ),
          ),
          Text(
            "Page ${controller.currentPage.value} of ${controller.totalPages.value}",
            style: TTextTheme.titleSix(context).copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
          InkWell(
            onTap: controller.currentPage.value < controller.totalPages.value
                ? () => controller.currentPage.value++
                : null,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.chevron_right,
                size: 18,
                color: AppColors.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Detail Views
  Widget _buildEmployeeDetailView(BuildContext context, VendorActivityController controller) {
    final employee = controller.selectedEmployeeForDetail.value;
    final name = employee?.name ?? "Jack Milson";
    final email = employee?.email ?? "jack@gmail.com";

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        IconString.employeePerson,
                        width: 16,
                        height: 16,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TTextTheme.titleSix(context).copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor,
                              ),
                            ),
                            Text(
                              email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TTextTheme.titleSix(context).copyWith(
                                fontSize: 11,
                                color: AppColors.tertiaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.approvedColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  TextString.vendorActivityOnline,
                  style: TTextTheme.titleSix(context).copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() {
            final timeframe = controller.selectedTimeframe.value;

            if (timeframe == "Last 4 Weeks" || timeframe == "Last 4 Week") {
              return Column(
                children: [
                  _buildMonthlyGraphCard(context),
                  const SizedBox(height: 16),
                  _buildWeekBreakdownTable(context, controller),
                ],
              );
            } else if (timeframe == "Week") {
              return Column(
                children: [
                  _buildWeeklyGraphCard(context),
                  const SizedBox(height: 16),
                  _buildDayBreakdownTable(context, controller),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildDailyGraphCard(context),
                  const SizedBox(height: 16),
                  _buildSessionBreakdownTable(context, controller),
                ],
              );
            }
          }),
        ],
      ),
    );
  }


   // Daily breakdown
  Widget _buildDayBreakdownTable(BuildContext context, VendorActivityController controller) {
    final days = [
      {"day": "Monday", "mouse": "33%", "key": "55%", "idle": "5%", "overall": "78%"},
      {"day": "Tuesday", "mouse": "44%", "key": "45%", "idle": "10%", "overall": "90%"},
      {"day": "Wednesday", "mouse": "55%", "key": "65%", "idle": "8%", "overall": "60%"},
      {"day": "Thursday", "mouse": "30%", "key": "34%", "idle": "12%", "overall": "82%"},
      {"day": "Friday", "mouse": "70%", "key": "30%", "idle": "15%", "overall": "85%"},
      {"day": "Saturday", "mouse": "70%", "key": "30%", "idle": "15%", "overall": "85%"},
      {"day": "Sunday", "mouse": "70%", "key": "30%", "idle": "15%", "overall": "85%"},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.vendorActivityDayBreakdown,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
           TextString.vendorActivityDayBreakdownSubtitle,
            style: TTextTheme.titleSix(context).copyWith(
              fontSize: 11,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              const double minWidth = 650.0;
              final currentWidth = constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: currentWidth,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Obx(() {
                              final isAllSelected = controller.selectedDayIndices.length == days.length && days.isNotEmpty;
                              return SizedBox(
                                width: 24,
                                height: 18,
                                child: Checkbox(
                                  value: isAllSelected,
                                  onChanged: (_) => controller.toggleSelectAllDays(days.length),
                                  activeColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                ),
                              );
                            }),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 3,
                              child: Text(
                                TextString.vendorActivityDay,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                TextString.vendorActivityEmployeeTableTwo,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                TextString.vendorActivityEmployeeTableThree,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                TextString.vendorActivityEmployeeTableFour,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                TextString.vendorActivityEmployeeTableFive,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: days.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 6),
                        itemBuilder: (context, index) {
                          final item = days[index];
                          Color overallColor = AppColors.textColor;
                          int val = int.tryParse(item["overall"]!.replaceAll("%", "")) ?? 0;
                          if (val >= 75) {
                            overallColor = AppColors.approvedColor;
                          } else if (val < 70) {
                            overallColor = AppColors.pendingColor;
                          }

                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                            ),
                            child: Row(
                              children: [
                                Obx(() {
                                  final isSelected = controller.selectedDayIndices.contains(index);
                                  return SizedBox(
                                    width: 24,
                                    height: 18,
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged: (_) => controller.toggleDaySelection(index),
                                      activeColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    ),
                                  );
                                }),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    item["day"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["mouse"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["key"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["idle"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["overall"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: overallColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  // Session breakdown
  Widget _buildSessionBreakdownTable(BuildContext context, VendorActivityController controller) {
    final sessions = [
      {"time": "9:00-10:00", "mouse": "33%", "key": "55%", "idle": "5%", "overall": "78%"},
      {"time": "10:00-11:00", "mouse": "44%", "key": "45%", "idle": "10%", "overall": "90%"},
      {"time": "11:00-12:00", "mouse": "55%", "key": "65%", "idle": "8%", "overall": "60%"},
      {"time": "12:00-1:00", "mouse": "30%", "key": "34%", "idle": "12%", "overall": "82%"},
      {"time": "1:00-2:00", "mouse": "-----", "key": "-----", "idle": "-----", "overall": "-----"},
      {"time": "2:00-3:00", "mouse": "70%", "key": "30%", "idle": "15%", "overall": "85%"},
      {"time": "3:00-4:00", "mouse": "70%", "key": "30%", "idle": "15%", "overall": "85%"},
      {"time": "4:00-5:00", "mouse": "70%", "key": "30%", "idle": "15%", "overall": "85%"},
      {"time": "5:00-6:00", "mouse": "70%", "key": "30%", "idle": "15%", "overall": "85%"},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           TextString.vendorActivitySession,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
           TextString.vendorActivitySessionSubtitle,
            style: TTextTheme.titleSix(context).copyWith(
              fontSize: 11,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              const double minWidth = 650.0;
              final currentWidth = constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: currentWidth,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Obx(() {
                              final isAllSelected = controller.selectedSessionIndices.length == sessions.length && sessions.isNotEmpty;
                              return SizedBox(
                                width: 24,
                                height: 18,
                                child: Checkbox(
                                  value: isAllSelected,
                                  onChanged: (_) => controller.toggleSelectAllSessions(sessions.length),
                                  activeColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                ),
                              );
                            }),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 3,
                              child: Text(
                                TextString.vendorActivityEmployeeTableSeven,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                TextString.vendorActivityEmployeeTableTwo,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                TextString.vendorActivityEmployeeTableThree,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                TextString.vendorActivityEmployeeTableFour,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                               TextString.vendorActivityEmployeeTableFive,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sessions.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 6),
                        itemBuilder: (context, index) {
                          final item = sessions[index];
                          Color overallColor = AppColors.textColor;
                          if (item["overall"] != "-----") {
                            int val = int.tryParse(item["overall"]!.replaceAll("%", "")) ?? 0;
                            if (val >= 75) {
                              overallColor = AppColors.approvedColor;
                            } else if (val < 70) {
                              overallColor = AppColors.pendingColor;
                            }
                          } else {
                            overallColor = AppColors.tertiaryTextColor;
                          }

                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                            ),
                            child: Row(
                              children: [
                                Obx(() {
                                  final isSelected = controller.selectedSessionIndices.contains(index);
                                  return SizedBox(
                                    width: 24,
                                    height: 18,
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged: (_) => controller.toggleSessionSelection(index),
                                      activeColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    ),
                                  );
                                }),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    item["time"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["mouse"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["key"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["idle"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["overall"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: overallColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
   // Weekly Graph
  Widget _buildWeeklyGraphCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.vendorActivityweeklyGraph,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            TextString.vendorActivityweeklyGraphSubtitle,
            style: TTextTheme.titleSix(context).copyWith(
              fontSize: 11,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildLegendItem(context, AppColors.approvedColor,TextString.vendorActivityHigh ),
              _buildLegendItem(context, AppColors.pendingColor,TextString.vendorActivityLow ),
              _buildLegendItem(context, AppColors.borderColor,TextString.vendorActivityIdle ),
            ],
          ),
          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              const double minWidth = 600.0;
              final width = constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: width,
                  height: 220,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("100%", style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
                            Text("80%", style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
                            Text("60%", style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
                            Text("40%", style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
                            Text("20%", style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
                            Text("0%", style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildStackedBar(context, "Mon", [
                              _BarSegment(flex: 35, color: AppColors.approvedColor),
                              _BarSegment(flex: 12, color: AppColors.pendingColor),
                              _BarSegment(flex: 8, color: AppColors.approvedColor),
                              _BarSegment(flex: 7, color: AppColors.borderColor),
                              _BarSegment(flex: 25, color: AppColors.approvedColor),
                            ]),
                            _buildStackedBar(context, "Tue", [
                              _BarSegment(flex: 25, color: AppColors.approvedColor),
                              _BarSegment(flex: 8, color: AppColors.pendingColor),
                              _BarSegment(flex: 18, color: AppColors.approvedColor),
                            ]),
                            _buildStackedBar(context, "Wed", [
                              _BarSegment(flex: 18, color: AppColors.approvedColor),
                              _BarSegment(flex: 18, color: AppColors.pendingColor),
                              _BarSegment(flex: 30, color: AppColors.approvedColor),
                              _BarSegment(flex: 10, color: AppColors.borderColor),
                              _BarSegment(flex: 20, color: AppColors.approvedColor),
                            ]),
                            _buildStackedBar(context, "Thu", [
                              _BarSegment(flex: 20, color: AppColors.pendingColor),
                              _BarSegment(flex: 20, color: AppColors.approvedColor),
                              _BarSegment(flex: 25, color: AppColors.pendingColor),
                              _BarSegment(flex: 25, color: AppColors.approvedColor),
                            ]),
                            _buildStackedBar(context, "Fri", [
                              _BarSegment(flex: 20, color: AppColors.approvedColor),
                              _BarSegment(flex: 22, color: AppColors.pendingColor),
                              _BarSegment(flex: 8, color: AppColors.approvedColor),
                              _BarSegment(flex: 20, color: AppColors.pendingColor),
                              _BarSegment(flex: 22, color: AppColors.approvedColor),
                            ]),
                            _buildStackedBar(context, "Sat", [
                              _BarSegment(flex: 2, color: AppColors.borderColor),
                            ]),
                            _buildStackedBar(context, "Sun", [
                              _BarSegment(flex: 2, color: AppColors.borderColor),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TTextTheme.titleSix(context).copyWith(
            fontSize: 11,
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStackedBar(BuildContext context, String dayLabel, List<_BarSegment> segments) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 55,
          height: 170,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: segments
                .map((seg) => Expanded(flex: seg.flex, child: Container(color: seg.color)))
                .toList(),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          dayLabel,
          style: TTextTheme.titleSix(context).copyWith(
            fontSize: 11,
            color: AppColors.tertiaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDailyGraphCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.vendorActivityDaily,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
           TextString.vendorActivityDailySubtitle,
            style: TTextTheme.titleSix(context).copyWith(
              fontSize: 11,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildLegendItem(context, AppColors.approvedColor, TextString.vendorActivityHigh),
              _buildLegendItem(context, AppColors.pendingColor, TextString.vendorActivityLow),
              _buildLegendItem(context, AppColors.borderColor, TextString.vendorActivityIdle),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              const double minWidth = 600.0;
              final currentWidth = constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: currentWidth,
                  child: Column(
                    children: [
                      Container(
                        height: 18,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.borderColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 12,
                                child: _buildExactTooltip(
                                  context: context,
                                  totalTime: "2hrs",
                                  highActivity: "1hr 48minuts",
                                  lowActivity: "12minuts",
                                  child: Row(
                                    children: [
                                      Expanded(flex: 30, child: Container(color: AppColors.approvedColor)),
                                      Expanded(flex: 70, child: Container(color: AppColors.borderColor)),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(flex: 12),
                              Expanded(
                                flex: 12,
                                child: _buildExactTooltip(
                                  context: context,
                                  totalTime: "1hr 30m",
                                  highActivity: "20minuts",
                                  lowActivity: "1hr 10minuts",
                                  child: Row(
                                    children: [
                                      Expanded(flex: 20, child: Container(color: AppColors.approvedColor)),
                                      Expanded(flex: 80, child: Container(color: AppColors.pendingColor)),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(flex: 24),
                              Expanded(
                                flex: 12,
                                child: _buildExactTooltip(
                                  context: context,
                                  totalTime: "1hr",
                                  highActivity: "1hr 00minuts",
                                  lowActivity: "0minuts",
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.approvedColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(flex: 15),
                              Expanded(
                                flex: 18,
                                child: _buildExactTooltip(
                                  context: context,
                                  totalTime: "2hrs 30m",
                                  highActivity: "2hrs 30minuts",
                                  lowActivity: "0minuts",
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.approvedColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(flex: 25),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "12am",
                            style: TTextTheme.titleSix(context).copyWith(
                              fontSize: 11,
                              color: AppColors.tertiaryTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "6am",
                            style: TTextTheme.titleSix(context).copyWith(
                              fontSize: 11,
                              color: AppColors.tertiaryTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "12pm",
                            style: TTextTheme.titleSix(context).copyWith(
                              fontSize: 11,
                              color: AppColors.tertiaryTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "6pm",
                            style: TTextTheme.titleSix(context).copyWith(
                              fontSize: 11,
                              color: AppColors.tertiaryTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

// tool tip
  Widget _buildExactTooltip({
    required BuildContext context,
    required String totalTime,
    required String highActivity,
    required String lowActivity,
    required Widget child,
  }) {
    return Tooltip(
      verticalOffset: 16,
      preferBelow: true,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      richMessage: WidgetSpan(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: TextString.vendorActivityTotalTime,
                    style: TTextTheme.titleSix(context).copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  TextSpan(
                    text: totalTime,
                    style: TTextTheme.titleSix(context).copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "High Activity : $highActivity",
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.approvedColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Low Activity : $lowActivity",
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.pendingColor,
              ),
            ),
          ],
        ),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: child,
      ),
    );
  }

  Widget _buildMonthlyGraphCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.vendorActivityMonthlyGraph,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            TextString.vendorActivityMonthlyGraphSubtitle,
            style: TTextTheme.titleSix(context).copyWith(
              fontSize: 11,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildLegendItem(context, AppColors.approvedColor, TextString.vendorActivityHigh),
              _buildLegendItem(context, AppColors.pendingColor, TextString.vendorActivityLow),
              _buildLegendItem(context, AppColors.borderColor, TextString.vendorActivityIdle),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              const double minWidth = 500.0;
              final width = constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: width,
                  height: 220,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("100%", style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
                            Text("80%", style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
                            Text("60%", style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
                            Text("40%", style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
                            Text("20%", style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
                            Text("0%", style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildStackedBar(context, "Week 1", [
                              _BarSegment(flex: 30, color: AppColors.approvedColor),
                              _BarSegment(flex: 10, color: AppColors.pendingColor),
                              _BarSegment(flex: 40, color: AppColors.approvedColor),
                              _BarSegment(flex: 10, color: AppColors.borderColor),
                            ]),
                            _buildStackedBar(context, "Week 2", [
                              _BarSegment(flex: 35, color: AppColors.approvedColor),
                              _BarSegment(flex: 2, color: AppColors.borderColor),
                              _BarSegment(flex: 15, color: AppColors.approvedColor),
                              _BarSegment(flex: 10, color: AppColors.pendingColor),
                            ]),
                            _buildStackedBar(context, "Week 3", [
                              _BarSegment(flex: 35, color: AppColors.approvedColor),
                              _BarSegment(flex: 15, color: AppColors.pendingColor),
                              _BarSegment(flex: 25, color: AppColors.approvedColor),
                              _BarSegment(flex: 10, color: AppColors.pendingColor),
                              _BarSegment(flex: 20, color: AppColors.approvedColor),
                              _BarSegment(flex: 10, color: AppColors.borderColor),
                            ]),
                            _buildStackedBar(context, "Week 4", [
                              _BarSegment(flex: 45, color: AppColors.approvedColor),
                              _BarSegment(flex: 45, color: AppColors.pendingColor),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
    // 4week Breakdown Table
  Widget _buildWeekBreakdownTable(BuildContext context, VendorActivityController controller) {
    final weeks = [
      {"week": "Week 1", "mouse": "33%", "key": "55%", "idle": "5%", "overall": "78%"},
      {"week": "Week 2", "mouse": "44%", "key": "45%", "idle": "10%", "overall": "90%"},
      {"week": "Week 3", "mouse": "55%", "key": "65%", "idle": "8%", "overall": "60%"},
      {"week": "Week 4", "mouse": "30%", "key": "34%", "idle": "12%", "overall": "82%"},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           TextString.vendorActivityWeekBreakdown,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            TextString.vendorActivityWeekBreakdownSubtitle,
            style: TTextTheme.titleSix(context).copyWith(
              fontSize: 11,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              const double minWidth = 650.0;
              final currentWidth = constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: currentWidth,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Obx(() {
                              final isAllSelected = controller.selectedWeekIndices.length == weeks.length && weeks.isNotEmpty;
                              return SizedBox(
                                width: 24,
                                height: 18,
                                child: Checkbox(
                                  value: isAllSelected,
                                  onChanged: (_) => controller.toggleSelectAllWeeks(weeks.length),
                                  activeColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                ),
                              );
                            }),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 3,
                              child: Text(
                                TextString.vendorActivityWeek,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                TextString.vendorActivityEmployeeTableTwo,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                TextString.vendorActivityEmployeeTableThree,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                TextString.vendorActivityEmployeeTableFour,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                TextString.vendorActivityEmployeeTableFive,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: weeks.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 6),
                        itemBuilder: (context, index) {
                          final item = weeks[index];
                          Color overallColor = AppColors.textColor;
                          int val = int.tryParse(item["overall"]!.replaceAll("%", "")) ?? 0;
                          if (val >= 75) {
                            overallColor = AppColors.approvedColor;
                          } else if (val < 70) {
                            overallColor = AppColors.pendingColor;
                          }

                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                            ),
                            child: Row(
                              children: [
                                Obx(() {
                                  final isSelected = controller.selectedWeekIndices.contains(index);
                                  return SizedBox(
                                    width: 24,
                                    height: 18,
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged: (_) => controller.toggleWeekSelection(index),
                                      activeColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    ),
                                  );
                                }),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    item["week"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["mouse"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["key"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["idle"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["overall"]!,
                                    style: TTextTheme.titleSix(context).copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: overallColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


 /// Class
// bar Segment
class _BarSegment {
  final int flex;
  final Color color;
  _BarSegment({required this.flex, required this.color});
}