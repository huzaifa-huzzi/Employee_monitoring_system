import 'package:employee_monitoring_system/Panel/Admin/Demo/DemoController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DemoWidget extends StatelessWidget {
  const DemoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DemoController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Demo Request",
          style: TTextTheme.titleFive(context).copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Here is all the demo request",
          style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final double cardWidth = constraints.maxWidth < 600
                ? constraints.maxWidth
                : (constraints.maxWidth < 1100
                ? (constraints.maxWidth - 16) / 2
                : (constraints.maxWidth - 48) / 4);

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildStatCard(
                  context,
                  width: cardWidth,
                  title: "Total Request",
                  count: "12",
                  subtitle: "3 more request Added",
                  svgPath: IconString.demoMail,
                  iconBg: AppColors.primaryColor,
                  iconColor: AppColors.primaryColor,
                ),
                _buildStatCard(
                  context,
                  width: cardWidth,
                  title: "New Request",
                  count: "4",
                  subtitle: "3 more request Added",
                  svgPath: IconString.demoMail,
                  iconBg: AppColors.primaryColor,
                  iconColor: AppColors.primaryColor,
                ),
                _buildStatCard(
                  context,
                  width: cardWidth,
                  title: "Scheduled Demos",
                  count: "8",
                  subtitle: "3 more demos scheduled",
                  svgPath: IconString.scheduledDemo,
                  iconBg: AppColors.primaryColor,
                  iconColor: AppColors.primaryColor,
                ),
                _buildStatCard(
                  context,
                  width: cardWidth,
                  title: "Completed Demos",
                  count: "4",
                  subtitle: "3 more demos completed",
                  svgPath: IconString.completedDemo,
                  iconBg: AppColors.primaryColor,
                  iconColor: AppColors.primaryColor,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 28),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All Requests",
                style: TTextTheme.titleFive(context).copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.backgroundOfScreenColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() => Wrap(
                  spacing: 4,
                  children: controller.tabs.map((tab) {
                    final isSelected = controller.selectedTab.value == tab;
                    return InkWell(
                      onTap: () => controller.selectTab(tab),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tab,
                          style: TTextTheme.titleSix(context).copyWith(
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: isSelected
                                ? AppColors.whiteColor
                                : AppColors.textColor,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Obx(() => Container(
                      width: 240,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: TextField(
                        controller: controller.searchController,
                        cursorColor: AppColors.textColor,
                        style: TTextTheme.titleSix(context).copyWith(fontSize: 12),
                        decoration: InputDecoration(
                          hintText:
                          "Search by ${controller.selectedSearchFilter.value}",
                          hintStyle: TTextTheme.InsideAlreadyWrittenText(context),
                          prefixIcon: const Icon(Icons.search,
                              size: 18, color: AppColors.textColor),
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 7),
                        ),
                      ),
                    )),
                    Obx(() => _buildCustomPopupMenu(
                      context: context,
                      currentValue: controller.selectedSearchFilter.value,
                      isOpen: controller.isFilterDropdownOpen,
                      options: const ['Company Name', 'Owner Name', 'Email'],
                      onSelected: (val) {
                        controller.selectedSearchFilter.value = val;
                      },
                      minWidthWeb: 130,
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 1050),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOfScreenColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.borderColor.withValues(alpha: 0.5)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 32,
                              child: Obx(() => Checkbox(
                                value: controller.isAllSelected.value,
                                onChanged: (val) =>
                                    controller.toggleSelectAll(val),
                                activeColor: AppColors.primaryColor,
                                side: BorderSide(color: AppColors.borderColor),
                              )),
                            ),
                            _buildHeaderCell(context, "Request Id", width: 110),
                            _buildHeaderCell(context, "Company", width: 160),
                            _buildHeaderCell(context, "Owner Name", width: 140),
                            _buildHeaderCell(context, "Owner Email", width: 170),
                            _buildHeaderCell(context, "Phone Number", width: 140),
                            _buildHeaderCell(context, "No. of employees", width: 120),
                            _buildHeaderCell(context, "Submission Date", width: 120),
                            _buildHeaderCell(context, "Status", width: 110),
                            _buildHeaderCell(context, "Action", width: 140),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        final list = controller.filteredRequests;
                        if (list.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              "No requests found",
                              style: TTextTheme.TextError(context),
                            ),
                          );
                        }
                        return Column(
                          children: list
                              .map((item) =>
                              _buildRowItem(context, controller, item))
                              .toList(),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildPaginationFooter(context, controller),
            ],
          ),
        ),
      ],
    );
  }

  /// ---------- Extra Widgets ----------- ///

  // Pagination
  Widget _buildPaginationFooter(
      BuildContext context, DemoController controller) {
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
                Text(TextString.adminResultPErPAge,
                    style: TTextTheme.titleFour(context)),
                const SizedBox(width: 8),
                Obx(() => _buildCustomPopupMenu(
                  context: context,
                  currentValue: controller.resultsPerPage.value.toString(),
                  isOpen: controller.isResultsPerPageDropdownOpen,
                  options: const ['5', '10', '20', '50'],
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
                    _pageNumberButton(context, "1", isSelected: true),
                    _pageNumberButton(context, "2"),
                    _pageNumberButton(context, "3"),
                    _pageNumberButton(context, "4"),
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

  Widget _pageNumberButton(BuildContext context, String number,
      {bool isSelected = false}) {
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

  // Custom PopMenu
  Widget _buildCustomPopupMenu({
    required BuildContext context,
    required String currentValue,
    required RxBool isOpen,
    required List<String> options,
    required Function(String) onSelected,
    double minWidthWeb = 60,
  }) {
    return PopupMenuButton<String>(
      onOpened: () => isOpen.value = true,
      onCanceled: () => isOpen.value = false,
      onSelected: (val) {
        isOpen.value = false;
        onSelected(val);
      },
      itemBuilder: (context) => options
          .map((e) => PopupMenuItem<String>(
        value: e,
        child: Text(e, style: TTextTheme.titleFour(context)),
      ))
          .toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        constraints: BoxConstraints(minWidth: minWidthWeb),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(currentValue, style: TTextTheme.titleFour(context)),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 14),
          ],
        ),
      ),
    );
  }

  // Header Cell Helper
  Widget _buildHeaderCell(BuildContext context, String text,
      {required double width}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TTextTheme.titleFive(context).copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  // Row Item
  Widget _buildRowItem(
      BuildContext context, DemoController controller, DemoRequestModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Obx(() => Checkbox(
              value: item.isSelected.value,
              onChanged: (val) => controller.toggleIndividualSelect(item, val),
              activeColor: AppColors.primaryColor,
              side: BorderSide(color: AppColors.borderColor),
            )),
          ),
          SizedBox(
            width: 110,
            child: Row(
              children: [
                const Icon(Icons.mail_outline,
                    size: 16, color: AppColors.primaryColor),
                const SizedBox(width: 6),
                Text(
                  item.requestId,
                  style: TTextTheme.titleFive(context).copyWith(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              item.company,
              style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              item.ownerName,
              style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
            ),
          ),
          SizedBox(
            width: 170,
            child: Text(
              item.ownerEmail,
              style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              item.phoneNumber,
              style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              "${item.noOfEmployees}",
              style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              item.submissionDate,
              style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
            ),
          ),
          SizedBox(
            width: 110,
            child: _buildStatusBadge(context, item.status),
          ),
          SizedBox(
            width: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildSvgActionButton(
                  svgPath: IconString.message,
                  iconColor: AppColors.primaryColor,
                  onTap: () {},
                ),
                const SizedBox(width: 4),
                _buildSvgActionButton(
                  svgPath: IconString.demoCalendar,
                  iconColor: AppColors.graphColor,
                  onTap: () {},
                ),
                const SizedBox(width: 4),
                _buildSvgActionButton(
                  svgPath: IconString.demoCompleted,
                  iconColor: AppColors.approvedColor,
                  onTap: () {},
                ),
                const SizedBox(width: 4),
                _buildSvgActionButton(
                  svgPath: IconString.deleteIcon,
                  iconColor: AppColors.rejectedColor,
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Status Badge
  Widget _buildStatusBadge(BuildContext context, String status) {
    Color bg;

    switch (status.toLowerCase()) {
      case 'new':
        bg = AppColors.primaryColor;
        break;
      case 'scheduled':
        bg = AppColors.graphColor;
        break;
      case 'completed':
        bg = AppColors.approvedColor;
        break;
      case 'closed':
        bg = AppColors.tertiaryTextColor;
        break;
      default:
        bg = AppColors.primaryColor;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          status,
          style: TTextTheme.titleSix(context).copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.whiteColor),
        ),
      ),
    );
  }

  // Stat Card
  Widget _buildStatCard(
      BuildContext context, {
        required double width,
        required String title,
        required String count,
        required String subtitle,
        required String svgPath,
        required Color iconBg,
        required Color iconColor,
      }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                svgPath,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TTextTheme.titleSix(context).copyWith(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            count,
            style: TTextTheme.titleFive(context).copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TTextTheme.titleSix(context).copyWith(
              fontSize: 11,
              color: AppColors.textColor.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  // Svg Action Button
  Widget _buildSvgActionButton({
    required String svgPath,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SvgPicture.asset(
          svgPath,
          width: 18,
          height: 18,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}