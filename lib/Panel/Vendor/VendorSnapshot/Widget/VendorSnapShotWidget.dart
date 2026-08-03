import 'package:employee_monitoring_system/Panel/Vendor/VendorSnapshot/ReusableWidget/CustomDatePickerSnapShotWidget.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorSnapshot/ReusableWidget/PrimaryBtnOfVendorSnapShot.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorSnapshot/VendorSnapshotController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



class VendorSnapshotWidget extends GetView<VendorSnapshotController> {
  const VendorSnapshotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 480;

              return Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: isMobile ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() {
                        if (controller.isShowingTeamEmpDetails.value) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () => controller.isShowingTeamEmpDetails.value = false,
                              borderRadius: BorderRadius.circular(20),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Screen Shots",
                            style: TTextTheme.h2Style(context).copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "You can see screenshots here",
                            style: TTextTheme.titleSix(context).copyWith(
                              fontSize: 12,
                              color: AppColors.tertiaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (isMobile) const SizedBox(height: 12),
                  _buildTopToggleSwitch(context),
                ],
              );
            },
          ),

          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 700;

              return Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  _buildMetricCard(
                    context,
                    width: isMobile ? double.infinity : (constraints.maxWidth - 48) / 4,
                    icon: Icons.photo_library_outlined,
                    iconColor: AppColors.primaryColor,
                    title: "Total ScreenShots",
                    value: "864",
                    subValue: "2 more screenshots added",
                    barColor: Colors.transparent,
                    progress: 0,
                  ),
                  _buildMetricCard(
                    context,
                    width: isMobile ? double.infinity : (constraints.maxWidth - 48) / 4,
                    icon: Icons.access_time_rounded,
                    iconColor: Colors.green,
                    title: "Active time",
                    value: "126 hrs 30 mints",
                    barColor: Colors.green,
                    progress: 0.75,
                  ),
                  _buildMetricCard(
                    context,
                    width: isMobile ? double.infinity : (constraints.maxWidth - 48) / 4,
                    icon: Icons.timer_outlined,
                    iconColor: Colors.red,
                    title: "Idle time",
                    value: "9 hrs 30 mints",
                    barColor: Colors.red,
                    progress: 0.25,
                  ),
                  _buildMetricCard(
                    context,
                    width: isMobile ? double.infinity : (constraints.maxWidth - 48) / 4,
                    icon: Icons.bar_chart_rounded,
                    iconColor: AppColors.primaryColor,
                    title: "Productivity Score",
                    value: "65%",
                    barColor: AppColors.primaryColor,
                    progress: 0.65,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          // 3. Dynamic Section Render
          Obx(() {
            if (controller.selectedToggleIndex.value == 0) {
              return _buildEmployeeTableSection(context, isSubView: false);
            } else {
              if (controller.isShowingTeamEmpDetails.value) {
                return _buildEmployeeTableSection(context, isSubView: true);
              } else {
                return _buildTeamTableSection(context);
              }
            }
          }),
        ],
      ),
    );
  }

    /// ------- Extra Widget -------------///
  // Team Tab
  Widget _buildTeamTableSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              bool isSmall = constraints.maxWidth < 600;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Team Time Sheet",
                    style: TTextTheme.h2Style(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: isSmall ? Alignment.centerLeft : Alignment.centerRight,
                    child: _buildDateSelectorWidget(context),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              const double minWidth = 750;
              double tableWidth = constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: tableWidth,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Obx(() => Checkbox(
                                value: controller.isTeamHeaderSelected.value,
                                onChanged: controller.toggleSelectAllTeam,
                                activeColor: AppColors.primaryColor,
                                side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                              )),
                            ),
                            const SizedBox(width: 12),
                            Expanded(flex: 3, child: _buildTableHeaderTitle(context, "Team Name")),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Team Member")),
                            Expanded(flex: 3, child: _buildTableHeaderTitle(context, "Total Screen Shots", icon: Icons.photo_library_outlined)),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Active Time", icon: Icons.access_time_rounded)),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Idle Time", icon: Icons.timer_outlined)),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Productivity", icon: Icons.bar_chart_rounded)),
                            Expanded(flex: 2, child: Text("Action", style: TTextTheme.textFieldAboveText(context))),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Data Rows
                      Obx(() => Column(
                        children: List.generate(controller.teamLogs.length, (index) {
                          final item = controller.teamLogs[index];
                          final isChecked = controller.selectedTeamRows.length > index ? controller.selectedTeamRows[index] : false;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    value: isChecked,
                                    onChanged: (val) => controller.onTeamRowSelected(index, val),
                                    activeColor: AppColors.primaryColor,
                                    side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    item["teamName"] ?? "",
                                    style: TTextTheme.h2Style(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(flex: 2, child: Text(item["members"].toString(), style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                                Expanded(flex: 3, child: Text(item["totalScreenshots"] ?? "", style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                                Expanded(flex: 2, child: Text(item["activeTime"] ?? "", style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                                Expanded(flex: 2, child: Text(item["idleTime"] ?? "", style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                                Expanded(flex: 2, child: Text(item["productivity"] ?? "", style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                                Expanded(
                                  flex: 2,
                                  child: PrimaryBtnOfVendorSnapahot(
                                    text: "View Emp",
                                    height: 40,
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: () {
                                      controller.selectedTeamName.value = item["teamName"] ?? "";
                                      controller.isShowingTeamEmpDetails.value = true;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      )),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),
          _buildPaginationFooter(context),
        ],
      ),
    );
  }

   // Employee Table Section
  Widget _buildEmployeeTableSection(BuildContext context, {required bool isSubView}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              bool isSmall = constraints.maxWidth < 650;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isSubView
                        ? "${controller.selectedTeamName.value} - Employee Screen Shot"
                        : "Employee Screen Shot",
                    style: TTextTheme.h2Style(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  Align(
                    alignment: isSmall ? Alignment.centerLeft : Alignment.centerRight,
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: isSmall ? WrapAlignment.start : WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SizedBox(
                          width: isSmall ? double.infinity : 220,
                          height: 38,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.4)),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  IconString.searchIcon,
                                  width: 16,
                                  height: 16,
                                  colorFilter: const ColorFilter.mode(AppColors.tertiaryTextColor, BlendMode.srcIn),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    onChanged: (val) => controller.searchQuery.value = val,
                                    style: TTextTheme.titleSix(context).copyWith(fontSize: 12),
                                    decoration: InputDecoration(
                                      hintText: "Search by Employee",
                                      hintStyle: TTextTheme.titleSix(context).copyWith(
                                        fontSize: 12,
                                        color: AppColors.tertiaryTextColor.withValues(alpha: 0.7),
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildDateSelectorWidget(context),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              const double minWidth = 750;
              double tableWidth = constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: tableWidth,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Obx(() => Checkbox(
                                value: controller.isEmployeeHeaderSelected.value,
                                onChanged: controller.toggleSelectAllEmployee,
                                activeColor: AppColors.primaryColor,
                                side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                              )),
                            ),
                            const SizedBox(width: 12),
                            Expanded(flex: 3, child: _buildTableHeaderTitle(context, "Project")),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Total Screen Shots", icon: Icons.photo_library_outlined)),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Active Time", icon: Icons.access_time_rounded)),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Idle Time", icon: Icons.timer_outlined)),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Productivity", icon: Icons.bar_chart_rounded)),
                            Expanded(flex: 1, child: Text("Action", style: TTextTheme.textFieldAboveText(context))),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),
                      Obx(() => Column(
                        children: List.generate(controller.employeeLogs.length, (index) {
                          final item = controller.employeeLogs[index];
                          final isChecked = controller.selectedEmployeeRows.length > index ? controller.selectedEmployeeRows[index] : false;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    value: isChecked,
                                    onChanged: (val) => controller.onEmployeeRowSelected(index, val),
                                    activeColor: AppColors.primaryColor,
                                    side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.person_outline, size: 20, color: AppColors.primaryColor),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item["name"] ?? "",
                                            style: TTextTheme.h2Style(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            item["email"] ?? "",
                                            style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(flex: 2, child: Text(item["totalScreenshots"] ?? "", style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                                Expanded(flex: 2, child: Text(item["activeTime"] ?? "", style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                                Expanded(flex: 2, child: Text(item["idleTime"] ?? "", style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                                Expanded(flex: 2, child: Text(item["productivity"] ?? "", style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {},
                                    child: SvgPicture.asset(
                                      IconString.eyeIcon,
                                      width: 18,
                                      height: 18,
                                      colorFilter: const ColorFilter.mode(AppColors.tertiaryTextColor, BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      )),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),
          _buildPaginationFooter(context),
        ],
      ),
    );
  }

    // Date selector Widget
  Widget _buildDateSelectorWidget(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              DateTime current = controller.rawSelectedDate.value;
              controller.updateSelectedDate(current.subtract(const Duration(days: 1)));
            },
            child: const Icon(Icons.arrow_left, size: 20, color: AppColors.tertiaryTextColor),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) => Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: const EdgeInsets.all(16),
                  child: CustomDatePickerSnapShot(
                    initialDate: controller.rawSelectedDate.value,
                    timeFilterMode: "Day",
                    onCancel: () => Navigator.pop(dialogContext),
                    onDateSelected: (selectedDate, range) {
                      controller.updateSelectedDate(selectedDate);
                      Navigator.pop(dialogContext);
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                controller.selectedDateText.value,
                style: TTextTheme.titleSix(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              DateTime current = controller.rawSelectedDate.value;
              controller.updateSelectedDate(current.add(const Duration(days: 1)));
            },
            child: const Icon(Icons.arrow_right, size: 20, color: AppColors.tertiaryTextColor),
          ),
        ],
      ),
    ));
  }

   // Pagination Footer
  Widget _buildPaginationFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 12, color: AppColors.tertiaryTextColor),
          ),
        ),
        Obx(() => Text(
          "Page ${controller.currentPage.value} of ${controller.totalPages.value}",
          style: TTextTheme.titleSix(context).copyWith(fontSize: 11, color: AppColors.tertiaryTextColor),
        )),
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.tertiaryTextColor),
          ),
        ),
      ],
    );
  }

    // toggle Switch
  Widget _buildTopToggleSwitch(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Obx(() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTogglePill(context, title: "Employees", index: 0),
          _buildTogglePill(context, title: "Team", index: 1),
        ],
      )),
    );
  }

  Widget _buildTogglePill(BuildContext context, {required String title, required int index}) {
    bool isSelected = controller.selectedToggleIndex.value == index;
    return InkWell(
      onTap: () {
        controller.selectedToggleIndex.value = index;
        controller.isShowingTeamEmpDetails.value = false;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: TTextTheme.titleSix(context).copyWith(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppColors.whiteColor : AppColors.tertiaryTextColor,
          ),
        ),
      ),
    );
  }

   // Metric Card Widget
  Widget _buildMetricCard(
      BuildContext context, {
        required double width,
        required IconData icon,
        required Color iconColor,
        required String title,
        required String value,
        String? subValue,
        required Color barColor,
        required double progress,
      }) {
    return Container(
      width: width,
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
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TTextTheme.titleSix(context).copyWith(fontSize: 11, color: AppColors.tertiaryTextColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: TTextTheme.h2Style(context).copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (subValue != null)
            Text(subValue, style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor))
          else
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.backgroundOfScreenColor,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
              minHeight: 5,
              borderRadius: BorderRadius.circular(4),
            ),
        ],
      ),
    );
  }

   // Table Header Title
  Widget _buildTableHeaderTitle(BuildContext context, String title, {IconData? icon}) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 13, color: AppColors.tertiaryTextColor),
          const SizedBox(width: 4),
        ],
        Expanded(
          child: Text(
            title,
            style: TTextTheme.textFieldAboveText(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}