import 'package:employee_monitoring_system/Panel/Admin/Companies/CompaniesController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:go_router/go_router.dart';


class CompaniesWidget extends StatelessWidget {
  const CompaniesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompaniesController());

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.adminCompanyTitle, style: TTextTheme.h1Style(context)),
              const SizedBox(height: 4),
              Text(
               TextString.adminCompanySubtitle,
                style: TTextTheme.titleSix(context),
              ),
              const SizedBox(height: 20),
              _buildKpiSection(context, controller),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppColors.borderColor.withValues(alpha: 0.6)),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        bool isSmallMobile = constraints.maxWidth < 420;

                        if (isSmallMobile) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(TextString.adminCompanyAllTitle, style: TTextTheme.h3Style(context)),
                                  const SizedBox(height: 2),
                                  Text(
                                   TextString.adminCompanyAllSubtitle,
                                    style: TTextTheme.titleFour(context),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.go('/Admin/companies-add');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text("Add Company", style: TTextTheme.btnTextOne(context)),
                                ),
                              ),
                            ],
                          );
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    TextString.adminCompanyAllTitle,
                                    style: TTextTheme.h3Style(context),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    TextString.adminCompanyAllSubtitle,
                                    style: TTextTheme.titleFour(context),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                context.go('/Admin/companies-add');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text("Add Company", style: TTextTheme.btnTextOne(context)),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDynamicTabsAndDropdownRow(context, controller),
                    const SizedBox(height: 16),
                    _buildSearchAndFilterRow(context, controller),
                    const SizedBox(height: 20),
                    _buildCompaniesTable(context, controller),
                    const SizedBox(height: 20),
                    _buildPaginationFooter(context, controller),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- Extra Widget ------ ///

  // Kpi Card Section
  Widget _buildKpiSection(BuildContext context, CompaniesController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 1000;
        bool isTablet =
            constraints.maxWidth > 550 && constraints.maxWidth <= 1000;

        List<Widget> cards = [
          _kpiCard(context,
              svgPath: IconString.companyTable,
              iconColor: AppColors.primaryColor,
              title: TextString.adminCompanyKpiOne ,
              count:TextString.adminCompanyKpiTwo ,
              subText:TextString.adminCompanyKpiThree ),
          _kpiCard(context,
              svgPath: IconString.activeCompany,
              iconColor: AppColors.approvedColor,
              title:TextString.adminCompanyKpiFour ,
              count:TextString.adminCompanyKpiFive ,
              subText:TextString.adminCompanyKpiSix ),
          _kpiCard(context,
              svgPath: IconString.suspendedCompany,
              iconColor: AppColors.rejectedColor,
              title: TextString.adminCompanyKpiSeven,
              count: TextString.adminCompanyKpiEight ,
              subText:TextString.adminCompanyKpiNine ),
          _kpiCard(context,
              svgPath: IconString.newCompany,
              iconColor: AppColors.textColor,
              title:TextString.adminCompanyKpiTen ,
              count:TextString.adminCompanyKpiEleven ,
              subText:TextString.adminCompanyKpiTwelve ),
        ];

        if (isDesktop) {
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
        } else if (isTablet) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: cards[0]),
                  const SizedBox(width: 12),
                  Expanded(child: cards[1]),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: cards[2]),
                  const SizedBox(width: 12),
                  Expanded(child: cards[3]),
                ],
              ),
            ],
          );
        } else {
          return Column(
            children: cards
                .map((card) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: card,
            ))
                .toList(),
          );
        }
      },
    );
  }

  Widget _kpiCard(
      BuildContext context, {
        required String svgPath,
        required Color iconColor,
        required String title,
        required String count,
        required String subText,
      }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                svgPath,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  iconColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
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
          Text(
            count,
            style: TTextTheme.h1Style(context),
          ),
          const SizedBox(height: 4),
          Text(
            subText,
            style: TTextTheme.titleRegular11(context),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Dropdown Container
  Widget _buildDynamicTabsAndDropdownRow(
      BuildContext context, CompaniesController controller) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Obx(() {
        final tabs = controller.currentCategoryTabs;

        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.backgroundOfScreenColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.4)),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: tabs.map((tab) {
                  return _tabButton(
                    context,
                    controller,
                    tab,
                    controller.getTabCount(tab),
                  );
                }).toList(),
              ),
              _buildCustomPopupMenu(
                context: context,
                currentValue: controller.selectedFilterCategory,
                isOpen: controller.isCategoryDropdownOpen,
                options: ['Email Status', 'Account Status', 'Plan Status'],
                onSelected: (val) => controller.changeFilterCategory(val),
                minWidthWeb: 120,
              ),
            ],
          ),
        );
      }),
    );
  }

  // Tab Button
  Widget _tabButton(
      BuildContext context,
      CompaniesController controller,
      String label,
      int count,
      ) {
    return Obx(() {
      bool isSelected = controller.activeTab.value == label;

      return InkWell(
        onTap: () => controller.activeTab.value = label,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: isSelected
                    ? TTextTheme.TabsSelectedText(context)
                    .copyWith(fontSize: 13)
                    : TTextTheme.titleFour(context).copyWith(fontSize: 13),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.whiteColor
                      : AppColors.crossBackground,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "$count",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // Search Bar
  Widget _buildSearchAndFilterRow(
      BuildContext context, CompaniesController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment:
          isMobile ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
          children: [
            if (!isMobile) const Spacer(),
            SizedBox(
              width: isMobile ? double.infinity : 240,
              height: 38,
              child: TextField(
                cursorColor: AppColors.textColor,
                onChanged: (val) => controller.searchQuery.value = val,
                style: TTextTheme.titleFour(context)
                    .copyWith(color: AppColors.textColor),
                decoration: InputDecoration(
                  hintText: TextString.adminCompanyFieldText,
                  hintStyle:
                  TTextTheme.titleFour(context).copyWith(fontSize: 12),
                  prefixIcon: const Icon(Icons.search,
                      size: 18, color: AppColors.tertiaryTextColor),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: AppColors.borderColor, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor, width: 1.2),
                  ),
                ),
              ),
            ),
            SizedBox(width: isMobile ? 0 : 8, height: isMobile ? 8 : 0),
            _buildCustomPopupMenu(
              context: context,
              currentValue: controller.searchFilterField,
              isOpen: controller.isSearchDropdownOpen,
              options: ['Company Name', 'Owner Name', 'Email'],
              onSelected: (val) => controller.searchFilterField.value = val,
              minWidthWeb: 140,
            ),
          ],
        );
      },
    );
  }

  // Dropdown Menu
  Widget _buildCustomPopupMenu({
    required BuildContext context,
    required RxString currentValue,
    required RxBool isOpen,
    required List<String> options,
    required Function(String) onSelected,
    required double minWidthWeb,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return PopupMenuButton<String>(
      constraints: BoxConstraints(
        minWidth: isMobile ? screenWidth - 60 : minWidthWeb,
        maxWidth: isMobile ? screenWidth - 60 : minWidthWeb + 40,
        maxHeight: 300,
      ),
      offset: const Offset(0, 36),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppColors.whiteColor,
      elevation: 3,
      onOpened: () => isOpen.value = true,
      onCanceled: () => isOpen.value = false,
      onSelected: (String val) {
        currentValue.value = val;
        onSelected(val);
        isOpen.value = false;
      },
      child: Obx(() => Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentValue.value,
              style: TTextTheme.titleFour(context).copyWith(
                color: AppColors.textColor,
                fontSize: 12.5,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              isOpen.value
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: AppColors.tertiaryTextColor,
              size: 16,
            ),
          ],
        ),
      )),
      itemBuilder: (BuildContext context) {
        return options.map((String opt) {
          final bool isSelected = opt == currentValue.value;

          return PopupMenuItem<String>(
            value: opt,
            height: 36,
            child: Text(
              opt,
              style: TextStyle(
                color: AppColors.subtextColor,
                fontWeight: isSelected ? FontWeight.w400 : FontWeight.w400,
                fontSize: 12.5,
              ),
            ),
          );
        }).toList();
      },
    );
  }

  Widget _buildCompaniesTable(
      BuildContext context, CompaniesController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double tableWidth = math.max(constraints.maxWidth, 1250.0);

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: tableWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.borderColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.borderColor.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Obx(() => Checkbox(
                          value: controller.isAllSelected.value,
                          activeColor: AppColors.primaryColor,
                          side: const BorderSide(
                            color: AppColors.borderColor,
                            width: 1.5,
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (val) => controller.toggleSelectAll(val),
                        )),
                      ),
                      Expanded(
                          flex: 17,
                          child: Text(TextString.adminCompanyName, style: TTextTheme.titleTwo(context))),
                      Expanded(
                          flex: 13,
                          child: Text(TextString.adminOwnerName, style: TTextTheme.titleTwo(context))),
                      Expanded(
                          flex: 21,
                          child: Text(TextString.adminEmail, style: TTextTheme.titleTwo(context))),
                      Expanded(
                          flex: 12,
                          child: Text(TextString.adminEmailStatus, style: TTextTheme.titleTwo(context))),
                      Expanded(
                          flex: 13,
                          child: Text(TextString.adminCompanyAccountStatus, style: TTextTheme.titleTwo(context))),
                      Expanded(
                          flex: 11,
                          child: Text(TextString.adminCompanySubscription, style: TTextTheme.titleTwo(context))),
                      Expanded(
                          flex: 14,
                          child: Text(TextString.adminCompanySubscriptionStatus, style: TTextTheme.titleTwo(context))),
                      Expanded(
                          flex: 12,
                          child: Text(TextString.adminCompanyJoining, style: TTextTheme.titleTwo(context))),
                      Expanded(
                          flex: 8,
                          child: Text(TextString.adminCompanyEmployee, style: TTextTheme.titleTwo(context))),
                       SizedBox(
                          width: 105,
                          child: Text(TextString.adminCompanyAction, style: TTextTheme.titleTwo(context))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  final list = controller.filteredCompanies;

                  return Column(
                    children: list.map((company) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.borderColor.withValues(alpha: 0.6)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.015),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Checkbox(
                                value: company.isSelected,
                                activeColor: AppColors.primaryColor,
                                side: const BorderSide(
                                  color: AppColors.borderColor,
                                  width: 1.5,
                                ),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                onChanged: (val) => controller.toggleItemSelection(company, val),
                              ),
                            ),
                            Expanded(
                              flex: 17,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    IconString.companyTable,
                                    width: 18,
                                    height: 18,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.primaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      company.name,
                                      style: TTextTheme.titleFive(context)
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 13,
                              child: Text(
                                company.ownerName,
                                style: TTextTheme.titleFour(context),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 21,
                              child: Text(
                                company.email,
                                style: TTextTheme.titleFour(context),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Text(
                                company.emailStatus,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w400,
                                  color: company.emailStatus == 'Verified'
                                      ? AppColors.approvedColor
                                      : AppColors.rejectedColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 13,
                              child: Text(
                                company.accountStatus,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w400,
                                  color: _getAccountStatusColor(
                                      company.accountStatus),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 11,
                              child: Text(
                                company.subscription,
                                style: TTextTheme.titleFour(context),
                              ),
                            ),
                            Expanded(
                              flex: 14,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getSubscriptionStatusColor(
                                        company.subscriptionStatus),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    company.subscriptionStatus,
                                    style: TTextTheme.SubscriptionStatusText(context),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: Text(
                                company.joiningDate,
                                style: TTextTheme.titleFour(context),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Text(
                                "${company.employeesCount}",
                                style: TTextTheme.titleFour(context),
                              ),
                            ),
                            SizedBox(
                              width: 105,
                              child: Row(
                                children: [
                                  _actionIconButton(
                                    svgPath: IconString.eyeIcon,
                                    backgroundColor: AppColors.primaryColor,
                                    iconColor: AppColors.whiteColor,
                                    onTap: () {
                                      context.go(
                                        '/Admin/companies/view/${company.id}',
                                        extra: company,
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 6),
                                  _actionIconButton(
                                    svgPath: IconString.blockIcon,
                                    backgroundColor: Colors.transparent,
                                    iconColor: AppColors.textColor,
                                    onTap: () {
                                      _showSuspendReasonDialog(context);
                                    },
                                  ),
                                  const SizedBox(width: 6),
                                  _actionIconButton(
                                    svgPath: IconString.deleteIcon,
                                    backgroundColor: AppColors.primaryColor,
                                    iconColor: AppColors.whiteColor,
                                    onTap: () {
                                      _showDeleteConfirmationDialog(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionIconButton({
    required String svgPath,
    required VoidCallback onTap,
    Color? backgroundColor,
    Color iconColor = AppColors.whiteColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: SvgPicture.asset(
          svgPath,
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(
            iconColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

   // Pagination Footer
  Widget _buildPaginationFooter(
      BuildContext context, CompaniesController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:
          isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(TextString.adminResultPErPAge, style: TTextTheme.titleFour(context)),
                const SizedBox(width: 8),
                Obx(() => _buildCustomPopupMenu(
                  context: context,
                  currentValue: controller.resultsPerPage.value.toString().obs,
                  isOpen: controller.isResultsPerPageDropdownOpen,
                  options: ['5', '10', '20', '50'],
                  onSelected: (val) =>
                  controller.resultsPerPage.value = int.parse(val),
                  minWidthWeb: 60,
                )),
              ],
            ),
            SizedBox(height: isMobile ? 12 : 0),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              runSpacing: 8,
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundOfScreenColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.chevron_left,
                            size: 16, color: AppColors.tertiaryTextColor),
                        const SizedBox(width: 2),
                        Text(
                          TextString.adminCompanyPrev,
                          style: TTextTheme.titleFour(context).copyWith(
                              fontSize: 12, color: AppColors.tertiaryTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _pageNumberButton(context,"1", isSelected: true),
                    _pageNumberButton(context,"2"),
                    _pageNumberButton(context,"3"),
                    _pageNumberButton(context,"4"),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          TextString.adminCompanyNext,
                          style: TTextTheme.titleFour(context).copyWith(
                              fontSize: 12, color: AppColors.textColor),
                        ),
                        const SizedBox(width: 2),
                        Icon(Icons.chevron_right,
                            size: 16, color: AppColors.textColor),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _pageNumberButton(BuildContext context, String number, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        number,
        style: TTextTheme.PageNumber(context).copyWith(
          color: isSelected ? AppColors.whiteColor : AppColors.textColor,
        ),
      ),
    );
  }

  // HELPER COLOR METHODS
  Color _getAccountStatusColor(String status) {
    switch (status) {
      case 'Active':
        return AppColors.approvedColor;
      case 'Pending':
        return AppColors.pendingColor;
      case 'Inactive':
      case 'Suspended':
        return AppColors.rejectedColor;
      default:
        return AppColors.textColor;
    }
  }
  Color _getSubscriptionStatusColor(String status) {
    switch (status) {
      case 'Subscribed':
        return AppColors.approvedColor;
      case 'Demo':
        return AppColors.subtextColor;
      case 'Overdue':
        return AppColors.rejectedColor;
      case 'Cancelled':
        return AppColors.tertiaryTextColor;
      default:
        return AppColors.primaryColor;
    }
  }

    /// Delete Dialogs
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: AppColors.whiteColor,
          child: Container(
            width: 440,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.borderColor.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.tertiaryTextColor),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("🤨", style: TextStyle(fontSize: 26)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextString.adminCompanyDialogOne,
                            style: TTextTheme.h3Style(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            TextString.adminCompanyDialogTwo,
                            style: TTextTheme.titleFour(context).copyWith(
                              color: AppColors.tertiaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          side:  BorderSide(color: AppColors.rejectedColor , width: 1),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:  Text(
                          "Cancel",
                          style: TTextTheme.cancelBtnText(context)
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showSuccessDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.rejectedColor,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:  Text(
                          "Delete",
                          style: TTextTheme.whiteColorBtn(context)
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
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: AppColors.whiteColor,
          child: Container(
            width: 440,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.borderColor.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.tertiaryTextColor),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("👍", style: TextStyle(fontSize: 26)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextString.adminCompanyDialogThree,
                            style: TTextTheme.h3Style(context).copyWith(
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            TextString.adminCompanyDialogFour,
                            style: TTextTheme.titleFour(context).copyWith(
                              color: AppColors.tertiaryTextColor,
                            ),
                          ),
                        ],
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

   /// Suspend Dialog
  void _showSuspendReasonDialog(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: AppColors.whiteColor,
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.block,
                  color: AppColors.rejectedColor,
                  size: 26,
                ),
                const SizedBox(height: 12),
                Text(
                  TextString.adminCompanySuspendDialogOne,
                  style: TTextTheme.h3Style(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    TextString.adminCompanySuspendDialogReason,
                    style: TTextTheme.titleTwo(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  cursorColor: AppColors.textColor,
                  controller: reasonController,
                  maxLines: 3,
                  style: TTextTheme.titleFour(context),
                  decoration: InputDecoration(
                    hintText: TextString.adminCompanySuspendFieldText ,
                    hintStyle: TTextTheme.titleFour(context).copyWith(
                      color: AppColors.tertiaryTextColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: AppColors.borderColor.withValues(alpha: 0.8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.rejectedColor, width: 1),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:  Text(
                          "Cancel",
                          style: TTextTheme.cancelBtnText(context)
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showSuspendConfirmDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.rejectedColor,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:  Text(
                          "Suspend",
                          style: TTextTheme.whiteColorBtn(context)
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
  void _showSuspendConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: AppColors.whiteColor,
          child: Container(
            width: 440,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.borderColor.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.tertiaryTextColor),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("🤨", style: TextStyle(fontSize: 26)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextString.adminSuspendCompanyDialogOne,
                            style: TTextTheme.h3Style(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            TextString.adminSuspendCompanyDialogTwo,
                            style: TTextTheme.titleFour(context).copyWith(
                              color: AppColors.tertiaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showSuspendSuccessDialog(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.rejectedColor, width: 1),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:  Text(
                          "Save",
                          style: TTextTheme.cancelBtnText(context)
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.rejectedColor,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:  Text(
                          "Cancel",
                          style: TTextTheme.whiteColorBtn(context)
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
  void _showSuspendSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: AppColors.whiteColor,
          child: Container(
            width: 440,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.borderColor.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.tertiaryTextColor),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("👍", style: TextStyle(fontSize: 26)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextString.adminSuspendCompanyDialogThree,
                            style: TTextTheme.h3Style(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            TextString.adminSuspendCompanyDialogFour,
                            style: TTextTheme.titleFour(context).copyWith(
                              color: AppColors.tertiaryTextColor,
                            ),
                          ),
                        ],
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
}
