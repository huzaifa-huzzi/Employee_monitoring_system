import 'package:employee_monitoring_system/Panel/Vendor/VendorActivityTracking/ReusableWidget/PrimaryBtnOfVendorActivity.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorActivityTracking/VendorActivityController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VendorActivityTeamTracking extends StatelessWidget {
  const VendorActivityTeamTracking({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VendorActivityController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          if (controller.isShowingTeamEmployeeDetail.value) {
            return _buildTeamDetailView(context, controller);
          }
          if (controller.isShowingTeamDetail.value) {
            return _buildTeamDetailView(context, controller);
          }
          if (controller.isShowingTeamEmployees.value) {
            return _buildTeamEmployeesTableCard(context, controller);
          }
          return _buildTeamTableCard(context, controller);
        }),
      ],
    );
  }

  /// ------------ Extra Widget -------------///

  // Team Card
  Widget _buildTeamTableCard(BuildContext context,
      VendorActivityController controller) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.vendorTeamActivity,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            TextString.vendorTeamActivitySubtitle,
            style: TTextTheme.titleSix(context).copyWith(
              fontSize: 11,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 16),

          LayoutBuilder(
            builder: (context, constraints) {
              const double minTableWidth = 700.0;
              final double targetWidth = constraints.maxWidth < minTableWidth
                  ? minTableWidth
                  : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: targetWidth,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfScreenColor.withValues(
                              alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 32,
                              child: Obx(
                                    () =>
                                    Checkbox(
                                      value: controller.isTeamAllSelected.value,
                                      onChanged: (val) =>
                                          controller.toggleSelectAllTeams(val),
                                      activeColor: AppColors.primaryColor,
                                      materialTapTargetSize: MaterialTapTargetSize
                                          .shrinkWrap,
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                TextString.vendorTeamActivityTableOne,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.tertiaryTextColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                TextString.vendorTeamActivityTableTwo,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 95,
                              child: Text(
                                TextString.vendorActivityEmployeeTableSix,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.tertiaryTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                            () =>
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.teamList.length,
                              separatorBuilder: (context,
                                  index) => const SizedBox(height: 6),
                              itemBuilder: (context, index) {
                                final item = controller.teamList[index];
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: AppColors.borderColor.withValues(
                                            alpha: 0.4)),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 32,
                                        child: Checkbox(
                                          value: item.isSelected,
                                          onChanged: (val) =>
                                              controller.toggleSelectTeamItem(
                                                  index, val),
                                          activeColor: AppColors.primaryColor,
                                          materialTapTargetSize: MaterialTapTargetSize
                                              .shrinkWrap,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          item.teamName,
                                          style: TTextTheme
                                              .titleEight(context)
                                              .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "${item.membersCount}",
                                          style: TTextTheme
                                              .titleSix(context)
                                              .copyWith(
                                            fontSize: 12,
                                            color: AppColors.tertiaryTextColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          item.mousePercent,
                                          style: TTextTheme
                                              .titleSix(context)
                                              .copyWith(
                                            fontSize: 12,
                                            color: AppColors.tertiaryTextColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          item.keyboardPercent,
                                          style: TTextTheme
                                              .titleSix(context)
                                              .copyWith(
                                            fontSize: 12,
                                            color: AppColors.tertiaryTextColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          item.idlePercent,
                                          style: TTextTheme
                                              .titleSix(context)
                                              .copyWith(
                                            fontSize: 12,
                                            color: AppColors.tertiaryTextColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "${item.overallPercent}%",
                                          style: TTextTheme
                                              .titleEight(context)
                                              .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getOverallColor(
                                                item.overallPercent),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 110,
                                        child: PrimaryBtnOfVendorActivity(
                                          text: "View Emp",
                                          height: 40,
                                          borderRadius: BorderRadius.circular(
                                              6),
                                          onTap: () {
                                            controller.viewEmployeesForTeam(
                                                item);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
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
          const SizedBox(height: 20),
          _buildPaginationFooter(context, controller),
        ],
      ),
    );
  }

  // Team Employee Card
  Widget _buildTeamEmployeesTableCard(BuildContext context,
      VendorActivityController controller) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;

              final titleSection = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TextString.vendorTeamActivityEmployee,
                    style: TTextTheme.h2Style(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    TextString.vendorTeamActivityEmployeeSubtitle,
                    style: TTextTheme.titleSix(context).copyWith(
                      fontSize: 11,
                      color: AppColors.tertiaryTextColor,
                    ),
                  ),
                ],
              );

              final searchField = Container(
                width: isMobile ? double.infinity : 260,
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 18,
                        color: AppColors.tertiaryTextColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        cursorColor: AppColors.textColor,
                        onChanged: (val) => controller.searchTeamEmployee(val),
                        style: TTextTheme.titleSix(context).copyWith(
                          fontSize: 12,
                          color: AppColors.textColor,
                        ),
                        decoration: InputDecoration(
                          hintText: TextString.vendorActivityEmployeeActiviyFieldText,
                          hintStyle: TTextTheme.titleSix(context).copyWith(
                            fontSize: 12,
                            color: AppColors.tertiaryTextColor,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              );

              if (isMobile) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleSection,
                    const SizedBox(height: 12),
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
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              const double minTableWidth = 700.0;
              final double targetWidth = constraints.maxWidth < minTableWidth
                  ? minTableWidth
                  : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: targetWidth,
                  child: Column(
                    children: [
                      // Header Row
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfScreenColor.withValues(
                              alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 32,
                              child: Obx(
                                    () =>
                                    Checkbox(
                                      value: controller.isTeamEmpAllSelected
                                          .value,
                                      onChanged: (val) =>
                                          controller
                                              .toggleSelectAllTeamEmployees(
                                              val),
                                      activeColor: AppColors.primaryColor,
                                      materialTapTargetSize: MaterialTapTargetSize
                                          .shrinkWrap,
                                    ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                TextString.vendorTeamActivityEmployeeTableOne,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                TextString.vendorActivityEmployeeTableSix,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.tertiaryTextColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() {
                        if (controller.teamEmployeeList.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Center(
                              child: Text(
                                "No Employees Found",
                                style: TTextTheme.TextError(context)
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.teamEmployeeList.length,
                          separatorBuilder: (context, index) =>
                          const SizedBox(height: 6),
                          itemBuilder: (context, index) {
                            final emp = controller.teamEmployeeList[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColors.borderColor.withValues(
                                        alpha: 0.4)),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 32,
                                    child: Checkbox(
                                      value: emp.isSelected,
                                      onChanged: (val) =>
                                          controller.toggleSelectTeamEmpItem(
                                              index, val),
                                      activeColor: AppColors.primaryColor,
                                      materialTapTargetSize: MaterialTapTargetSize
                                          .shrinkWrap,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          IconString.employeePerson,
                                          width: 20,
                                          height: 20,
                                          colorFilter: const ColorFilter.mode(
                                            AppColors.primaryColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                emp.name,
                                                style: TTextTheme.titleEight(
                                                    context).copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.textColor,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                emp.email,
                                                style: TTextTheme.titleSix(
                                                    context).copyWith(
                                                  fontSize: 10,
                                                  color: AppColors
                                                      .tertiaryTextColor,
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
                                      emp.mousePercent,
                                      style: TTextTheme
                                          .titleSix(context)
                                          .copyWith(
                                        fontSize: 12,
                                        color: AppColors.tertiaryTextColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      emp.keyboardPercent,
                                      style: TTextTheme
                                          .titleSix(context)
                                          .copyWith(
                                        fontSize: 12,
                                        color: AppColors.tertiaryTextColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      emp.idlePercent,
                                      style: TTextTheme
                                          .titleSix(context)
                                          .copyWith(
                                        fontSize: 12,
                                        color: AppColors.tertiaryTextColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${emp.overallPercent}%",
                                      style: TTextTheme
                                          .titleEight(context)
                                          .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getOverallColor(
                                            emp.overallPercent),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () {
                                          debugPrint("Eye icon tapped for: ${emp
                                              .name}");
                                          controller.viewTeamEmployeeDetail(
                                              emp);
                                        },
                                        icon: const Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 18,
                                          color: AppColors.textColor,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        splashRadius: 18,
                                        tooltip: "View Detail",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      })
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildPaginationFooter(context, controller),
        ],
      ),
    );
  }

  // Pagination
  Widget _buildPaginationFooter(BuildContext context,
      VendorActivityController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => controller.prevPage(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppColors.borderColor.withValues(alpha: 0.8)),
            ),
            child: const Icon(
              Icons.arrow_back,
              size: 16,
              color: AppColors.textColor,
            ),
          ),
        ),
        Obx(
              () =>
              Text(
                "Page ${controller.currentPage.value} of ${controller.totalPages
                    .value}",
                style: TTextTheme.titleSix(context).copyWith(
                  fontSize: 12,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
        ),
        InkWell(
          onTap: () => controller.nextPage(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppColors.borderColor.withValues(alpha: 0.8)),
            ),
            child: const Icon(
              Icons.arrow_forward,
              size: 16,
              color: AppColors.textColor,
            ),
          ),
        ),
      ],
    );
  }

  // Team Detail View
  Widget _buildTeamDetailView(BuildContext context,
      VendorActivityController controller) {
    return Obx(() {
      final emp = controller.selectedTeamEmployeeDetail.value;

      final empName = emp?.name ?? "Jack Milson";
      final empEmail = emp?.email ?? "jack@gmail.com";

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: AppColors.borderColor.withValues(alpha: 0.5)),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundOfScreenColor.withValues(
                          alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          IconString.employeePerson,
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                empName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TTextTheme.titleEight(context).copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                empEmail,
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.approvedColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    TextString.vendorActivityOnline,
                    style: TTextTheme.titleRegular12White(context).copyWith(
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
                    _buildTeamMonthlyGraphCard(context),
                    const SizedBox(height: 16),
                    _buildTeamWeekBreakdownTable(context, controller),
                  ],
                );
              } else if (timeframe == "Week") {
                return Column(
                  children: [
                    _buildTeamWeeklyGraphCard(context),
                    const SizedBox(height: 16),
                    _buildTeamWeekBreakdownTable(context, controller)
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildTeamDailyGraphCard(context),
                    const SizedBox(height: 16),
                    _buildTeamSessionBreakdownTable(context, controller),
                  ],
                );
              }
            }),
          ],
        ),
      );
    });
  }

  // Team Session Breakdown
  Widget _buildTeamSessionBreakdownTable(BuildContext context,
      VendorActivityController controller) {
    final teamSessions = [
      {
        "time": "9:00-10:00",
        "mouse": "40%",
        "key": "60%",
        "idle": "4%",
        "overall": "82%"
      },
      {
        "time": "10:00-11:00",
        "mouse": "50%",
        "key": "55%",
        "idle": "6%",
        "overall": "88%"
      },
      {
        "time": "11:00-12:00",
        "mouse": "62%",
        "key": "70%",
        "idle": "5%",
        "overall": "75%"
      },
      {
        "time": "12:00-1:00",
        "mouse": "35%",
        "key": "40%",
        "idle": "15%",
        "overall": "70%"
      },
      {
        "time": "1:00-2:00",
        "mouse": "-----",
        "key": "-----",
        "idle": "-----",
        "overall": "-----"
      },
      {
        "time": "2:00-3:00",
        "mouse": "68%",
        "key": "50%",
        "idle": "10%",
        "overall": "84%"
      },
      {
        "time": "3:00-4:00",
        "mouse": "72%",
        "key": "58%",
        "idle": "8%",
        "overall": "86%"
      },
      {
        "time": "4:00-5:00",
        "mouse": "65%",
        "key": "45%",
        "idle": "12%",
        "overall": "80%"
      },
      {
        "time": "5:00-6:00",
        "mouse": "60%",
        "key": "40%",
        "idle": "15%",
        "overall": "78%"
      },
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
            TextString.vendorTeamSession,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          Text(
            TextString.vendorTeamSessionSubtitle,
            style: TTextTheme.titleSix(context).copyWith(
              fontSize: 11,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              const double minWidth = 650.0;
              final currentWidth = constraints.maxWidth < minWidth
                  ? minWidth
                  : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: currentWidth,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfScreenColor.withValues(
                              alpha: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Obx(() {
                              final isAllSelected = controller
                                  .selectedSessionIndices.length ==
                                  teamSessions.length &&
                                  teamSessions.isNotEmpty;
                              return SizedBox(
                                width: 24,
                                height: 18,
                                child: Checkbox(
                                  value: isAllSelected,
                                  onChanged: (_) =>
                                      controller.toggleSelectAllSessions(
                                          teamSessions.length),
                                  activeColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              );
                            }),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 3,
                              child: Text(
                                TextString.vendorTeamSessionSlot,
                                style: TTextTheme.titleSix(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                        itemCount: teamSessions.length,
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 6),
                        itemBuilder: (context, index) {
                          final item = teamSessions[index];
                          Color overallColor = AppColors.textColor;
                          if (item["overall"] != "-----") {
                            int val = int.tryParse(
                                item["overall"]!.replaceAll("%", "")) ?? 0;
                            if (val >= 75) {
                              overallColor = AppColors.approvedColor;
                            } else if (val < 70) {
                              overallColor = AppColors.rejectedColor;
                            }
                          } else {
                            overallColor = AppColors.tertiaryTextColor;
                          }

                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.borderColor.withValues(
                                      alpha: 0.5)),
                            ),
                            child: Row(
                              children: [
                                Obx(() {
                                  final isSelected = controller
                                      .selectedSessionIndices.contains(index);
                                  return SizedBox(
                                    width: 24,
                                    height: 18,
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged: (_) =>
                                          controller.toggleSessionSelection(
                                              index),
                                      activeColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              4)),
                                    ),
                                  );
                                }),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    item["time"]!,
                                    style: TTextTheme
                                        .titleEight(context)
                                        .copyWith(
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
                                    style: TTextTheme
                                        .titleSix(context)
                                        .copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["key"]!,
                                    style: TTextTheme
                                        .titleSix(context)
                                        .copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["idle"]!,
                                    style: TTextTheme
                                        .titleSix(context)
                                        .copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["overall"]!,
                                    style: TTextTheme
                                        .titleEight(context)
                                        .copyWith(
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

  // Team Week breakdown Table
  Widget _buildTeamWeekBreakdownTable(BuildContext context,
      VendorActivityController controller) {
    final teamWeeks = [
      {
        "week": "Week 1",
        "mouse": "52%",
        "key": "62%",
        "idle": "6%",
        "overall": "84%"
      },
      {
        "week": "Week 2",
        "mouse": "58%",
        "key": "68%",
        "idle": "5%",
        "overall": "89%"
      },
      {
        "week": "Week 3",
        "mouse": "48%",
        "key": "54%",
        "idle": "10%",
        "overall": "76%"
      },
      {
        "week": "Week 4",
        "mouse": "62%",
        "key": "72%",
        "idle": "4%",
        "overall": "91%"
      },
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
            TextString.vendorTeamWeeklyBreakdown,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            TextString.vendorTeamWeeklyBreakdownSubtitle,
            style: TTextTheme.titleSix(context).copyWith(
              fontSize: 11,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              const double minWidth = 650.0;
              final currentWidth = constraints.maxWidth < minWidth
                  ? minWidth
                  : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: currentWidth,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfScreenColor.withValues(
                              alpha: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Obx(() {
                              final isAllSelected = controller
                                  .selectedWeekIndices.length ==
                                  teamWeeks.length && teamWeeks.isNotEmpty;
                              return SizedBox(
                                width: 24,
                                height: 18,
                                child: Checkbox(
                                  value: isAllSelected,
                                  onChanged: (_) =>
                                      controller.toggleSelectAllWeeks(
                                          teamWeeks.length),
                                  activeColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                                  color: AppColors.tertiaryTextColor,
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
                        itemCount: teamWeeks.length,
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 6),
                        itemBuilder: (context, index) {
                          final item = teamWeeks[index];
                          Color overallColor = AppColors.textColor;
                          int val = int.tryParse(
                              item["overall"]!.replaceAll("%", "")) ?? 0;
                          if (val >= 75) {
                            overallColor = AppColors.approvedColor;
                          } else if (val < 70) {
                            overallColor = AppColors.rejectedColor;
                          }

                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.borderColor.withValues(
                                      alpha: 0.5)),
                            ),
                            child: Row(
                              children: [
                                Obx(() {
                                  final isSelected = controller
                                      .selectedWeekIndices.contains(index);
                                  return SizedBox(
                                    width: 24,
                                    height: 18,
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged: (_) =>
                                          controller.toggleWeekSelection(index),
                                      activeColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              4)),
                                    ),
                                  );
                                }),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    item["week"]!,
                                    style: TTextTheme
                                        .titleEight(context)
                                        .copyWith(
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
                                    style: TTextTheme
                                        .titleSix(context)
                                        .copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["key"]!,
                                    style: TTextTheme
                                        .titleSix(context)
                                        .copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["idle"]!,
                                    style: TTextTheme
                                        .titleSix(context)
                                        .copyWith(
                                      fontSize: 12,
                                      color: AppColors.tertiaryTextColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["overall"]!,
                                    style: TTextTheme
                                        .titleEight(context)
                                        .copyWith(
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

  // Daily Graph Card
  Widget _buildTeamDailyGraphCard(BuildContext context) {
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
              _buildLegendItem(context, AppColors.borderColor.withValues(alpha: 0.4), TextString.vendorActivityIdle),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              const double minWidth = 600.0;
              final currentWidth = constraints.maxWidth < minWidth
                  ? minWidth
                  : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: currentWidth,
                  child: Column(
                    children: [
                      Container(
                        height: 16,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.borderColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 0,
                              width: currentWidth * 0.12,
                              top: 0,
                              bottom: 0,
                              child: _buildExactTooltip(
                                context: context,
                                totalTime: "2hrs",
                                highActivity: "1hr 48minuts",
                                lowActivity: "12minuts",
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 30,
                                        child: Container(color: AppColors.pendingColor),
                                      ),
                                      Expanded(
                                        flex: 70,
                                        child: Container(color: AppColors.approvedColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: currentWidth * 0.16,
                              width: currentWidth * 0.10,
                              top: 0,
                              bottom: 0,
                              child: _buildExactTooltip(
                                context: context,
                                totalTime: "1hr 30m",
                                highActivity: "20minuts",
                                lowActivity: "1hr 10minuts",
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 25,
                                        child: Container(color: AppColors.approvedColor),
                                      ),
                                      Expanded(
                                        flex: 75,
                                        child: Container(color: AppColors.pendingColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: currentWidth * 0.48,
                              width: currentWidth * 0.08,
                              top: 0,
                              bottom: 0,
                              child: _buildExactTooltip(
                                context: context,
                                totalTime: "1hr 15m",
                                highActivity: "1hr 15minuts",
                                lowActivity: "0minuts",
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.approvedColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: currentWidth * 0.68,
                              width: currentWidth * 0.12,
                              top: 0,
                              bottom: 0,
                              child: _buildExactTooltip(
                                context: context,
                                totalTime: "2hrs",
                                highActivity: "2hrs",
                                lowActivity: "0minuts",
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.approvedColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
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

 // Weekly Graph Card
  Widget _buildTeamWeeklyGraphCard(BuildContext context) {
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
            TextString.vendorTeamWeeklyActivityGraph,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            TextString.vendorTeamWeeklyActivityGraphSubtitle,
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
              final width = constraints.maxWidth < minWidth
                  ? minWidth
                  : constraints.maxWidth;

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
                              _BarSegment(flex: 50, color: AppColors.approvedColor),
                              _BarSegment(flex: 15, color: AppColors.pendingColor),
                              _BarSegment(flex: 5, color: AppColors.borderColor),
                            ]),
                            _buildStackedBar(context, "Tue", [
                              _BarSegment(flex: 60, color: AppColors.approvedColor),
                              _BarSegment(flex: 10, color: AppColors.pendingColor),
                              _BarSegment(flex: 8, color: AppColors.borderColor),
                            ]),
                            _buildStackedBar(context, "Wed", [
                              _BarSegment(flex: 65, color: AppColors.approvedColor),
                              _BarSegment(flex: 12, color: AppColors.pendingColor),
                              _BarSegment(flex: 6, color: AppColors.borderColor),
                            ]),
                            _buildStackedBar(context, "Thu", [
                              _BarSegment(flex: 40, color: AppColors.approvedColor),
                              _BarSegment(flex: 20, color: AppColors.pendingColor),
                              _BarSegment(flex: 10, color: AppColors.borderColor),
                            ]),
                            _buildStackedBar(context, "Fri", [
                              _BarSegment(flex: 55, color: AppColors.approvedColor),
                              _BarSegment(flex: 15, color: AppColors.pendingColor),
                              _BarSegment(flex: 12, color: AppColors.borderColor),
                            ]),
                            _buildStackedBar(context, "Sat", [
                              _BarSegment(flex: 10, color: AppColors.pendingColor),
                              _BarSegment(flex: 40, color: AppColors.borderColor),
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

   // Monthly Graph Card
  Widget _buildTeamMonthlyGraphCard(BuildContext context) {
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
            TextString.vendorTeamMonthly,
            style: TTextTheme.h2Style(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            TextString.vendorTeamMonthlySubtitle,
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
              final width = constraints.maxWidth < minWidth
                  ? minWidth
                  : constraints.maxWidth;

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
                              _BarSegment(flex: 55, color: AppColors.approvedColor),
                              _BarSegment(flex: 15, color: AppColors.pendingColor),
                              _BarSegment(flex: 6, color: AppColors.borderColor),
                            ]),
                            _buildStackedBar(context, "Week 2", [
                              _BarSegment(flex: 60, color: AppColors.approvedColor),
                              _BarSegment(flex: 12, color: AppColors.pendingColor),
                              _BarSegment(flex: 5, color: AppColors.borderColor),
                            ]),
                            _buildStackedBar(context, "Week 3", [
                              _BarSegment(flex: 45, color: AppColors.approvedColor),
                              _BarSegment(flex: 20, color: AppColors.pendingColor),
                              _BarSegment(flex: 10, color: AppColors.borderColor),
                            ]),
                            _buildStackedBar(context, "Week 4", [
                              _BarSegment(flex: 62, color: AppColors.approvedColor),
                              _BarSegment(flex: 10, color: AppColors.pendingColor),
                              _BarSegment(flex: 4, color: AppColors.borderColor),
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

// Stacked Bar
  Widget _buildStackedBar(
      BuildContext context, String dayLabel, List<_BarSegment> segments) {
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
                .map((seg) =>
                Expanded(flex: seg.flex, child: Container(color: seg.color)))
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
  // Legend Item
  Widget _buildLegendItem(BuildContext context, Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
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
                    style: TTextTheme.titleEight(context).copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  TextSpan(
                    text: totalTime,
                    style: TTextTheme.titleEight(context).copyWith(
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

  Color _getOverallColor(int percent) {
    if (percent >= 75) {
      return AppColors.approvedColor;
    } else if (percent >= 50) {
      return AppColors.pendingColor;
    } else {
      return AppColors.rejectedColor;
    }
  }
}

 /// Class
// Bar Segment
class _BarSegment {
  final int flex;
  final Color color;
  _BarSegment({required this.flex, required this.color});
}