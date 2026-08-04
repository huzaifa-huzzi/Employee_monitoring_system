import 'package:employee_monitoring_system/Panel/Vendor/VendorSnapshot/ReusableWidget/CustomDatePickerSnapShotWidget.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorSnapshot/ReusableWidget/PrimaryBtnOfVendorSnapShot.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorSnapshot/VendorSnapshotController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/ImageString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



class VendorSnapshotWidget extends GetView<VendorSnapshotController> {
  const VendorSnapshotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isShowingEmployeeDetailView.value) {
        return _buildEmployeeScreenshotsDetailView(context);
      }
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
                                  color: AppColors.textColor,
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
                      svgIconPath: IconString.totalScreenShot,
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
                      svgIconPath: IconString.idleTime,
                      iconColor: AppColors.approvedColor,
                      title: "Active time",
                      value: "126 hrs 30 mints",
                      barColor: AppColors.approvedColor,
                      progress: 0.75,
                    ),
                    _buildMetricCard(
                      context,
                      width: isMobile ? double.infinity : (constraints.maxWidth - 48) / 4,
                      svgIconPath: IconString.idleTime,
                      iconColor: AppColors.rejectedColor,
                      title: "Idle time",
                      value: "9 hrs 30 mints",
                      barColor: AppColors.rejectedColor,
                      progress: 0.25,
                    ),
                    _buildMetricCard(
                      context,
                      width: isMobile ? double.infinity : (constraints.maxWidth - 48) / 4,
                      svgIconPath: IconString.productivityIcon,
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
    });
  }
       /// ----------- Extra Widget ------------- ///
  // Employee ScreenshotDetail
  Widget _buildEmployeeScreenshotsDetailView(BuildContext context) {
    final emp = controller.selectedEmployeeDetails;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => controller.closeEmployeeDetailView(),
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textColor),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Screen Shots",
                    style: TTextTheme.h2Style(context).copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "You can see screenshots here",
                    style: TTextTheme.titleSix(context).copyWith(fontSize: 12, color: AppColors.tertiaryTextColor),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 700;
              double cardWidth = isMobile ? double.infinity : (constraints.maxWidth - 48) / 4;

              return Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  _buildMetricCard(
                    context,
                    width: cardWidth,
                    svgIconPath: IconString.totalScreenShot,
                    iconColor: AppColors.primaryColor,
                    title: "Total ScreenShots",
                    value: emp["totalScreenshots"] ?? "48",
                    subValue: "2 more screenshots added",
                    barColor: Colors.transparent,
                    progress: 0,
                  ),
                  _buildMetricCard(
                    context,
                    width: cardWidth,
                    svgIconPath: IconString.idleTime,
                    iconColor: AppColors.approvedColor,
                    title: "Active time",
                    value: emp["activeTime"] ?? "6 hrs 50 mints",
                    barColor: AppColors.approvedColor,
                    progress: 0.75,
                  ),
                  _buildMetricCard(
                    context,
                    width: cardWidth,
                    svgIconPath: IconString.idleTime,
                    iconColor: AppColors.rejectedColor,
                    title: "Idle time",
                    value: emp["idleTime"] ?? "1 hrs 10 mints",
                    barColor: AppColors.rejectedColor,
                    progress: 0.25,
                  ),
                  _buildMetricCard(
                    context,
                    width: cardWidth,
                    svgIconPath:IconString.productivityIcon ,
                    iconColor: AppColors.primaryColor,
                    title: "Productivity Score",
                    value: emp["productivity"] ?? "65%",
                    barColor: AppColors.primaryColor,
                    progress: 0.65,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person_outline, color: AppColors.primaryColor, size: 28),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              emp["name"] ?? "Jack Milson",
                              style: TTextTheme.h2Style(context).copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              emp["email"] ?? "jack@gmail.com",
                              style: TTextTheme.titleSix(context).copyWith(fontSize: 12, color: AppColors.tertiaryTextColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    _buildDateSelectorWidget(context),
                  ],
                ),

                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double width = (constraints.maxWidth - 16) / 2;

                    return Row(
                      children: [
                        _buildSubSummaryBox(context, width: width, label: "Worked Time", value: "8hrs", valueColor: AppColors.textColor),
                        const SizedBox(width: 16),
                        _buildSubSummaryBox(context, width: width, label: "Average Activity", value: "65% of the time", valueColor: AppColors.approvedColor),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 24),
                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(controller.screenshotTimeGroups.length, (groupIndex) {
                    final group = controller.screenshotTimeGroups[groupIndex];
                    final List shots = group["shots"] ?? [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              group["timeRange"] ?? "",
                              style: TTextTheme.h2Style(context).copyWith(fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "Total time worked: ${group["totalWorked"]}",
                                style: TTextTheme.h6Style(context),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount = 3;
                            if (constraints.maxWidth < 600) {
                              crossAxisCount = 1;
                            } else if (constraints.maxWidth < 900) crossAxisCount = 2;

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: shots.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 1.25,
                              ),
                              itemBuilder: (context, index) {
                                return _buildHoverScreenshotCard(context, shots[index], shots, index);
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 24),
                      ],
                    );
                  }),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

   // Summary Box
  Widget _buildSubSummaryBox(BuildContext context, {required double width, required String label, required String value, required Color valueColor}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.tertiaryTextColor)),
          const SizedBox(height: 6),
          Text(value, style: TTextTheme.h6Style(context).copyWith(color: valueColor)),
        ],
      ),
    );
  }

   // Hover Screenshot
  Widget _buildHoverScreenshotCard(BuildContext context, Map<String, dynamic> item, List allShots, int currentIndex) {
    RxBool isHovered = false.obs;

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: Obx(() => Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      ImageString.screenShotImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  if (isHovered.value) ...[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      child: Center(
                        child: PrimaryBtnOfVendorScreenShot(
                          text: "View Screen Shot",
                          height: 40,
                          width: 200,
                          borderRadius: BorderRadius.circular(8),
                          onTap: () => _openLightboxViewerDialog(context, allShots, currentIndex),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      item['time'] ?? "",
                      style: TTextTheme.titleSix(context).copyWith(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: (item['activity'] ?? 50) / 100,
                    backgroundColor: AppColors.tertiaryTextColor.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.approvedColor),
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${item['activity']}% of 10 minutes",
                    style: TTextTheme.titleSix(context).copyWith(fontSize: 9, color: AppColors.tertiaryTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

   // LightBox
  void _openLightboxViewerDialog(BuildContext context, List shots, int initialIndex) {
    RxInt activeIndex = initialIndex.obs;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => Dialog(
        backgroundColor: AppColors.textColor,
        insetPadding: EdgeInsets.zero,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Obx(() {
                  final currentIndex = activeIndex.value;
                  final shotData = (shots.isNotEmpty && currentIndex < shots.length)
                      ? shots[currentIndex]
                      : null;

                  return InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 40.0),
                      child: Image.asset(
                        ImageString.screenShotImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }),
              ),
              Positioned(
                top: 20,
                right: 24,
                child: InkWell(
                  onTap: () => Navigator.pop(dialogContext),
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close, color: AppColors.whiteColor, size: 28),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                child: Obx(() => activeIndex.value > 0
                    ? InkWell(
                  onTap: () => activeIndex.value--,
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.arrow_back, color: AppColors.whiteColor, size: 28),
                  ),
                )
                    : const SizedBox.shrink()),
              ),
              Positioned(
                right: 20,
                child: Obx(() => activeIndex.value < shots.length - 1
                    ? InkWell(
                  onTap: () => activeIndex.value++,
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.arrow_forward, color: AppColors.whiteColor, size: 28),
                  ),
                )
                    : const SizedBox.shrink()),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Team Tab
  Widget _buildTeamTableSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
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
                            Expanded(flex: 3, child: _buildTableHeaderTitle(context, "Total Screen Shots", svgIconPath: IconString.totalScreenShot)),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Active Time",svgIconPath: IconString.idleTime)),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Idle Time", svgIconPath: IconString.idleTime)),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Productivity", svgIconPath: IconString.productivityIcon)),
                            Expanded(flex: 2, child: Text("Action", style: TTextTheme.textFieldAboveText(context))),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),
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
                                  child: PrimaryBtnOfVendorScreenShot(
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
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Total Screen Shots", svgIconPath: IconString.totalScreenShot)),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Active Time", svgIconPath: IconString.idleTime)),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Idle Time", svgIconPath: IconString.idleTime)),
                            Expanded(flex: 2, child: _buildTableHeaderTitle(context, "Productivity", svgIconPath: IconString.productivityIcon)),
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
                                    onTap: () => controller.openEmployeeDetailView(item),
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
        required String svgIconPath,
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
              SvgPicture.asset(
                svgIconPath,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
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
  Widget _buildTableHeaderTitle(BuildContext context, String title, {String? svgIconPath}) {
    return Row(
      children: [
        if (svgIconPath != null) ...[
          SvgPicture.asset(
            svgIconPath,
            width: 13,
            height: 13,
            colorFilter: ColorFilter.mode(
              AppColors.tertiaryTextColor,
              BlendMode.srcIn,
            ),
          ),
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