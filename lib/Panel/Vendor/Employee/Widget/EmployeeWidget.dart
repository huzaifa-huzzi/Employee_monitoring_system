import 'package:employee_monitoring_system/Panel/Vendor/Employee/EmployeeController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class EmployeeWidget extends StatelessWidget {
  const EmployeeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeController controller = Get.find<EmployeeController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 650;
        bool isTablet =
            constraints.maxWidth >= 650 && constraints.maxWidth < 1000;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 12.0 : 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResponsiveHeader(context, isMobile),

              const SizedBox(height: 24),
              Obx(
                () => _buildResponsiveStatsCards(
                  context,
                  controller,
                  isMobile,
                  isTablet,
                ),
              ),

              const SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(isMobile ? 12 : 24),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.borderColor.withValues(alpha: 0.6),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextString.employeeTitle,
                      style: TTextTheme.titleOne(context).copyWith(
                        fontSize: isMobile ? 18 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildResponsiveTabsAndSearch(
                      context,
                      controller,
                      isMobile,
                    ),

                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, tableConstraints) {
                        double tableWidth = tableConstraints.maxWidth > 850
                            ? double.infinity
                            : 850;

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: tableWidth == double.infinity
                                ? tableConstraints.maxWidth
                                : tableWidth,
                            child: Obx(
                              () => _buildEmployeeList(context, controller),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                    _buildResponsivePaginationFooter(
                      context,
                      controller,
                      isMobile,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// ------------- Extra Widget -------------///

  // Header Section
  Widget _buildResponsiveHeader(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.employeeTitleTwo,
            style: TTextTheme.titleOne(
              context,
            ).copyWith(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            TextString.employeeSubtitle,
            style: TTextTheme.titleTwo(
              context,
            ).copyWith(color: AppColors.textGrey, fontSize: 12),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                context.go('/vendor/employeeInvitation');
              },
              icon: const Icon(
                Icons.add,
                size: 18,
                color: AppColors.whiteColor,
              ),
              label: Text(
                "Invite Employee",
                style: TTextTheme.btnTextOne(context).copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextString.employeeTitleTwo,
              style: TTextTheme.titleOne(
                context,
              ).copyWith(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              TextString.employeeSubtitle,
              style: TTextTheme.titleTwo(
                context,
              ).copyWith(color: AppColors.textGrey),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {
            context.go('/vendor/employeeInvitation');
          },
          icon: const Icon(Icons.add, size: 18, color: AppColors.whiteColor),
          label: Text(
            "Invite Employee",
            style: TTextTheme.btnTextOne(context).copyWith(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
        ),
      ],
    );
  }

  // Stat Card Section
  Widget _buildResponsiveStatsCards(
    BuildContext context,
    EmployeeController controller,
    bool isMobile,
    bool isTablet,
  ) {
    if (isMobile) {
      return Column(
        children: [
          _buildTotalEmployeesCard(context, controller.totalCount),
          const SizedBox(height: 12),
          _buildProgressCard(
            context,
            TextString.onlineEmployee,
            controller.onlineCount,
            AppColors.approvedColor,
          ),
          const SizedBox(height: 12),
          _buildProgressCard(
            context,
            TextString.offlineEmployee,
            controller.offlineCount,
            AppColors.rejectedColor,
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: _buildTotalEmployeesCard(context, controller.totalCount),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildProgressCard(
            context,
            TextString.onlineEmployee,
            controller.onlineCount,
            AppColors.approvedColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildProgressCard(
            context,
            TextString.offlineEmployee,
            controller.offlineCount,
            AppColors.rejectedColor,
          ),
        ),
      ],
    );
  }

  // Tabs and Search
  Widget _buildResponsiveTabsAndSearch(
    BuildContext context,
    EmployeeController controller,
    bool isMobile,
  ) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _buildCustomTabs(context, controller),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: TextField(
                    onChanged: (val) => controller.searchQuery.value = val,
                    style: TTextTheme.titleTwo(context),
                    decoration: InputDecoration(
                      hintText: TextString.searchDept,
                      hintStyle: TTextTheme.titleTwo(
                        context,
                      ).copyWith(color: AppColors.textGrey, fontSize: 12),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 18,
                        color: AppColors.textGrey,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildFilterPopupMenu(context, controller),
            ],
          ),
        ],
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 16,
            spacing: 16,
            children: [
              _buildCustomTabs(context, controller),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 260,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: TextField(
                      cursorColor: AppColors.textColor,
                      onChanged: (val) => controller.searchQuery.value = val,
                      style: TTextTheme.titleTwo(context),
                      decoration: InputDecoration(
                        hintText: TextString.searchDept,
                        hintStyle: TTextTheme.titleTwo(
                          context,
                        ).copyWith(color: AppColors.textGrey, fontSize: 13),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                          color: AppColors.textColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildFilterPopupMenu(context, controller),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Data Table list
  Widget _buildEmployeeList(
    BuildContext context,
    EmployeeController controller,
  ) {
    final employees = controller.filteredEmployees;

    return Column(
      key: const ValueKey("employee_list_column"),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.backgroundOfScreenColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: false,
                  onChanged: (val) => controller.toggleSelectAll(val),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: const BorderSide(color: AppColors.borderColor),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: Text(
                  TextString.employeeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TTextTheme.InsideAlreadyWrittenText(context),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  TextString.employeeRole,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TTextTheme.InsideAlreadyWrittenText(context),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                 TextString.employeeDept,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TTextTheme.InsideAlreadyWrittenText(context),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  TextString.employeeJoining,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TTextTheme.InsideAlreadyWrittenText(context),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  TextString.employeeStatus,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TTextTheme.InsideAlreadyWrittenText(context),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  TextString.employeeAction,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TTextTheme.InsideAlreadyWrittenText(context),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),
        if (employees.isEmpty)
          Padding(
            padding: EdgeInsets.all(40.0),
            child: Text(
              "No Employees Found",
              style: TTextTheme.titleFour(context),
            ),
          )
        else
          Column(
            children: List.generate(employees.length, (index) {
              final emp = employees[index];
              return Padding(
                key: ValueKey("emp_row_${emp.email}_$index"),
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: emp.isSelected,
                          activeColor: AppColors.primaryColor,
                          onChanged: (val) {
                            emp.isSelected = val ?? false;
                            controller.allEmployees.refresh();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          side: const BorderSide(color: AppColors.borderColor),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              IconString.employeePerson,
                              width: 18,
                              height: 18,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    emp.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TTextTheme.titleMedium13(context),
                                  ),
                                  Text(
                                    emp.email,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TTextTheme.InsideAlreadyWrittenText(
                                      context,
                                    ),
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
                          emp.role,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TTextTheme.titleFour(context),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          emp.department,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TTextTheme.titleFour(context),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          emp.joiningDate,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TTextTheme.titleFour(context),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: _buildStatusBadge(context, emp.status),
                      ),

                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            IconButton(
                              icon: SvgPicture.asset(
                                IconString.eyeIcon,
                                width: 18,
                                height: 18,
                              ),
                              onPressed: () {
                                context.go(
                                  Uri(
                                    path: '/vendor/employeeDetail',
                                    queryParameters: {'email': emp.email},
                                  ).toString(),
                                  extra: emp,
                                );
                              },
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(4),
                            ),
                            IconButton(
                              icon: SvgPicture.asset(
                                IconString.editEmployeeICon,
                                width: 18,
                                height: 18,
                              ),
                              onPressed: () {
                                context.go(
                                  Uri(
                                    path: '/vendor/editEmployee',
                                    queryParameters: {'email': emp.email},
                                  ).toString(),
                                  extra: emp,
                                );
                              },
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(4),
                            ),
                            IconButton(
                              icon: SvgPicture.asset(
                                IconString.deleteIcon,
                                width: 18,
                                height: 18,
                              ),
                              onPressed: () {
                                _showDeleteEmployeeDialog(context, controller);
                              },
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
      ],
    );
  }

  //  PAGINATION FOOTER
  Widget _buildResponsivePaginationFooter(
    BuildContext context,
    EmployeeController controller,
    bool isMobile,
  ) {
    if (isMobile) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                TextString.resultsPerPage,
                style: TTextTheme.titleRegular11(context),
              ),
              const SizedBox(width: 12),
              Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: controller.resultsPerPage.value,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: AppColors.textColor,
                    ),
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        controller.resultsPerPage.value = newValue;
                      }
                    },
                    items: <int>[5, 8, 10, 15, 20].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text("$value"),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildPrevBtn(context),
                const SizedBox(width: 8),
                _buildPageNumberButton(context, "1", isSelected: true),
                _buildPageNumberButton(context, "2"),
                _buildPageNumberButton(context, "3"),
                _buildPageNumberButton(context, "4"),
                const SizedBox(width: 8),
                _buildNextBtn(context),
              ],
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(TextString.resultsPerPage, style: TTextTheme.titleRegular11(context)),
            const SizedBox(width: 16),
            Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: controller.resultsPerPage.value,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: AppColors.textColor,
                  ),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      controller.resultsPerPage.value = newValue;
                    }
                  },
                  items: <int>[5, 8, 10, 15, 20].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text("$value"),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            _buildPrevBtn(context),
            const SizedBox(width: 8),
            _buildPageNumberButton(context, "1", isSelected: true),
            _buildPageNumberButton(context, "2"),
            _buildPageNumberButton(context, "3"),
            _buildPageNumberButton(context, "4"),
            const SizedBox(width: 8),
            _buildNextBtn(context),
          ],
        ),
      ],
    );
  }

  // Prev Button
  Widget _buildPrevBtn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfScreenColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.chevron_left_rounded,
            size: 16,
            color: AppColors.tertiaryTextColor,
          ),
          SizedBox(width: 4),
          Text(
            TextString.Prev,
            style: TTextTheme.titleRegular12(
              context,
            ).copyWith(color: AppColors.tertiaryTextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildNextBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Text(TextString.Next, style: TTextTheme.titleRegular12Grey12(context)),
          SizedBox(width: 4),
          Icon(
            Icons.chevron_right_rounded,
            size: 16,
            color: AppColors.textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildPageNumberButton(
    BuildContext context,
    String text, {
    bool isSelected = false,
  }) {
    return Container(
      width: 34,
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: isSelected
            ? TTextTheme.titleRegular12White(context)
            : TTextTheme.titleRegular12(
                context,
              ).copyWith(color: AppColors.textColor),
      ),
    );
  }

  // Filter Popmenu
  Widget _buildFilterPopupMenu(
    BuildContext context,
    EmployeeController controller,
  ) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: PopupMenuButton<String>(
          tooltip: '',
          elevation: 8,
          offset: const Offset(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: AppColors.whiteColor,
          onSelected: (String value) {
            controller.selectedDepartmentFilter.value = value;
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            _buildPopupItem(context, TextString.employeeName),
            _buildPopupItem(context, TextString.employeeRole),
            _buildPopupItem(context, TextString.employeeDept),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => Text(
                    controller.selectedDepartmentFilter.value,
                    style: TTextTheme.titleTwo(context).copyWith(fontSize: 13),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: AppColors.textColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(BuildContext context, String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 40,
      child: Text(
        value,
        style: TTextTheme.titleOne(
          context,
        ).copyWith(fontSize: 13, color: AppColors.tertiaryTextColor),
      ),
    );
  }

  // Custom tabs
  Widget _buildCustomTabs(BuildContext context, EmployeeController controller) {
    final tabs = ["All", "Online", "Offline", "Invited"];

    return Obx(
      () => Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfScreenColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(tabs.length, (index) {
            bool isSelected = controller.selectedTabIndex.value == index;
            return GestureDetector(
              onTap: () => controller.changeTab(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tabs[index],
                  style: TTextTheme.titleTwo(context).copyWith(
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? AppColors.whiteColor
                        : AppColors.tertiaryTextColor,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // status Badge
  Widget _buildStatusBadge(BuildContext context, EmployeeStatus status) {
    String text;
    Color bgColor;

    switch (status) {
      case EmployeeStatus.online:
        text = "Online";
        bgColor = AppColors.approvedColor;
        break;
      case EmployeeStatus.offline:
        text = "Offline";
        bgColor = AppColors.rejectedColor;
        break;
      case EmployeeStatus.invited:
        text = "Invited";
        bgColor = AppColors.pendingColor;
        break;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: TTextTheme.titleRegular12White(context)),
      ),
    );
  }

  // Total Employee
  Widget _buildTotalEmployeesCard(BuildContext context, int count) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                IconString.totalEmployeeIcon,
                width: 18,
                height: 18,
              ),
              SizedBox(width: 8),
              Text(
                TextString.employeeTotal,
                style: TTextTheme.titleRegular12Grey12(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text("$count", style: TTextTheme.h2Style(context)),
          const SizedBox(height: 4),
          Text(
           TextString.employeeTotalSubtitle,
            style: TTextTheme.titleRegular12Grey12(context),
          ),
        ],
      ),
    );
  }

  // Progress Card
  Widget _buildProgressCard(
    BuildContext context,
    String title,
    int count,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(title, style: TTextTheme.titleRegular12Grey12(context)),
            ],
          ),
          const SizedBox(height: 8),
          Text("$count", style: TTextTheme.h2Style(context)),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: count / 20,
            backgroundColor: AppColors.crossBackground,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  /// Delete  Dialogs
  void _showDeleteEmployeeDialog(
    BuildContext context,
    EmployeeController controller,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding:  EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Container(
            width: 440,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Text("🤨", style: TextStyle(fontSize: 22)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           TextString.DialogOne,
                            style: TTextTheme.h3Style(context),
                          ),
                          SizedBox(height: 4),
                          Text(
                            TextString.DialogTwo,
                            style: TTextTheme.selectProjectText(context),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.crossBackground,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 14,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: TTextTheme.CancelBtn(context),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.rejectedColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showDeleteSuccessDialog(context);
                        },
                        child: Text(
                          "Delete",
                          style: TTextTheme.btnTextOne(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _showDeleteSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Container(
            width: 440,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.emojiBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Text("👍", style: TextStyle(fontSize: 22)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       TextString.DialogThree,
                        style: TTextTheme.h3Style(context),
                      ),
                      SizedBox(height: 4),
                      Text(
                        TextString.DialogFour,
                        style: TTextTheme.selectProjectText(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.borderColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
