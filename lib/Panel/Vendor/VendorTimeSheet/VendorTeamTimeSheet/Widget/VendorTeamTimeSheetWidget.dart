import 'package:employee_monitoring_system/Panel/Vendor/VendorTimeSheet/ReusableWidget/CustomDatePickerTimeSheetWidget.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorTimeSheet/ReusableWidget/PrimaryBtnOfVendorTimeSheet.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorTimeSheet/VendorTeamTimeSheet/Widget/EmployeeDetailTimeSheetWidget.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorTimeSheet/VendorTeamTimeSheet/Widget/TeamTimeSheetWidget.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorTimeSheet/VendorTimeSheetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';



class VendorTeamTimeSheetWidget extends StatelessWidget {
  const VendorTeamTimeSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VendorTimeSheetController());
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: EdgeInsets.all(width < 400 ? 12 : 24),
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
                  Obx(() {
                    final isDetailView = controller.selectedEmployee.value != null || controller.selectedTeam.value != null;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isDetailView) ...[
                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  controller.selectedEmployee.value = null;
                                  controller.selectedEmployeeDetail.value = null;
                                  controller.selectedTeam.value = null;
                                  controller.isViewingMembers.value = false;
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 6.0),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 18,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                            Text("Time Sheet", style: TTextTheme.h1Style(context)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "You can see your time Sheet Here",
                          style: TTextTheme.titleFour(context),
                        ),
                      ],
                    );
                  }),

                  if (isMobile) const SizedBox(height: 12),
                  Obx(() => Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTopTab(context, controller, title: "Employee", index: 0),
                        _buildTopTab(context, controller, title: "Team", index: 1),
                      ],
                    ),
                  )),
                ],
              );
            },
          ),

          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 700;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildMetricCard(
                    context,
                    width: isMobile ? double.infinity : (constraints.maxWidth - 36) / 4,
                    icon: Icons.access_time,
                    iconColor: AppColors.primaryColor,
                    title: "Total time Tracked",
                    value: "45 hrs 50 mints",
                    subValue: "2 more hours added",
                    barColor: Colors.transparent,
                    progress: 0,
                  ),
                  _buildMetricCard(
                    context,
                    width: isMobile ? double.infinity : (constraints.maxWidth - 36) / 4,
                    icon: Icons.access_time,
                    iconColor: AppColors.approvedColor,
                    title: "Active Time",
                    value: "36 hrs 20 mints",
                    barColor: AppColors.approvedColor,
                    progress: 0.7,
                  ),
                  _buildMetricCard(
                    context,
                    width: isMobile ? double.infinity : (constraints.maxWidth - 36) / 4,
                    icon: Icons.access_time,
                    iconColor: AppColors.rejectedColor,
                    title: "Idle time",
                    value: "9 hrs 30 mints",
                    barColor: AppColors.rejectedColor,
                    progress: 0.3,
                  ),
                  _buildMetricCard(
                    context,
                    width: isMobile ? double.infinity : (constraints.maxWidth - 36) / 4,
                    icon: Icons.bar_chart,
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
          Obx(() {
            if (controller.selectedEmployeeDetail.value != null) {
              return EmployeeDetailViewWidget(
                employee: controller.selectedEmployeeDetail.value,
                selectedFilter: controller.selectedTimeFilter.value,
              );
            }
            if (controller.selectedTab.value == 0) {
              return _buildEmployeeTabContent(context, controller, width);
            }
            else {
              return TeamTimeSheetWidget(
                controller: controller,
                onViewEmpTap: (teamData) {
                  controller.selectedTeam.value = teamData;
                },
              );
            }
          })
        ],
      ),
    );
  }

  /// ----------- Extra Widget -------------- ///

   // Employee Tab
  Widget _buildEmployeeTabContent(BuildContext context, VendorTimeSheetController controller, double width) {
    return Container(
      padding: EdgeInsets.all(width < 400 ? 12 : 20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Employees", style: TTextTheme.h2Style(context)),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: 220,
                  height: 38,
                  child: TextField(
                    cursorColor: AppColors.textColor,
                    onChanged: (val) => controller.searchQuery.value = val,
                    style: TTextTheme.FieldWriteTheText(context),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.tertiaryTextColor),
                      hintText: "Search by Employee",
                      hintStyle: TTextTheme.selectProjectText(context).copyWith(fontSize: 12),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.6)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ),
                Obx(() => Container(
                  height: 38,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundOfScreenColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildViewToggleButton(controller, index: 0, icon: Icons.format_list_bulleted),
                      const SizedBox(width: 4),
                      _buildViewToggleButton(controller, index: 1, icon: Icons.grid_view_outlined),
                    ],
                  ),
                )),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => _openDatePickerDialog(context, controller),
                  child: Obx(() => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_left, size: 20, color: AppColors.tertiaryTextColor),
                        const SizedBox(width: 2),
                        Text(
                          controller.currentDateText,
                          style: TTextTheme.titleSix(context).copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(Icons.arrow_right, size: 20, color: AppColors.tertiaryTextColor),
                      ],
                    ),
                  )),
                ),
                Obx(() => Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundOfScreenColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTimeFilterTab(context, controller, "Day"),
                      _buildTimeFilterTab(context, controller, "Week"),
                      _buildTimeFilterTab(context, controller, "Last 4 week"),
                    ],
                  ),
                )),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Obx(() {
            if (controller.selectedViewType.value == 0) {
              return _buildTableView(context, controller);
            } else {
              return _buildActivityGraphView(context, controller);
            }
          }),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (controller.currentPage.value > 1) controller.currentPage.value--;
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 14, color: AppColors.textColor),
                ),
              ),
              Obx(() => Text(
                "Page ${controller.currentPage.value} of ${controller.totalPages.value}",
                style: TTextTheme.titleSix(context).copyWith(fontSize: 12),
              )),
              InkWell(
                onTap: () {
                  if (controller.currentPage.value < controller.totalPages.value) controller.currentPage.value++;
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

    // Table View
  Widget _buildTableView(BuildContext context, VendorTimeSheetController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double minWidth = 850;
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
                    color: AppColors.backgroundOfScreenColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Obx(() => SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: controller.isAllSelected.value,
                          onChanged: controller.toggleSelectAll,
                          activeColor: AppColors.primaryColor,
                          side: BorderSide(
                            color: AppColors.borderColor,
                            width: 1.5,
                          ),
                        ),
                      )),
                      const SizedBox(width: 8),
                      Expanded(flex: 3, child: Text("Employee", style: TTextTheme.textFieldAboveText(context))),
                      Expanded(flex: 2, child: Text("Designation", style: TTextTheme.textFieldAboveText(context))),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, size: 14, color: AppColors.tertiaryTextColor),
                            const SizedBox(width: 4),
                            Text("Total Time", style: TTextTheme.textFieldAboveText(context)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, size: 14, color: AppColors.tertiaryTextColor),
                            const SizedBox(width: 4),
                            Text("Active Time", style: TTextTheme.textFieldAboveText(context)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, size: 14, color: AppColors.tertiaryTextColor),
                            const SizedBox(width: 4),
                            Text("Idle Time", style: TTextTheme.textFieldAboveText(context)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            const Icon(Icons.bar_chart, size: 14, color: AppColors.tertiaryTextColor),
                            const SizedBox(width: 4),
                            Text("Productivity", style: TTextTheme.textFieldAboveText(context)),
                          ],
                        ),
                      ),
                      SizedBox(width: 60, child: Text("Action", style: TTextTheme.textFieldAboveText(context))),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Obx(() => Column(
                  children: List.generate(controller.employeesList.length, (index) {
                    final item = controller.employeesList[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: item.isSelected,
                              onChanged: (val) => controller.toggleIndividualSelection(index, val),
                              activeColor: AppColors.primaryColor,
                              side: BorderSide(
                                color: AppColors.borderColor,
                                width: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Icon(Icons.person_outline, size: 16, color: AppColors.primaryColor),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.name, style: TTextTheme.h2Style(context).copyWith(fontSize: 13), overflow: TextOverflow.ellipsis),
                                      Text(item.email, style: TTextTheme.titleSix(context).copyWith(fontSize: 11), overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(flex: 2, child: Text(item.designation, style: TTextTheme.titleSix(context))),
                          Expanded(flex: 2, child: Text(item.totalTime, style: TTextTheme.titleSix(context))),
                          Expanded(flex: 2, child: Text(item.activeTime, style: TTextTheme.titleSix(context))),
                          Expanded(flex: 2, child: Text(item.idleTime, style: TTextTheme.titleSix(context))),
                          Expanded(flex: 2, child: Text(item.productivity, style: TTextTheme.titleSix(context))),
                          SizedBox(
                            width: 60,
                            child: InkWell(
                              onTap: () {
                                controller.selectedEmployee.value = item;
                                controller.selectedEmployeeDetail.value = item;
                              },
                              child: const Icon(Icons.remove_red_eye_outlined, size: 18, color: AppColors.tertiaryTextColor),
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
    );
  }

   // Activity Graph
  Widget _buildActivityGraphView(BuildContext context, VendorTimeSheetController controller) {
    String filter = controller.selectedTimeFilter.value;

    return Column(
      children: List.generate(controller.employeesList.length, (index) {
        final item = controller.employeesList[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.person_outline, size: 16, color: AppColors.primaryColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: TTextTheme.h2Style(context).copyWith(fontSize: 13, fontWeight: FontWeight.bold)),
                        Text(item.email, style: TTextTheme.titleSix(context).copyWith(fontSize: 11, color: AppColors.tertiaryTextColor)),
                      ],
                    ),
                  ),
                  PrimaryBtnOfVendorTimeSheet(
                    text: "View Details",
                    height: 40,
                    borderRadius: BorderRadius.circular(6),
                    onTap: () {
                      controller.selectedEmployee.value = item;
                    },
                  ),
                ],
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Text("AVG Activity: ", style: TTextTheme.titleSix(context).copyWith(fontSize: 11, fontWeight: FontWeight.w500)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.approvedColor, width: 0.8),
                    ),
                    child: Text(
                      item.productivity.isEmpty ? "78%" : item.productivity,
                      style: TTextTheme.upNumbers(context),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              if (filter == "Day")
                _buildDayTimelineGraph(context)
              else if (filter == "Week")
                _buildWeeklyBarChart(context)
              else
                _buildLast4WeeksBarChart(),
            ],
          ),
        );
      }),
    );
  }

   // Day TimeLine Graph
  Widget _buildDayTimelineGraph(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 14,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.backgroundOfScreenColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double totalWidth = constraints.maxWidth;
                  return Stack(
                    children: [
                      _buildTimelineCapsule(left: totalWidth * 0.02, width: totalWidth * 0.12),
                      _buildTimelineCapsule(left: totalWidth * 0.18, width: totalWidth * 0.08),
                      _buildTimelineCapsule(left: totalWidth * 0.48, width: totalWidth * 0.07),
                      _buildTimelineCapsule(left: totalWidth * 0.68, width: totalWidth * 0.12),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("9am", style: TTextTheme.FieldWriteTheText(context)),
            Text("9pm", style: TTextTheme.FieldWriteTheText(context)),
          ],
        )
      ],
    );
  }
  Widget _buildWeeklyBarChart(BuildContext context) {
    final List<Map<String, dynamic>> weekData = [
      {"day": "Mon", "hours": "8hrs", "height": 140.0, "isOff": false},
      {"day": "Tue", "hours": "8hrs", "height": 135.0, "isOff": false},
      {"day": "Wed", "hours": "5hrs", "height": 110.0, "isOff": false},
      {"day": "Thu", "hours": "8hrs", "height": 140.0, "isOff": false},
      {"day": "Fri", "hours": "5hrs", "height": 110.0, "isOff": false},
      {"day": "Sat", "hours": "---", "height": 4.0, "isOff": true},
      {"day": "Sun", "hours": "---", "height": 4.0, "isOff": true},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        constraints: const BoxConstraints(minWidth: 550),
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: weekData.map((data) {
            bool isOff = data["isOff"] as bool;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    data["hours"],
                    style: TTextTheme.hoursText(context)
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 55,
                    height: data["height"] as double,
                    decoration: BoxDecoration(
                      color: isOff ? AppColors.primaryColor.withValues(alpha: 0.5) : AppColors.primaryColor,
                      borderRadius: isOff ? BorderRadius.circular(2) : BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data["day"],
                    style: TTextTheme.hoursText(context),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Last 4 Weeks bars
  Widget _buildLast4WeeksBarChart() {
    final List<Map<String, dynamic>> fourWeekData = [
      {"label": "Week 1", "hours": "48hrs", "height": 150.0},
      {"label": "Week 2", "hours": "48hrs", "height": 150.0},
      {"label": "Week 3", "hours": "45hrs", "height": 135.0},
      {"label": "Week 4", "hours": "42hrs", "height": 125.0},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            constraints: BoxConstraints(minWidth: constraints.maxWidth < 500 ? 500 : constraints.maxWidth),
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: fourWeekData.map((data) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        data["hours"],
                        style: TTextTheme.hoursText(context)
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: data["height"] as double,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data["label"],
                        style: TTextTheme.hoursText(context)
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // TimeLine Capsule
  Widget _buildTimelineCapsule({required double left, required double width}) {
    return Positioned(
      left: left,
      top: 0,
      bottom: 0,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }


  // Top Tab Switcher Widget
  Widget _buildTopTab(BuildContext context, VendorTimeSheetController controller, {required String title, required int index}) {
    bool isSelected = controller.selectedTab.value == index;
    return InkWell(
      onTap: () => controller.selectedTab.value = index,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: isSelected ? TTextTheme.titleThree(context).copyWith(color: AppColors.whiteColor): TTextTheme.titleThree(context),
        ),
      ),
    );
  }
     // Metric Card
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
                  style: TTextTheme.titleSix(context).copyWith(fontSize: 12, color: AppColors.tertiaryTextColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: TTextTheme.h2Style(context).copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
          if (subValue != null) ...[
            const SizedBox(height: 4),
            Text(subValue, style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
          ] else ...[
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.backgroundOfScreenColor,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
              minHeight: 6,
              borderRadius: BorderRadius.circular(4),
            ),
          ]
        ],
      ),
    );
  }

   // View Toggle Button
  Widget _buildViewToggleButton(VendorTimeSheetController controller, {required int index, required IconData icon}) {
    bool isSelected = controller.selectedViewType.value == index;
    return InkWell(
      onTap: () => controller.selectedViewType.value = index,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isSelected ? AppColors.whiteColor : AppColors.tertiaryTextColor,
        ),
      ),
    );
  }

  // Filter Tab
  Widget _buildTimeFilterTab(BuildContext context, VendorTimeSheetController controller, String label) {
    bool isSelected = controller.selectedTimeFilter.value == label;
    return InkWell(
      onTap: () => controller.selectedTimeFilter.value = label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: isSelected ? TTextTheme.titleThree(context).copyWith(color: AppColors.whiteColor): TTextTheme.titleThree(context)
        ),
      ),
    );
  }

  // DatePicker Dialog
  void _openDatePickerDialog(BuildContext context, VendorTimeSheetController controller) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: CustomDatePickerTimeSheetWidget(
            initialDate: controller.selectedDate.value,
            timeFilterMode: controller.selectedTimeFilter.value,
            onCancel: () => Navigator.pop(dialogContext),
            onDateSelected: (selectedDate, weekRange) {
              controller.updateSelectedDate(selectedDate, weekRange);
              Navigator.pop(dialogContext);
            },
          ),
        );
      },
    );
  }
}