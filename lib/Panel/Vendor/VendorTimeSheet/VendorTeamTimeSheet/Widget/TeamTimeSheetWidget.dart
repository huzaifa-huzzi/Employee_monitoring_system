import 'package:employee_monitoring_system/Panel/Vendor/VendorTimeSheet/ReusableWidget/CustomDatePickerTimeSheetWidget.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorTimeSheet/ReusableWidget/PrimaryBtnOfVendorTimeSheet.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorTimeSheet/VendorTimeSheetController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TeamTimeSheetWidget extends StatelessWidget {
  final VendorTimeSheetController controller;
  final Function(TimeSheetTeamModel)? onViewEmpTap;
  final Function(dynamic employee)? onViewEmpDetailsTap;

  const TeamTimeSheetWidget({
    super.key,
    required this.controller,
    this.onViewEmpTap,
    this.onViewEmpDetailsTap,
  });

  // Date Picker Dialog
  void _showDatePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: CustomDatePickerTimeSheetWidget(
            initialDate: controller.selectedDate.value,
            timeFilterMode: controller.selectedTimeFilter.value,
            onCancel: () => Navigator.of(context).pop(),
            onDateSelected: (selectedDate, weekRange) {
              controller.updateSelectedDate(selectedDate, weekRange);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
          ),
          child: Obx(() {
            bool isMemberView = controller.selectedTeam.value != null || controller.isViewingMembers.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isMobile = constraints.maxWidth < 480;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isMemberView
                              ? "${controller.selectedTeam.value?.teamName ?? "Team"} Members Time Sheet"
                              : "Team Time Sheet",
                          style: TTextTheme.h2Style(context).copyWith(
                            fontSize: isMobile ? 16 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 14),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minWidth: constraints.maxWidth),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (isMemberView) ...[
                                  _buildSearchBar(context),
                                  const SizedBox(width: 12),
                                  _buildViewToggle(),
                                  const SizedBox(width: 12),
                                ],
                                _buildDatePickerBox(context),
                                const SizedBox(width: 12),
                                _buildTimeFilters(context),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),
                if (isMemberView && controller.selectedViewType.value == 1) ...[
                  _buildActivityGraphView(context, controller)
                ] else ...[
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const double minWidth = 850;
                      double tableWidth = constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth;

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: tableWidth,
                          child: isMemberView
                              ? _buildTeamMembersTable(context)
                              : _buildTeamsTable(context),
                        ),
                      );
                    },
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        side: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.5)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.arrow_back_ios_new, size: 14, color: AppColors.textColor),
                      onPressed: () {
                        if (controller.currentPage.value > 1) {
                          controller.currentPage.value--;
                        }
                      },
                    ),
                    Text(
                      "Page ${controller.currentPage.value} of ${controller.totalPages.value}",
                      style: TTextTheme.titleSix(context).copyWith(fontSize: 12, color: AppColors.tertiaryTextColor),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        side: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.5)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textColor),
                      onPressed: () {
                        if (controller.currentPage.value < controller.totalPages.value) {
                          controller.currentPage.value++;
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          }),
        )
      ],
    );
  }

  /// ------------ Extra Widget-------------///

  // Team List Table
  Widget _buildTeamsTable(BuildContext context) {
    if (controller.teamsList.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        alignment: Alignment.center,
        child: Text(
          "No Teams Found",
          style: TTextTheme.titleSix(context).copyWith(color: AppColors.tertiaryTextColor),
        ),
      );
    }

    return Column(
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
                  value: controller.isAllTeamSelected.value,
                  onChanged: (val) => controller.toggleSelectAllTeams(val),
                  activeColor: AppColors.primaryColor,
                  side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                )),
              ),
              const SizedBox(width: 12),
              Expanded(flex: 2, child: Text("Team Name", style: TTextTheme.textFieldAboveText(context))),
              Expanded(flex: 2, child: Text("Team Member", style: TTextTheme.textFieldAboveText(context))),
              Expanded(flex: 2, child: Text("Total Time", style: TTextTheme.textFieldAboveText(context))),
              Expanded(flex: 2, child: Text("Active Time", style: TTextTheme.textFieldAboveText(context))),
              Expanded(flex: 2, child: Text("Idle Time", style: TTextTheme.textFieldAboveText(context))),
              Expanded(flex: 2, child: Text("Productivity", style: TTextTheme.textFieldAboveText(context))),
              Expanded(flex: 2, child: Text("Action", style: TTextTheme.textFieldAboveText(context))),
            ],
          ),
        ),

        const SizedBox(height: 10),

        Column(
          children: List.generate(controller.teamsList.length, (index) {
            final team = controller.teamsList[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      value: team.isSelected ?? false,
                      onChanged: (val) => controller.toggleIndividualTeamSelection(index, val),
                      activeColor: AppColors.primaryColor,
                      side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Text(team.teamName, style: TTextTheme.h2Style(context).copyWith(fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("${team.teamMembers}", style: TTextTheme.titleSix(context).copyWith(fontSize: 12, color: AppColors.tertiaryTextColor)),
                  ),
                  Expanded(flex: 2, child: Text(team.totalTime, style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                  Expanded(flex: 2, child: Text(team.activeTime, style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                  Expanded(flex: 2, child: Text(team.idleTime, style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                  Expanded(flex: 2, child: Text(team.productivity, style: TTextTheme.titleSix(context).copyWith(fontSize: 12))),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: PrimaryBtnOfVendorTimeSheet(
                        text: "View Emp",
                        width: 110,
                        height: 40,
                        borderRadius: BorderRadius.circular(6),
                        onTap: () {
                          controller.selectedTeam.value = team;
                          controller.isViewingMembers.value = true;
                          if (onViewEmpTap != null) onViewEmpTap!(team);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  // Team Members Table
  Widget _buildTeamMembersTable(BuildContext context) {
    return Column(
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
                width: 24,
                height: 24,
                child: Obx(() => Checkbox(
                  value: controller.isAllEmployeeSelected.value,
                  onChanged: (val) => controller.toggleSelectAllEmployees(val),
                  activeColor: AppColors.primaryColor,
                  side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                )),
              ),
              const SizedBox(width: 8),
              Expanded(flex: 3, child: Text("Employee", style: TTextTheme.textFieldAboveText(context))),
              Expanded(flex: 2, child: Text("Designation", style: TTextTheme.textFieldAboveText(context))),
              Expanded(flex: 2, child: Text("Total Time", style: TTextTheme.textFieldAboveText(context))),
              Expanded(flex: 2, child: Text("Active Time", style: TTextTheme.textFieldAboveText(context))),
              Expanded(flex: 2, child: Text("Idle Time", style: TTextTheme.textFieldAboveText(context))),
              Expanded(flex: 2, child: Text("Productivity", style: TTextTheme.textFieldAboveText(context))),
              const SizedBox(width: 60, child: Text("Action", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
            ],
          ),
        ),

        const SizedBox(height: 10),

        if (controller.employeesList.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            alignment: Alignment.center,
            child: Text(
              "No Employees Found",
              style: TTextTheme.titleSix(context).copyWith(color: AppColors.tertiaryTextColor),
            ),
          )
        else
          Column(
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
                        value: item.isSelected ?? false,
                        onChanged: (val) => controller.toggleIndividualSelection(index, val),
                        activeColor: AppColors.primaryColor,
                        side: const BorderSide(
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
                          const Icon(Icons.person_outline, size: 16, color: AppColors.primaryColor),
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
                          if (onViewEmpDetailsTap != null) {
                            onViewEmpDetailsTap!(item);
                          }
                          controller.openEmployeeDetails(item);
                        },
                        child: const Icon(Icons.remove_red_eye_outlined, size: 18, color: AppColors.tertiaryTextColor),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
      ],
    );
  }

  // Activity Graph
  Widget _buildActivityGraphView(BuildContext context, VendorTimeSheetController controller) {
    String filter = controller.selectedTimeFilter.value;

    if (controller.employeesList.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        alignment: Alignment.center,
        child: Text(
          "No Employees Found",
          style: TTextTheme.titleSix(context).copyWith(color: AppColors.tertiaryTextColor),
        ),
      );
    }

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
                  const Icon(Icons.person_outline, size: 16, color: AppColors.primaryColor),
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
                      if (onViewEmpDetailsTap != null) onViewEmpDetailsTap!(item);
                      controller.openEmployeeDetails(item);
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
                _buildLast4WeeksBarChart(context),
            ],
          ),
        );
      }),
    );
  }

  // Graph Visuals
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
                    style: TTextTheme.hoursText(context),
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

  Widget _buildLast4WeeksBarChart(BuildContext context) {
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
                        style: TTextTheme.hoursText(context),
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
                        style: TTextTheme.hoursText(context),
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

  // SearchBar
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      width: 220,
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 18, color: AppColors.tertiaryTextColor),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              cursorColor: AppColors.textColor,
              onChanged: (value) => controller.searchQuery.value = value,
              style: TTextTheme.titleSix(context).copyWith(fontSize: 12, color: AppColors.textColor),
              decoration: InputDecoration(
                hintText: "Search by Employee",
                hintStyle: TTextTheme.titleSix(context).copyWith(fontSize: 12, color: AppColors.tertiaryTextColor),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
  // view Toggle
  Widget _buildViewToggle() {
    return Obx(() => Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => controller.selectedViewType.value = 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: controller.selectedViewType.value == 0 ? AppColors.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.format_list_bulleted,
                size: 16,
                color: controller.selectedViewType.value == 0 ? AppColors.whiteColor : AppColors.textColor,
              ),
            ),
          ),
          InkWell(
            onTap: () => controller.selectedViewType.value = 1,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: controller.selectedViewType.value == 1 ? AppColors.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.grid_view_rounded,
                size: 16,
                color: controller.selectedViewType.value == 1 ? AppColors.whiteColor : AppColors.textColor,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildDatePickerBox(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
              controller.selectedDate.value = controller.selectedDate.value.subtract(const Duration(days: 1));
            },
            child: const Icon(Icons.arrow_left, size: 20, color: AppColors.textColor),
          ),
          InkWell(
            onTap: () => _showDatePickerDialog(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Obx(() => Text(
                controller.currentDateText,
                style: TTextTheme.titleSix(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textColor),
              )),
            ),
          ),
          InkWell(
            onTap: () {
              controller.selectedDate.value = controller.selectedDate.value.add(const Duration(days: 1));
            },
            child: const Icon(Icons.arrow_right, size: 20, color: AppColors.textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeFilters(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfScreenColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: ["Day", "Week", "Last 4 week"].map((filter) {
          bool isSelected = controller.selectedTimeFilter.value == filter;
          return InkWell(
            onTap: () => controller.selectedTimeFilter.value = filter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                filter,
                style: isSelected ? TTextTheme.titleThree(context).copyWith(color: AppColors.whiteColor): TTextTheme.titleThree(context)
              ),
            ),
          );
        }).toList(),
      ),
    ));
  }
}