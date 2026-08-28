import 'package:employee_monitoring_system/Panel/Admin/Subscription/SubscriptionController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';



class SubscriptionInvoice extends StatelessWidget {
  final SubscriptionItem? item;

  const SubscriptionInvoice({super.key, this.item});

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

  @override
  Widget build(BuildContext context) {
    final SubscriptionController controller = Get.put(SubscriptionController());

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 600;
                        return isMobile
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "All Invoices",
                              style: TTextTheme.titleFive(context).copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildSearchBar(controller),
                          ],
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "All Invoices",
                              style: TTextTheme.titleFive(context).copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor,
                              ),
                            ),
                            SizedBox(
                              width: 260,
                              child: _buildSearchBar(controller),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildInvoiceTable(context, controller),
                    const SizedBox(height: 24),
                    _buildPaginationControls(context, controller),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --------- Extra Widget ------------ ///

  // Header Navigation
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: const Icon(Icons.arrow_back, size: 18, color: AppColors.textColor),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Invoices Detail",
                style: TTextTheme.titleFive(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                "Your subscription detail is given below",
                style: TTextTheme.titleSix(context).copyWith(
                  color: AppColors.subtextColor,
                  fontSize: 12,
                ),
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Search Bar
  Widget _buildSearchBar(SubscriptionController controller) {
    return SizedBox(
      height: 40,
      child: TextField(
        cursorColor: AppColors.textColor,
        controller: controller.searchController,
        onChanged: (val) => controller.searchQuery.value = val,
        decoration: InputDecoration(
          hintText: "Search by Company Name",
          hintStyle: const TextStyle(fontSize: 12, color: AppColors.subtextColor),
          prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.subtextColor),
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
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

  // Table Structure
  Widget _buildInvoiceTable(BuildContext context, SubscriptionController controller) {
    final String currentStatus = item?.status ?? "Active";

    return LayoutBuilder(
      builder: (context, constraints) {
        const double minTableWidth = 950.0;
        final double containerWidth =
        constraints.maxWidth > minTableWidth ? constraints.maxWidth : minTableWidth;

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
                        child: Obx(
                              () => Checkbox(
                            value: controller.isSelectAll.value,
                            onChanged: controller.toggleSelectAll,
                            activeColor: AppColors.primaryColor,
                            side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(flex: 3, child: Text("Invoice ID", style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text("Payment Date", style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text("Billing Period", style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text("Plan", style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text("Amount", style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text("Method", style: _headerTextStyle(context))),
                      Expanded(flex: 3, child: Text("Status", style: _headerTextStyle(context))),
                      Expanded(flex: 2, child: Text("Action", style: _headerTextStyle(context))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  final list = controller.filteredSubscriptions;
                  if (list.isEmpty) {
                    return  Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(
                        child: Text("No records found", style: TTextTheme.TextError(context)),
                      ),
                    );
                  }

                  return Column(
                    children: list.map((subItem) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: _buildTableRowCard(
                          context,
                          controller: controller,
                          item: subItem,
                          billingPeriod: "Aug, 2026",
                          method: "Pay to",
                          status: currentStatus,
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

   // Table Row Card
  Widget _buildTableRowCard(
      BuildContext context, {
        required SubscriptionController controller,
        required SubscriptionItem item,
        required String billingPeriod,
        required String method,
        required String status,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            child: Obx(
                  () => Checkbox(
                value: item.isSelected.value,
                onChanged: (val) => controller.toggleRowSelection(item, val),
                activeColor: AppColors.primaryColor,
                side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              item.companyName,
              style: TTextTheme.titleFive(context).copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(item.plan, style: _cellTextStyle(context), overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 2,
            child: Text(billingPeriod, style: _cellTextStyle(context), overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 2,
            child: Text(item.cycle, style: _cellTextStyle(context), overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 2,
            child: Text(
              item.pricing,
              style: TTextTheme.titleFive(context).copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                SvgPicture.asset(
                  IconString.methodIcon,
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    method,
                    style: _cellTextStyle(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildFullStatusBadge(context, status),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: () {
                  context.go('/Admin/subscription/invoiceDetails', extra: item);
                },
                icon: const Icon(
                  Icons.remove_red_eye_outlined,
                  size: 16,
                  color: AppColors.primaryColor,
                ),
                label:  Text(
                  "View",
                  style: TTextTheme.ForgotPasswordText(context),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryColor, width: 1.2),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Exact Status Badge Logic
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
        bgColor = AppColors.approvedColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TTextTheme.whiteColorBtn(context),
      ),
    );
  }

  // Pagination Footer
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

  // Page Numbers Row
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