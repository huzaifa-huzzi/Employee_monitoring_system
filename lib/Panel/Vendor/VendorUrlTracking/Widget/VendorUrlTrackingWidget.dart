import 'package:employee_monitoring_system/Panel/Vendor/VendorUrlTracking/ReusableWidget/CustomPickerUrlTracking.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorUrlTracking/VendorUrlTrackingController.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorUrlTracking/Widget/VenndorTeamUrlTrackingWidget.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



class VendorUrlTrackingWidget extends StatelessWidget {
  const VendorUrlTrackingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VendorUrlController());

    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final bool isMobile = screenWidth < 650;
        final bool isTablet = screenWidth >= 650 && screenWidth < 1100;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12.0 : 24.0,
            vertical: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, controller, isMobile),
              const SizedBox(height: 16),
              _buildFilterBarContainer(context, controller, isMobile),
              const SizedBox(height: 16),
              _buildMetricCards(context, isMobile, isTablet, screenWidth),
              const SizedBox(height: 20),

              Obx(() {
                if (controller.isDetailView.value) {
                  return _buildEmployeeDetailView(context, controller, isMobile);
                } else if (controller.selectedTab.value == 'Team') {
                  return const VendorTeamUrlTrackingWidget();
                } else {
                  return _buildActivitySection(context, controller, isMobile);
                }
              }),
            ],
          ),
        );
      },
    );
  }

  /// ------------ Extra Widget ------------///

  // Header Section
  Widget _buildHeader(
      BuildContext context, VendorUrlController controller, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Obx(
                () {
              final bool shouldShowBackButton = controller.isDetailView.value ||
                  (controller.selectedTab.value == 'Team' && controller.isTeamEmpView.value);

              return Row(
                children: [
                  if (shouldShowBackButton) ...[
                    InkWell(
                      onTap: () {
                        if (controller.isDetailView.value) {
                          controller.showTableView();
                        } else if (controller.selectedTab.value == 'Team' && controller.isTeamEmpView.value) {
                          controller.isTeamEmpView.value = false;
                        }
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0, top: 2.0, bottom: 2.0),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextString.vendorUrlTrackingTitle,
                          style: TTextTheme.h1Style(context).copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          TextString.vendorUrlTrackingSubtitle,
                          style: TTextTheme.h4Style(context).copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.tertiaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Obx(() => Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPillTab(
                context,
                title: TextString.vendorUrlTrackingTabOne,
                isSelected: controller.selectedTab.value == 'Employees',
                onTap: () {
                  controller.selectedTab.value = 'Employees';
                  controller.isDetailView.value = false;
                },
              ),
              _buildPillTab(
                context,
                title: TextString.vendorUrlTrackingTabTwo,
                isSelected: controller.selectedTab.value == 'Team',
                onTap: () {
                  controller.selectedTab.value = 'Team';
                  controller.isDetailView.value = false;
                },
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildPillTab(BuildContext context,
      {required String title,
        required bool isSelected,
        required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TTextTheme.titleFive(context).copyWith(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.whiteColor : AppColors.textColor,
          ),
        ),
      ),
    );
  }

  // Filter Bar Section
  Widget _buildFilterBarContainer(
      BuildContext context, VendorUrlController controller, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDatePicker(context, controller),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _buildTimeFilterSegment(context, controller),
          ),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDatePicker(context, controller),
          _buildTimeFilterSegment(context, controller),
        ],
      ),
    );
  }

   // Date Picker
  Widget _buildDatePicker(
      BuildContext context, VendorUrlController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => controller.changeDateOffset(-1),
            borderRadius: BorderRadius.circular(4),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              child: Icon(Icons.arrow_left,
                  size: 20, color: AppColors.subtextColor),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(16),
                    child: CustomPickerUrlTracker(
                      initialDate: controller.selectedDateTime.value,
                      timeFilterMode: controller.selectedTimeFilter.value,
                      onCancel: () {
                        Navigator.of(dialogContext).pop();
                      },
                      onDateSelected: (selectedDate, weekRange) {
                        controller.selectedDateTime.value = selectedDate;
                        controller.selectedWeekRange.value = weekRange;

                        if (controller.isDetailView.value) {
                          controller.loadDetailTableData();
                        }

                        Navigator.of(dialogContext).pop();
                      },
                    ),
                  );
                },
              );
            },
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Obx(() => Text(
                controller.formattedDateText,
                style: TTextTheme.titleSix(context).copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              )),
            ),
          ),
          InkWell(
            onTap: () => controller.changeDateOffset(1),
            borderRadius: BorderRadius.circular(4),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              child: Icon(Icons.arrow_right,
                  size: 20, color: AppColors.subtextColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeFilterSegment(
      BuildContext context, VendorUrlController controller) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: ['Day', 'Week', 'Last 4 Week'].map((filter) {
          bool isSelected = controller.selectedTimeFilter.value == filter;
          return InkWell(
            onTap: () {
              controller.selectedTimeFilter.value = filter;
              if (controller.isDetailView.value) {
                controller.loadDetailTableData();
              }
            },
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                filter,
                style: TTextTheme.titleFive(context).copyWith(
                  fontSize: 13,
                  fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? AppColors.whiteColor
                      : AppColors.textColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ));
  }

  // Metric Cards
  Widget _buildMetricCards(BuildContext context, bool isMobile, bool isTablet,
      double screenWidth) {
    final cards = [
      _buildSingleCard(
        context,
        iconPath: IconString.idleTime,
        iconColor: AppColors.primaryColor,
        title: TextString.vendorUrlTrackingKPIOne,
        value: TextString.vendorUrlTrackingKPITwo ,
        subText:TextString.vendorUrlTrackingKPIThree,
        subTextColor: AppColors.approvedColor,
      ),
      _buildSingleCard(
        context,
        iconPath: IconString.averageActivity,
        iconColor: AppColors.approvedColor,
        title:TextString.vendorUrlTrackingKPIThirteen ,
        value:TextString.vendorUrlTrackingKPIFourteen ,
        subText:TextString.vendorUrlTrackingKPIFifteen ,
        subTextColor: AppColors.approvedColor,
      ),
      _buildSingleCard(
        context,
        iconPath: IconString.idleTime,
        iconColor: AppColors.rejectedColor,
        title:TextString.vendorUrlTrackingKPIFour ,
        value:TextString.vendorUrlTrackingKPIFive ,
        subText:TextString.vendorUrlTrackingKPISix ,
        subTextColor: AppColors.subtextColor,
      ),
      _buildSingleCard(
        context,
        iconPath: IconString.urlICon,
        iconColor: AppColors.primaryColor,
        title:TextString.vendorUrlTrackingKPISeven ,
        value:TextString.vendorUrlTrackingKPIEight ,
        subText:TextString.vendorUrlTrackingKPINine,
        subTextColor: AppColors.subtextColor,
      ),
      _buildSingleCard(
        context,
        iconPath: IconString.averageActivity,
        iconColor: AppColors.approvedColor,
        title:TextString.vendorUrlTrackingKPITen ,
        value:TextString.vendorUrlTrackingKPIEleven,
        subText:TextString.vendorUrlTrackingKPITwelve ,
        subTextColor: AppColors.approvedColor,
      ),
    ];

    if (isMobile) {
      return Column(
        children: cards
            .map((c) => Padding(
            padding: const EdgeInsets.only(bottom: 10), child: c))
            .toList(),
      );
    }

    int crossAxisCount = isTablet ? 3 : 5;
    double paddingSpace = isMobile ? 24 : 48;
    double totalSpacing = (crossAxisCount - 1) * 12;
    double itemWidth =
        (screenWidth - paddingSpace - totalSpacing) / crossAxisCount;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children:
      cards.map((c) => SizedBox(width: itemWidth, child: c)).toList(),
    );
  }

  Widget _buildSingleCard(
      BuildContext context, {
        required String iconPath,
        required Color iconColor,
        required String title,
        required String value,
        required String subText,
        required Color subTextColor,
      }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
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
                  iconColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TTextTheme.titleTwo(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: TTextTheme.h2Style(context)),
          const SizedBox(height: 6),
          Text(
            subText,
            style: TTextTheme.titleRegular11(context).copyWith(color: subTextColor),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Main Employee Table
  Widget _buildActivitySection(
      BuildContext context, VendorUrlController controller, bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TextString.vendorUrlTrackingEmployeeActivity,
                    style: TTextTheme.h3Style(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    TextString.vendorUrlTrackingEmployeeActivitySubtitle,
                    style: TTextTheme.h4Style(context).copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.tertiaryTextColor,
                    ),
                  ),
                ],
              ),
              if (!isMobile) _buildSearchBar(context),
            ],
          ),
          if (isMobile) ...[
            const SizedBox(height: 12),
            _buildSearchBar(context),
          ],
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final double tableWidth = constraints.maxWidth < 800
                  ? 800
                  : constraints.maxWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: tableWidth,
                  child: Column(
                    children: [
                      _buildTableHeader(context, controller),
                      const SizedBox(height: 8),
                      Obx(() => Column(
                        children: List.generate(
                          controller.employeesList.length,
                              (index) => _buildTableRow(
                              context,
                              controller,
                              controller.employeesList[index],
                              index),
                        ),
                      )),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildPaginationBar(context, controller),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      width: 230,
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.borderColor.withValues(alpha: 0.8),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            size: 15,
            color: AppColors.tertiaryTextColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              cursorColor: AppColors.textColor,
              style: TTextTheme.titleFive(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
              decoration: InputDecoration(
                hintText: TextString.vendorUrlTrackingFieldText,
                hintStyle: TTextTheme.titleFive(context).copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.tertiaryTextColor,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.only(bottom: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomCheckbox({
    required bool value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 10),
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: value ? AppColors.primaryColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: value
                ? AppColors.primaryColor
                : AppColors.borderColor.withValues(alpha: 0.8),
            width: 1.2,
          ),
        ),
        child: value
            ? const Icon(
          Icons.check,
          size: 11,
          color: AppColors.whiteColor,
        )
            : null,
      ),
    );
  }

  Widget _buildTableHeader(
      BuildContext context, VendorUrlController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Center(
              child: Obx(
                    () => _buildCustomCheckbox(
                  value: controller.isAllSelected,
                  onTap: () => controller.toggleSelectAll(),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Text(TextString.vendorUrlTrackingTabOne, style: TTextTheme.titleSeven(context))),
          Expanded(
              flex: 2,
              child: Text(TextString.vendorUrlTrackingTopUrl, style: TTextTheme.titleSeven(context))),
          Expanded(
              flex: 2,
              child: Text(TextString.vendorUrlTrackingUsageTime, style: TTextTheme.titleSeven(context))),
          Expanded(
              flex: 2,
              child: Text(TextString.vendorUrlTrackingUsage, style: TTextTheme.titleSeven(context))),
          Expanded(
              flex: 2,
              child: Text(TextString.vendorUrlTrackingTopUrlUsed, style: TTextTheme.titleSeven(context))),
          SizedBox(
              width: 50,
              child: Text(TextString.vendorUrlTrackingAction,
                  style: TTextTheme.titleSeven(context),
                  textAlign: TextAlign.center)),
        ],
      ),
    );
  }

   // Table Row
  Widget _buildTableRow(BuildContext context, VendorUrlController controller,
      Map<String, dynamic> data, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Center(
              child: Obx(
                    () => _buildCustomCheckbox(
                  value: controller.employeesList[index]['isSelected'] ?? false,
                  onTap: () => controller.toggleSelectRow(index),
                ),
              ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['name'], style: TTextTheme.titleEight(context)),
                      Text(data['email'], style: TTextTheme.titleFour(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(data['topUrl'], style: TTextTheme.titleSix(context))),
          Expanded(
              flex: 2,
              child: Text(data['usageTime'], style: TTextTheme.titleSix(context))),
          Expanded(
              flex: 2,
              child: Text(data['usage'], style: TTextTheme.titleSix(context))),
          Expanded(
              flex: 2,
              child: Text(data['urlUsed'], style: TTextTheme.titleSix(context))),
          SizedBox(
            width: 50,
            child: Center(
              child: InkWell(
                onTap: () => controller.showEmployeeDetail(data),
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.remove_red_eye_outlined,
                      size: 18, color: AppColors.tertiaryTextColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

   // Pagination Bar
  Widget _buildPaginationBar(
      BuildContext context, VendorUrlController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (controller.currentPage.value > 1) {
              controller.currentPage.value--;
            }
          },
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.borderColor.withValues(alpha: 0.8),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.arrow_back,
              size: 15,
              color: AppColors.subtextColor,
            ),
          ),
        ),
        Obx(() => Text(
          'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
          style: TTextTheme.titleFive(context).copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
        )),
        InkWell(
          onTap: () {
            if (controller.currentPage.value < controller.totalPages.value) {
              controller.currentPage.value++;
            }
          },
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.borderColor.withValues(alpha: 0.8),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.arrow_forward,
              size: 15,
              color: AppColors.subtextColor,
            ),
          ),
        ),
      ],
    );
  }

   // Employee Detail view
  Widget _buildEmployeeDetailView(
      BuildContext context, VendorUrlController controller, bool isMobile) {
    final emp = controller.selectedEmployee;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 12 : 20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      IconString.employeePerson,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          emp['name'] ?? 'Jack Milson',
                          style: TTextTheme.titleEight(context).copyWith(fontSize: 12),
                        ),
                        Text(
                          emp['email'] ?? 'jack@gmail.com',
                          style: TTextTheme.titleFour(context).copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.approvedColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  TextString.vendorUrlTrackingOnline,
                  style: TTextTheme.titleFive(context).copyWith(
                    fontSize: 12,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
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
                  TextString.vendorUrlTrackingUrlBrowse,
                  style: TTextTheme.h3Style(context).copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                _buildHoverableChart(context, controller),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
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
                Obx(() {
                  String filter = controller.selectedTimeFilter.value;
                  return Text(
                    filter == 'Day'
                        ? 'Daily Tracking'
                        : filter == 'Week'
                        ? 'Weekly Tracking'
                        : 'Last 4 Week Tracking',
                    style: TTextTheme.h3Style(context).copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  );
                }),
                const SizedBox(height: 16),
                _buildDetailTable(context, controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hoverable Charts
  Widget _buildHoverableChart(
      BuildContext context, VendorUrlController controller) {
    return Obx(() {
      String filter = controller.selectedTimeFilter.value;
      List<Map<String, dynamic>> chartData;
      List<String> xLabels;

      if (filter == 'Day') {
        xLabels = ['0', '20', '40', '1hr', '1hr 20 min', '1hr 40 min', '2hr'];
        chartData = [
          {'title': 'Google docs', 'flex': 95, 'time': '2hr 20mints', 'percent': '80% of total time'},
          {'title': 'Behance', 'flex': 18, 'time': '20mints', 'percent': '10% of total time'},
          {'title': 'Chat Gpt', 'flex': 25, 'time': '25mints', 'percent': '5% of total time'},
          {'title': 'Hubstaff', 'flex': 28, 'time': '30mints', 'percent': '5% of total time'},
        ];
      } else if (filter == 'Week') {
        xLabels = ['0', '2hrs', '4hrs', '6hrs', '8hrs', '10hrs', '12hrs'];
        chartData = [
          {'title': 'Google docs', 'flex': 95, 'time': '10hrs 10mints', 'percent': '80% of total time'},
          {'title': 'Behance', 'flex': 52, 'time': '5hrs 24mints', 'percent': '10% of total time'},
          {'title': 'Chat Gpt', 'flex': 22, 'time': '2hrs 14mints', 'percent': '5% of total time'},
          {'title': 'Hubstaff', 'flex': 38, 'time': '4hrs 12mints', 'percent': '5% of total time'},
        ];
      } else {
        xLabels = ['0', '10hrs', '20hrs', '30hrs', '40hrs', '50hrs', '60hrs'];
        chartData = [
          {'title': 'Google docs', 'flex': 72, 'time': '40hrs 50mints', 'percent': '80% of total time'},
          {'title': 'Behance', 'flex': 40, 'time': '20hrs 24mints', 'percent': '10% of total time'},
          {'title': 'Chat Gpt', 'flex': 12, 'time': '8hrs 14mints', 'percent': '5% of total time'},
          {'title': 'Hubstaff', 'flex': 25, 'time': '16hrs 12mints', 'percent': '5% of total time'},
        ];
      }

      return Column(
        children: [
          ...List.generate(chartData.length, (index) {
            final item = chartData[index];
            final bool isHovered = controller.hoveredBarIndex.value == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      item['title'],
                      style: TTextTheme.titleFive(context).copyWith(
                        fontSize: 12,
                        color: AppColors.tertiaryTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MouseRegion(
                      onEnter: (_) => controller.hoveredBarIndex.value = index,
                      onExit: (_) => controller.hoveredBarIndex.value = -1,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: item['flex'] as int,
                                child: Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 100 - (item['flex'] as int),
                                child: const SizedBox(),
                              ),
                            ],
                          ),
                          if (isHovered)
                            Positioned(
                              left: 12,
                              top: -46,
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.whiteColor,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.borderColor.withValues(alpha: 0.6),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Total Time : ${item['time']}',
                                        style: TTextTheme.titleFive(context).copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Text(
                                        '${item['percent']}',
                                        style: TTextTheme.titleFive(context).copyWith(
                                          fontSize: 10,
                                          color: AppColors.tertiaryTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 88),
              ...xLabels.map((lbl) => Expanded(
                child: Text(
                  lbl,
                  textAlign: TextAlign.center,
                  style: TTextTheme.titleFive(context).copyWith(
                    fontSize: 11,
                    color: AppColors.tertiaryTextColor,
                  ),
                ),
              )),
            ],
          ),
        ],
      );
    });
  }

  // Detail Table
  Widget _buildDetailTable(
      BuildContext context, VendorUrlController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double tableWidth =
        constraints.maxWidth < 650 ? 650 : constraints.maxWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: tableWidth,
            child: Column(
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 32,
                        child: Center(
                          child: Obx(
                                () => _buildCustomCheckbox(
                              value: controller.isAllDetailSelected.value,
                              onTap: () => controller.toggleDetailSelectAll(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 3,
                        child: Text(TextString.vendorUrlTrackingTableOne,
                            style: TTextTheme.titleSeven(context)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 14, color: AppColors.tertiaryTextColor),
                            const SizedBox(width: 4),
                            Text(TextString.vendorUrlTrackingTableTwo,
                                style: TTextTheme.titleSeven(context)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 14, color: AppColors.tertiaryTextColor),
                            const SizedBox(width: 4),
                            Text(TextString.vendorUrlTrackingTableThree,
                                style: TTextTheme.titleSeven(context)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              IconString.comparisonIcon,
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                AppColors.tertiaryTextColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(TextString.vendorUrlTrackingTableFour,
                                style: TTextTheme.titleSeven(context)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                Obx(() => Column(
                  children: List.generate(controller.detailRows.length, (index) {
                    final r = controller.detailRows[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.borderColor.withValues(alpha: 0.6)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 32,
                            child: Center(
                              child: _buildCustomCheckbox(
                                value: r['isSelected'] ?? false,
                                onTap: () => controller.toggleDetailRow(index),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: Text(r['url'],
                                style: TTextTheme.titleEight(context)),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(r['time'],
                                style: TTextTheme.titleSix(context)),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(r['timeBy'],
                                style: TTextTheme.titleSix(context)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              r['comp'],
                              style: TTextTheme.titleSix(context).copyWith(
                                color: r['isUp'] == true
                                    ? AppColors.approvedColor
                                    : AppColors.rejectedColor,
                                fontWeight: FontWeight.w600,
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
    );
  }
}