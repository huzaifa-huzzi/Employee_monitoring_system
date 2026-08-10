import 'package:employee_monitoring_system/Panel/Vendor/VendorApplicationTracking/ReusableWidget/CustomPickerVendorApplication.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorApplicationTracking/VendorApplicationTrackingController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



class VendorApplicationTrackingWidget extends StatelessWidget {
  const VendorApplicationTrackingWidget({super.key});

    // Date Picker Dialog
  void _openDatePickerDialog(BuildContext context, VendorApplicationTrackingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: CustomDatePickerVendorApplication(
            initialDate: controller.selectedDate.value,
            timeFilterMode: controller.selectedFilter.value,
            onCancel: () => Navigator.of(ctx).pop(),
            onDateSelected: (selectedDate, weekRange) {
              controller.updateWeekRanges(selectedDate);
              Navigator.of(ctx).pop();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VendorApplicationTrackingController());

    return Container(
      color: AppColors.backgroundOfScreenColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopHeader(context, controller),
            const SizedBox(height: 16),
            _buildFilterContainer(context, controller),
            const SizedBox(height: 16),
            _buildStatCardsGrid(context),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.isEmployeesTab.value) {
                return controller.isDetailView.value
                    ? _buildEmployeeDetailView(context, controller)
                    : _buildEmployeeActivitySection(context, controller);
              } else {
                return _buildTeamActivitySection(context, controller);
              }
            }),
          ],
        ),
      ),
    );
  }

  /// ----------------- Extra Widget ------------///

   // Top Header
  Widget _buildTopHeader(BuildContext context, VendorApplicationTrackingController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        Widget titleSection = Obx(
              () => Row(
            children: [
              if (controller.isDetailView.value) ...[
                InkWell(
                  onTap: () => controller.closeEmployeeDetail(),
                  borderRadius: BorderRadius.circular(4),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
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
                      'Application Tracking',
                      style: TTextTheme.h1Style(context).copyWith(
                        fontSize: isMobile ? 20 : 28,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'You can see your application tracking here',
                      style: TTextTheme.titleTwo(context).copyWith(
                        color: AppColors.subtextColor,
                        fontSize: isMobile ? 11 : 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

        Widget toggleButtons = Obx(
              () => Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    controller.isEmployeesTab.value = true;
                    controller.isDetailView.value = false;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: controller.isEmployeesTab.value ? AppColors.primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Employees',
                      style: controller.isEmployeesTab.value
                          ? TTextTheme.titleRegular12White(context).copyWith(fontWeight: FontWeight.w600)
                          : TTextTheme.titleFour(context),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.isEmployeesTab.value = false;
                    controller.isDetailView.value = false;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: !controller.isEmployeesTab.value ? AppColors.primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Team',
                      style: !controller.isEmployeesTab.value
                          ? TTextTheme.titleRegular12White(context).copyWith(fontWeight: FontWeight.w600)
                          : TTextTheme.titleFour(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              titleSection,
              const SizedBox(height: 12),
              toggleButtons,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: titleSection),
            const SizedBox(width: 16),
            toggleButtons,
          ],
        );
      },
    );
  }

   // Filter Container
  Widget _buildFilterContainer(BuildContext context, VendorApplicationTrackingController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 650;

        Widget datePickerWidget = Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => controller.navigateDate(false),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.chevron_left, size: 20, color: AppColors.textGrey),
                ),
              ),
              InkWell(
                onTap: () => _openDatePickerDialog(context, controller),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Obx(
                        () => Text(
                      controller.formattedDateText,
                      style: TTextTheme.titleThree(context),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => controller.navigateDate(true),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.chevron_right, size: 20, color: AppColors.textGrey),
                ),
              ),
            ],
          ),
        );

        Widget filterTabsWidget = Obx(
              () => Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfScreenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: ['Day', 'Week', 'Last 4 Week'].map((filter) {
                bool isSelected = controller.selectedFilter.value == filter;
                return InkWell(
                  onTap: () => controller.selectedFilter.value = filter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      filter,
                      style: isSelected
                          ? TTextTheme.titleRegular12White(context).copyWith(fontWeight: FontWeight.w600)
                          : TTextTheme.titleFour(context),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: isMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: datePickerWidget),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: filterTabsWidget,
              ),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              datePickerWidget,
              filterTabsWidget,
            ],
          ),
        );
      },
    );
  }

  // Stat Cards
  Widget _buildStatCardsGrid(BuildContext context) {
    final List<Map<String, dynamic>> stats = [
      {
        'icon': IconString.idleTime,
        'iconColor': AppColors.primaryColor,
        'title': 'Total tracked time',
        'value': '6hrs 24m',
        'subText': '↑ 9.7% vs last day',
        'subColor': AppColors.approvedColor,
      },
      {
        'icon': IconString.averageActivity,
        'iconColor': AppColors.approvedColor,
        'title': 'Active Time',
        'value': '87%',
        'subText': '↑ 4.7% vs last day',
        'subColor': AppColors.approvedColor,
      },
      {
        'icon': IconString.idleTime,
        'iconColor': AppColors.rejectedColor,
        'title': 'Idle Time',
        'value': '45m',
        'subText': '5% of total time',
        'subColor': AppColors.subtextColor,
      },
      {
        'icon': IconString.applicationUsedIcon,
        'iconColor': AppColors.primaryColor,
        'title': 'Application used',
        'value': '6',
        'subText': 'Apps / work hours',
        'subColor': AppColors.subtextColor,
      },
      {
        'icon': IconString.averageActivity,
        'iconColor': AppColors.approvedColor,
        'title': 'Productive time',
        'value': '77%',
        'subText': '↑ 9.7% vs last day',
        'subColor': AppColors.approvedColor,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        int crossAxisCount = width > 1100 ? 5 : (width > 700 ? 3 : (width > 450 ? 2 : 1));

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 95,
          ),
          itemBuilder: (context, index) {
            final item = stats[index];
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        item['icon'],
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          item['iconColor'],
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item['title'],
                          style: TTextTheme.titleRegular11(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(item['value'], style: TTextTheme.h3Style(context)),
                  Text(
                    item['subText'],
                    style: TTextTheme.titleRegular11(context).copyWith(color: item['subColor']),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

   // Employee Activity Section
  Widget _buildEmployeeActivitySection(BuildContext context, VendorApplicationTrackingController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 600;

              Widget titleWidget = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Employee Activity',
                    style: TTextTheme.titleThree(context).copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Overall all employees Activity',
                    style: TTextTheme.titleTwo(context).copyWith(
                      color: AppColors.subtextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              );

              Widget searchWidget = SizedBox(
                width: isMobile ? double.infinity : 240,
                height: 38,
                child: SizedBox(
                  width: 240,
                  height: 38,
                  child: TextField(
                    cursorColor: AppColors.textColor,
                    onChanged: (val) => controller.searchQuery.value = val,
                    style: TTextTheme.titleTwo(context).copyWith(fontSize: 12),
                    decoration: InputDecoration(
                      hintText: 'Search by Employee',
                      hintStyle: TTextTheme.titleTwo(context).copyWith(
                        color: AppColors.subtextColor,
                        fontSize: 12,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        size: 18,
                        color: AppColors.textColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.crossBackground),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.crossBackground),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.crossBackground),
                      ),
                    ),
                  ),
                )
              );

              if (isMobile) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    titleWidget,
                    const SizedBox(height: 12),
                    searchWidget,
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: titleWidget),
                  const SizedBox(width: 16),
                  searchWidget,
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          LayoutBuilder(
            builder: (context, constraints) {
              double calculatedWidth = constraints.maxWidth;
              double minTableWidth = calculatedWidth > 750 ? calculatedWidth : 750;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: minTableWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfScreenColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Obx(
                                  () => SizedBox(
                                height: 24,
                                width: 24,
                                child: Checkbox(
                                  value: controller.isAllSelected.value,
                                  onChanged: (val) => controller.toggleAllSelection(val),
                                  activeColor: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Employees',
                                style: TTextTheme.titleTwo(context).copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Top Application',
                                style: TTextTheme.titleTwo(context).copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Usage Time',
                                style: TTextTheme.titleTwo(context).copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Usage',
                                style: TTextTheme.titleTwo(context).copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Application Used',
                                style: TTextTheme.titleTwo(context).copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Action',
                                style: TTextTheme.titleTwo(context).copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      Obx(
                            () => Column(
                          children: List.generate(
                            controller.employeesList.length,
                                (index) {
                              final emp = controller.employeesList[index];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    border: Border.all(color: AppColors.crossBackground),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Checkbox(
                                          value: emp.isSelected,
                                          onChanged: (val) => controller
                                              .toggleSingleSelection(index, val),
                                          activeColor: AppColors.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
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
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    emp.name,
                                                    style: TTextTheme.titleTwo(context)
                                                        .copyWith(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 13),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    emp.email,
                                                    style: TTextTheme.titleTwo(context)
                                                        .copyWith(
                                                        color: AppColors.subtextColor,
                                                        fontSize: 11),
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
                                          emp.topApp,
                                          style: TTextTheme.titleTwo(context)
                                              .copyWith(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          emp.usageTime,
                                          style: TTextTheme.titleTwo(context)
                                              .copyWith(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          emp.usage,
                                          style: TTextTheme.titleTwo(context)
                                              .copyWith(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '${emp.appUsed}',
                                          style: TTextTheme.titleTwo(context)
                                              .copyWith(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(
                                            Icons.remove_red_eye_outlined,
                                            size: 18,
                                            color: AppColors.tertiaryTextColor,
                                          ),
                                          onPressed: () =>
                                              controller.openEmployeeDetail(emp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back, size: 16),
                  style: IconButton.styleFrom(
                    side: const BorderSide(color: AppColors.borderColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              Obx(
                    () => Text(
                  'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
                  style: TTextTheme.titleTwo(context).copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: 32,
                height: 32,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  style: IconButton.styleFrom(
                    side: const BorderSide(color: AppColors.borderColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Employee Detail View
  Widget _buildEmployeeDetailView(BuildContext context, VendorApplicationTrackingController controller) {
    final emp = controller.selectedEmployee.value;

    return Container(
      padding: const EdgeInsets.all(16),
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
              InkWell(
                onTap: () => controller.closeEmployeeDetail(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundOfScreenColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.crossBackground),
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
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            emp?.name ?? 'Jack Wilson',
                            style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            emp?.email ?? 'jack@gmail.com',
                            style: TTextTheme.titleTwo(context).copyWith(color: AppColors.subtextColor, fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.approvedColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Online',
                  style: TTextTheme.titleTwo(context).copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.crossBackground),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Application used',
                  style: TTextTheme.titleThree(context).copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double width = constraints.maxWidth;
                    int crossAxisCount = width > 700 ? 2 : 1;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.detailedAppList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 58,
                      ),
                      itemBuilder: (context, index) {
                        final app = controller.detailedAppList[index];
                        String displayTime = controller.selectedFilter.value == 'Day'
                            ? app.dailyTime
                            : (controller.selectedFilter.value == 'Week' ? app.weeklyTime : app.last4WeekTime);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  app.appName,
                                  style: TTextTheme.titleTwo(context).copyWith(color: AppColors.subtextColor, fontSize: 12),
                                ),
                                Text(
                                  displayTime,
                                  style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: app.progress,
                                minHeight: 5,
                                backgroundColor: AppColors.backgroundOfScreenColor,
                                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              app.usagePercentage,
                              style: TTextTheme.titleTwo(context).copyWith(color: AppColors.subtextColor, fontSize: 10),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.crossBackground),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                      () => Text(
                    controller.selectedFilter.value == 'Day'
                        ? 'Daily tracking'
                        : (controller.selectedFilter.value == 'Week' ? 'Weekly Tracking' : 'Last 4 Week Tracking'),
                    style: TTextTheme.titleThree(context).copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double calculatedWidth = constraints.maxWidth;
                    double minTableWidth = calculatedWidth > 700 ? calculatedWidth : 700;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: minTableWidth,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundOfScreenColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Obx(
                                        () => SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                        value: controller.isAllAppsSelected.value,
                                        onChanged: (val) => controller.toggleAllAppsSelection(val),
                                        activeColor: AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Application',
                                      style: TTextTheme.titleTwo(context).copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: AppColors.textGrey,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.access_time, size: 14, color: AppColors.textGrey),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Total Time',
                                          style: TTextTheme.titleTwo(context).copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColors.textGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.access_time, size: 14, color: AppColors.textGrey),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Time by %',
                                          style: TTextTheme.titleTwo(context).copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColors.textGrey,
                                          ),
                                        ),
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
                                            AppColors.textGrey,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Comparison',
                                          style: TTextTheme.titleTwo(context).copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColors.textGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(
                                  () => Column(
                                children: List.generate(
                                  controller.detailedAppList.length,
                                      (index) {
                                    final app = controller.detailedAppList[index];
                                    String timeDisplay = controller.selectedFilter.value == 'Day'
                                        ? app.dailyTime
                                        : (controller.selectedFilter.value == 'Week'
                                        ? app.weeklyTime
                                        : app.last4WeekTime);

                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          border: Border.all(color: AppColors.crossBackground),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Obx(
                                                  () => SizedBox(
                                                height: 24,
                                                width: 24,
                                                child: Checkbox(
                                                  value: app.isSelected.value,
                                                  onChanged: (val) => controller.toggleAppSelection(index, val),
                                                  activeColor: AppColors.primaryColor,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                app.appName,
                                                style: TTextTheme.titleTwo(context).copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                timeDisplay,
                                                style: TTextTheme.titleTwo(context).copyWith(
                                                  color: AppColors.subtextColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                app.usagePercentage,
                                                style: TTextTheme.titleTwo(context).copyWith(
                                                  color: AppColors.subtextColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    app.isIncrease ? '↑' : '↓',
                                                    style: TextStyle(
                                                      color: app.isIncrease
                                                          ? AppColors.approvedColor
                                                          : AppColors.rejectedColor,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    app.comparison,
                                                    style: TTextTheme.titleTwo(context).copyWith(
                                                      color: app.isIncrease
                                                          ? AppColors.approvedColor
                                                          : AppColors.rejectedColor,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildTeamActivitySection(BuildContext context, VendorApplicationTrackingController controller) {
    return const Center(
      child: Text('Team Activity Section'),
    );
  }
}