import 'package:employee_monitoring_system/Panel/Vendor/VendorUrlTracking/ReusableWidget/PrimaryBtnOfVendorUrlTracking.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorUrlTracking/VendorUrlTrackingController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:get/get.dart';



class VendorTeamUrlTrackingWidget extends StatelessWidget {
  const VendorTeamUrlTrackingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VendorUrlController>();
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Obx(() {
      if (controller.isDetailView.value) {
        return _EmployeeDetailViewWidget(controller: controller, isMobile: isMobile);
      } else {
        return _TeamActivitySectionWidget(controller: controller, isMobile: isMobile);
      }
    });
  }
}
 /// --------- Extra Classes ----------///

 // Team Activity Section
class _TeamActivitySectionWidget extends StatelessWidget {
  final VendorUrlController controller;
  final bool isMobile;

  const _TeamActivitySectionWidget({
    required this.controller,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isTeamEmpView.value) {
        return _TeamEmployeesTableWidget(controller: controller, isMobile: isMobile);
      } else {
        return _TeamsTableWidget(controller: controller, isMobile: isMobile);
      }
    });
  }
}

 // Team Table Widget
class _TeamsTableWidget extends StatelessWidget {
  final VendorUrlController controller;
  final bool isMobile;

  const _TeamsTableWidget({
    required this.controller,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Team Activity',
            style: TTextTheme.h3Style(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Overall Team Activity',
            style: TTextTheme.h4Style(context).copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.subtextColor,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth < 800 ? 800 : constraints.maxWidth;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 8),
                      Obx(() => Column(
                        children: List.generate(
                          controller.teamsList.length,
                              (index) => _buildRow(context, controller.teamsList[index], index),
                        ),
                      )),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          _TablePaginationWidget(controller: controller),
        ],
      ),
    );
  }
   ///-------- Extra Widget ---------///

  // header
  Widget _buildHeader(BuildContext context) {
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
              child: Obx(() => _CustomTableCheckbox(
                value: controller.isAllTeamsSelected,
                onTap: () => controller.toggleSelectAllTeams(),
              )),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Team Name',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Members',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Top Url',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Usage Time',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Usage',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Application Used',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
            ),
          ),
          SizedBox(
            width: 85,
            child: Text(
              'Action',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Table Row
  Widget _buildRow(BuildContext context, Map<String, dynamic> data, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Center(
              child: Obx(() => _CustomTableCheckbox(
                value: controller.teamsList[index]['isSelected'] ?? false,
                onTap: () => controller.toggleSelectTeamRow(index),
              )),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              data['teamName'] ?? '',
              style: TTextTheme.titleEight(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${data['members'] ?? ''}',
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              data['topUrl'] ?? '',
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              data['usageTime'] ?? '',
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              data['usage'] ?? '',
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${data['appUsed'] ?? ''}',
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: PrimaryBtnOfVendorUrlTracking(
              text: 'View Emp',
              height: 40,
              width: 85,
              borderRadius: BorderRadius.circular(6),
              onTap: () => controller.showTeamEmployees(data),
            ),
          ),
        ],
      ),
    );
  }
}

 // Team Employees Table Class
class _TeamEmployeesTableWidget extends StatelessWidget {
  final VendorUrlController controller;
  final bool isMobile;

  const _TeamEmployeesTableWidget({
    required this.controller,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
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
                    'Team Employees Activity',
                    style: TTextTheme.h3Style(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Overall all employees Activity',
                    style: TTextTheme.h4Style(context).copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subtextColor,
                    ),
                  ),
                ],
              ),
              if (!isMobile) _TableSearchBar(controller: controller),
            ],
          ),
          if (isMobile) ...[
            const SizedBox(height: 12),
            _TableSearchBar(controller: controller),
          ],
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth < 800 ? 800 : constraints.maxWidth;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 8),
                      Obx(() => Column(
                        children: List.generate(
                          controller.teamEmployeesList.length,
                              (index) => _buildRow(context, controller.teamEmployeesList[index], index),
                        ),
                      )),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          _TablePaginationWidget(controller: controller),
        ],
      ),
    );
  }

  /// ---------- Extra Widget -----------///

  // Header Row
  Widget _buildHeader(BuildContext context) {
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
              child: Obx(() => _CustomTableCheckbox(
                value: controller.isAllTeamEmpSelected,
                onTap: () => controller.toggleSelectAllTeamEmp(),
              )),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Employees',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Top Url',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Usage Time',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Usage',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Url Used',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              'Action',
              style: TTextTheme.titleSeven(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.subtextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Data Row
  Widget _buildRow(BuildContext context, Map<String, dynamic> data, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Center(
              child: Obx(() => _CustomTableCheckbox(
                value: controller.teamEmployeesList[index]['isSelected'] ?? false,
                onTap: () => controller.toggleSelectTeamEmpRow(index),
              )),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name'] ?? '',
                        style: TTextTheme.titleEight(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data['email'] ?? '',
                        style: TTextTheme.titleFour(context).copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subtextColor,
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
              data['topUrl'] ?? '',
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              data['usageTime'] ?? '',
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              data['usage'] ?? '',
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${data['urlUsed'] ?? ''}',
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ),
          SizedBox(
            width: 50,
            child: Center(
              child: InkWell(
                onTap: () => controller.showEmployeeDetail(data),
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.remove_red_eye_outlined,
                    size: 18,
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 // Employee Detail Widget class
class _EmployeeDetailViewWidget extends StatelessWidget {
  final VendorUrlController controller;
  final bool isMobile;

  const _EmployeeDetailViewWidget({
    required this.controller,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.backgroundOfScreenColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
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
                        Text(emp['name'] ?? 'Employee Name', style: TTextTheme.titleEight(context)),
                        Text(emp['email'] ?? 'employee@gmail.com', style: TTextTheme.titleFour(context)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.approvedColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Online',
                  style: TextStyle(color: AppColors.approvedColor, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Top Url Browse', style: TTextTheme.h3Style(context)),
                const SizedBox(height: 16),
                _TopUrlBrowseChartWidget(controller: controller),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  controller.selectedTimeFilter.value == 'Day'
                      ? 'Daily Tracking'
                      : controller.selectedTimeFilter.value == 'Week'
                      ? 'Weekly Tracking'
                      : 'Last 4 Week Tracking',
                  style: TTextTheme.h3Style(context),
                )),
                const SizedBox(height: 16),
                _DetailTrackingTableWidget(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

 /// ---------- Helper Widgets classes ----------///

// Custom Checkbox Component
class _CustomTableCheckbox extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;

  const _CustomTableCheckbox({
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: value ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: value ? AppColors.primaryColor : AppColors.borderColor,
            width: 1.5,
          ),
        ),
        child: value
            ? const Icon(Icons.check, size: 13, color: AppColors.whiteColor)
            : null,
      ),
    );
  }
}

// Table Pagination Controls Widget
class _TablePaginationWidget extends StatelessWidget {
  final VendorUrlController controller;

  const _TablePaginationWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => controller.previousPage(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: AppColors.textColor),
          ),
        ),
        Obx(
              () => Text(
            'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
            style: TTextTheme.titleTwo(context).copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
        ),
        InkWell(
          onTap: () => controller.nextPage(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_forward, size: 16, color: AppColors.textColor),
          ),
        ),
      ],
    );
  }
}

// Table Search Bar Component
class _TableSearchBar extends StatelessWidget {
  final VendorUrlController controller;

  const _TableSearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 38,
      child: TextField(
        cursorColor: AppColors.textColor,
        style: TTextTheme.titleTwo(context).copyWith(fontSize: 12),
        decoration: InputDecoration(
          hintText: 'Search employee...',
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
            borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.6)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}

// Top URL Browsing
class _TopUrlBrowseChartWidget extends StatelessWidget {
  final VendorUrlController controller;

  const _TopUrlBrowseChartWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    final sampleUrls = [
      {'url': 'https://google.com', 'time': '1h 45m', 'progress': 0.85, 'color': AppColors.primaryColor},
      {'url': 'https://github.com', 'time': '1h 10m', 'progress': 0.65, 'color': AppColors.primaryColor},
      {'url': 'https://stackoverflow.com', 'time': '45m', 'progress': 0.45, 'color': AppColors.pendingColor},
      {'url': 'https://figma.com', 'time': '30m', 'progress': 0.30, 'color': AppColors.graphColor},
      {'url': 'https://youtube.com', 'time': '15m', 'progress': 0.15, 'color': AppColors.rejectedColor},
    ];

    return Column(
      children: sampleUrls.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item['url'] as String,
                      style: TTextTheme.titleSix(context).copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    item['time'] as String,
                    style: TTextTheme.titleFour(context).copyWith(
                      fontSize: 12,
                      color: AppColors.subtextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: item['progress'] as double,
                  minHeight: 8,
                  backgroundColor: AppColors.backgroundOfScreenColor,
                  valueColor: AlwaysStoppedAnimation<Color>(item['color'] as Color),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// Detail Tracking
class _DetailTrackingTableWidget extends StatelessWidget {
  final VendorUrlController controller;

  const _DetailTrackingTableWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    final records = [
      {'domain': 'google.com', 'category': 'Search Engine', 'activeTime': '1h 20m', 'idleTime': '5m', 'totalTime': '1h 25m', 'status': 'Productive'},
      {'domain': 'github.com', 'category': 'Development', 'activeTime': '45m', 'idleTime': '2m', 'totalTime': '47m', 'status': 'Productive'},
      {'domain': 'youtube.com', 'category': 'Entertainment', 'activeTime': '15m', 'idleTime': '0m', 'totalTime': '15m', 'status': 'Unproductive'},
      {'domain': 'linkedin.com', 'category': 'Social Media', 'activeTime': '10m', 'idleTime': '1m', 'totalTime': '11m', 'status': 'Neutral'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 750,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.backgroundOfScreenColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text('URL / Domain', style: TTextTheme.titleSeven(context))),
                  Expanded(flex: 2, child: Text('Category', style: TTextTheme.titleSeven(context))),
                  Expanded(flex: 2, child: Text('Active Time', style: TTextTheme.titleSeven(context))),
                  Expanded(flex: 2, child: Text('Idle Time', style: TTextTheme.titleSeven(context))),
                  Expanded(flex: 2, child: Text('Total Time', style: TTextTheme.titleSeven(context))),
                  Expanded(flex: 2, child: Text('Productivity', style: TTextTheme.titleSeven(context))),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ...records.map((data) {
              bool isProductive = data['status'] == 'Productive';
              bool isUnproductive = data['status'] == 'Unproductive';
              Color badgeColor = isProductive
                  ? AppColors.approvedColor
                  : isUnproductive
                  ? AppColors.rejectedColor
                  : AppColors.subtextColor;

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text(data['domain']!, style: TTextTheme.titleEight(context))),
                    Expanded(flex: 2, child: Text(data['category']!, style: TTextTheme.titleSix(context))),
                    Expanded(flex: 2, child: Text(data['activeTime']!, style: TTextTheme.titleSix(context))),
                    Expanded(flex: 2, child: Text(data['idleTime']!, style: TTextTheme.titleSix(context))),
                    Expanded(flex: 2, child: Text(data['totalTime']!, style: TTextTheme.titleSix(context))),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          data['status']!,
                          style: TTextTheme.titleFour(context).copyWith(
                            color: badgeColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}