import 'package:employee_monitoring_system/Panel/Admin/Subscription/SubscriptionController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 768;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             TextString.adminSubscriptionTitle,
              style: TTextTheme.h2Style(context).copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              TextString.adminSubscriptionSubtitle,
              style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
            ),
            const SizedBox(height: 20),
            _buildStatCardsRow(context, controller, isMobile),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  TextString.adminAllSubscription,
                    style: TTextTheme.h3Style(context).copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  _buildControlsRow(context, controller, isMobile),
                  const SizedBox(height: 20),
                  _buildSubscriptionTable(context, controller),
                  const SizedBox(height: 20),
                  _buildPaginationControls(context, controller)
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// ---------- Extra Widget ------------- ///

  // Stat Cards
  Widget _buildStatCardsRow(BuildContext context, SubscriptionController controller, bool isMobile) {
    final cards = [
      _buildStatCard(context,TextString.adminSubscriptionKpiOne , controller.totalNewSubscriptions.value, TextString.adminSubscriptionKpiTwo),
      _buildStatCard(context,TextString.adminSubscriptionKpiThree , controller.totalWeeklySubscriptions.value,TextString.adminSubscriptionKpiFour),
      _buildStatCard(context,TextString.adminSubscriptionKpiFive , controller.totalMonthlySubscriptions.value,TextString.adminSubscriptionKpiSix ),
      _buildStatCard(context,TextString.adminSubscriptionKpiSeven , controller.totalYearlySubscriptions.value,TextString.adminSubscriptionKpiEight),
    ];

    if (isMobile) {
      return Column(
        children: cards.map((card) => Padding(padding: const EdgeInsets.only(bottom: 12), child: card)).toList(),
      );
    }

    return Row(
      children: cards.map((card) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: card))).toList(),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String count, String subtext) {
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
              SvgPicture.asset(IconString.subscriptionAdminIcon, width: 16, height: 16, colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TTextTheme.titleSix(context).copyWith(fontSize: 11, color: AppColors.subtextColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(count, style: TTextTheme.h2Style(context).copyWith(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtext, style: TTextTheme.titleSix(context).copyWith(fontSize: 10, color: AppColors.subtextColor)),
        ],
      ),
    );
  }

  // Control Rows
  Widget _buildControlsRow(BuildContext context, SubscriptionController controller, bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool wrapControls = constraints.maxWidth < 650;

        return wrapControls
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabsContainer(context,controller),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: _buildSearchTextField(context, controller, isMobile: true),
            ),
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTabsContainer(context,controller),
            _buildSearchTextField(context, controller, isMobile: false),
          ],
        );
      },
    );
  }

  // Tabs Container
  Widget _buildTabsContainer(BuildContext context,SubscriptionController controller) {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.backgroundOfScreenColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: controller.tabs.map((tab) {
              bool isSelected = controller.selectedTab.value == tab;
              return InkWell(
                onTap: () => controller.changeTab(tab),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tab,
                    style: isSelected ? TTextTheme.whiteColorBtn(context) : TTextTheme.titleSix(context),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
   // Searchbar
  Widget _buildSearchTextField(BuildContext context, SubscriptionController controller, {required bool isMobile}) {
    return SizedBox(
      width: isMobile ? double.infinity : 260,
      height: 40,
      child: TextField(
        cursorColor: AppColors.textColor,
        onChanged: (val) => controller.searchQuery.value = val,
        decoration: InputDecoration(
          hintText: TextString.adminSubscriptionFieldText,
          hintStyle: TTextTheme.titleSix(context).copyWith(fontSize: 12),
          prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.subtextColor),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          filled: true,
          fillColor: AppColors.whiteColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

   // Subscription Table
  Widget _buildSubscriptionTable(BuildContext context, SubscriptionController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double minTableWidth = 950.0;
        final double containerWidth = constraints.maxWidth > minTableWidth ? constraints.maxWidth : minTableWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: containerWidth,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Obx(() => Checkbox(
                          value: controller.isSelectAll.value,
                          onChanged: controller.toggleSelectAll,
                          activeColor: AppColors.primaryColor,
                          side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(flex: 3, child: Text(TextString.adminSubscriptionTableOne, style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text(TextString.adminSubscriptionTableTwo, style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text(TextString.adminSubscriptionTableThree, style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text(TextString.adminSubscriptionTableFour, style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text(TextString.adminSubscriptionTableFive, style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text(TextString.adminSubscriptionTableSix, style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text(TextString.adminSubscriptionTableSeven, style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text(TextString.adminSubscriptionTableEight, style: _headerTextStyle(context))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  final list = controller.filteredSubscriptions;

                  if (list.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(32),
                      alignment: Alignment.center,
                      child: Text(
                        TextString.adminSubscriptionErrorText,
                        style: TTextTheme.TextError(context),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return _buildSubscriptionRowCard(context, item);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

// Subscription Row Card with Action Icons
  Widget _buildSubscriptionRowCard(BuildContext context, SubscriptionItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.8)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
              value: item.isSelected.value,
              onChanged: (val) => item.isSelected.value = val ?? false,
              activeColor: AppColors.primaryColor,
              side: const BorderSide(color: AppColors.borderColor, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            )),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                SvgPicture.asset(
                  IconString.companyTable,
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.companyName,
                    style: TTextTheme.titleFive(context).copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.textColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(item.plan, style: _cellTextStyle(context)),
          ),
          Expanded(
            flex: 2,
            child: Text(item.cycle, style: _cellTextStyle(context)),
          ),
          Expanded(
            flex: 2,
            child: Text(item.startDate, style: _cellTextStyle(context)),
          ),
          Expanded(
            flex: 2,
            child: Text(item.endDate, style: _cellTextStyle(context)),
          ),
          Expanded(
            flex: 2,
            child: Text(item.pricing, style: _cellTextStyle(context)),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildFullStatusBadge(context, item.status),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                InkWell(
                  onTap: () {

                    context.go(
                      '/Admin/subscription/view',
                      extra: item,
                    );

                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      IconString.eyeIcon,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (context.mounted) {
                        context.go(
                          '/Admin/subscription/invoice',
                          extra: item,
                        );
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      IconString.subscriptionInvoice,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(AppColors.textColor, BlendMode.srcIn),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Status Chip Badge
  Widget _buildFullStatusBadge(BuildContext context, String status) {
    Color bgColor;

    switch (status) {
      case 'Active':
        bgColor = AppColors.approvedColor;
        break;
      case 'Suspended':
        bgColor = AppColors.rejectedColor;
        break;
      case 'Expired':
        bgColor = AppColors.tertiaryTextColor;
        break;
      default:
        bgColor = AppColors.borderColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TTextTheme.whiteColorBtn(context)
      ),
    );
  }


//  Text Styles
  TextStyle _headerTextStyle(BuildContext context) {
    return TTextTheme.titleSix(context).copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.subtextColor,
    );
  }
  TextStyle _cellTextStyle(BuildContext context) {
    return TTextTheme.titleSix(context).copyWith(
      fontSize: 12,
      color: AppColors.subtextColor,
    );
  }

  // Pagination
  Widget _buildPaginationControls(BuildContext context, SubscriptionController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
          children: [
            if (isMobile) ...[
              Center(child: _buildResultsPerPageDropdown(context, controller)),
              const SizedBox(height: 12),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: _buildPageNumbersRow(context),
                ),
              ),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildResultsPerPageDropdown(context, controller),
                  _buildPageNumbersRow(context),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
  Widget _buildResultsPerPageDropdown(BuildContext context, SubscriptionController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          TextString.adminReportResult,
          style: TTextTheme.titleSix(context),
        ),
        const SizedBox(width: 8),
        Obx(
              () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: controller.rowsPerPage.value,
                isDense: true,
                icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.subtextColor),
                items: [5, 10, 20].map((int val) {
                  return DropdownMenuItem<int>(
                    value: val,
                    child: Text(
                      "$val",
                      style: TTextTheme.PageNumber(context),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) controller.rowsPerPage.value = val;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

// Page Number
  Widget _buildPageNumbersRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfScreenColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.chevron_left, size: 14, color: AppColors.tertiaryTextColor),
                const SizedBox(width: 2),
                Text(
                  TextString.adminReportPrev,
                  style: TTextTheme.titleSeven(context).copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 4),

        _buildPageNumberBox(context, "1", isSelected: true),
        _buildPageNumberBox(context, "2"),
        _buildPageNumberBox(context, "3"),

        const SizedBox(width: 4),

        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  TextString.adminReportNext,
                  style: TTextTheme.titleFive(context).copyWith(fontSize: 12),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.chevron_right, size: 14, color: AppColors.textColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildPageNumberBox(BuildContext context, String number, {bool isSelected = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: 26,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          number,
          style: isSelected
              ? TTextTheme.btnTextOne(context)
              : TTextTheme.titleTwo(context).copyWith(fontSize: 11),
        ),
      ),
    );
  }
}