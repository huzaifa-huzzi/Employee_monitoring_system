import 'package:employee_monitoring_system/Panel/Admin/Report/ReportController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class ReportScreenWidget extends StatelessWidget {
  const ReportScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Report",
              style: TTextTheme.h2Style(context).copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "You can see all reports here",
              style: TTextTheme.titleFour(context).copyWith(
                color: AppColors.tertiaryTextColor,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                double availableWidth = constraints.maxWidth;
                int crossAxisCount = availableWidth > 1100 ? 4 : (availableWidth > 650 ? 2 : 1);
                double spacing = 16.0;
                double cardWidth = (availableWidth - ((crossAxisCount - 1) * spacing)) / crossAxisCount;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    _buildStatCard(
                      context: context,
                      width: cardWidth,
                      icon: IconString.totalReport,
                      iconBgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                      iconColor: AppColors.primaryColor,
                      title: "Total Reports",
                      value: controller.totalReports.value,
                      subtitle: "Available in library",
                    ),
                    _buildStatCard(
                      context: context,
                      width: cardWidth,
                      icon: IconString.reportsGenerated,
                      iconBgColor: AppColors.backgroundOfScreenColor,
                      iconColor: AppColors.approvedColor,
                      title: "Report Generated",
                      value: controller.reportsGeneratedToday.value,
                      subtitle: "3 more report generated today",
                    ),
                    _buildStatCard(
                      context: context,
                      width: cardWidth,
                      icon: IconString.totalDownload,
                      iconBgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                      iconColor: AppColors.primaryColor,
                      title: "Total Downloads",
                      value: controller.totalDownloads.value,
                      subtitle: "2 more reports downloaded",
                    ),
                    _buildStatCard(
                      context: context,
                      width: cardWidth,
                      icon: IconString.lastGenerated,
                      iconBgColor: AppColors.primaryColor.withValues(alpha: 0.1),
                      iconColor: AppColors.primaryColor,
                      title: "Last Generated",
                      value: controller.lastGeneratedReport.value,
                      subtitle: "Today at 10:12 am",
                      isValueTextLarge: false,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Business Reports",
                    style: TTextTheme.h3Style(context).copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double minTableWidth = 800.0;
                      double targetWidth = constraints.maxWidth < minTableWidth
                          ? minTableWidth
                          : constraints.maxWidth;

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          width: targetWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildTableHeader(context, controller),
                              const SizedBox(height: 12),
                              Obx(
                                    () => Column(
                                  children: List.generate(
                                    controller.reportsList.length,
                                        (index) {
                                      final report = controller.reportsList[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 12.0),
                                        child: _buildTableRow(
                                          context,
                                          controller,
                                          report,
                                          index,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildPaginationControls(context, controller),
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
      ),
    );
  }

  /// ----------- Extra Widget ---------------///

  // Stat Card Widget
  Widget _buildStatCard({
    required BuildContext context,
    required double width,
    required String icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String value,
    required String subtitle,
    bool isValueTextLarge = true,
  }) {
    return Container(
      width: width,
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
                icon,
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TTextTheme.titleFour(context).copyWith(
                    color: AppColors.subtextColor,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: isValueTextLarge
                ? TTextTheme.h2Style(context).copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            )
                : TTextTheme.titleOne(context).copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TTextTheme.titleFour(context).copyWith(
              color: AppColors.tertiaryTextColor,
              fontSize: 11,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Table Header
  Widget _buildTableHeader(BuildContext context, ReportController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfScreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Obx(
                () => SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: controller.isAllSelected.value,
                onChanged: controller.toggleSelectAll,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                activeColor: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(flex: 3, child: _HeaderText(text: "Report Name")),
          const Expanded(flex: 2, child: _HeaderText(text: "Category")),
          const Expanded(flex: 2, child: _HeaderText(text: "Last Generated")),
          const SizedBox(width: 120, child: _HeaderText(text: "Status")),
          const SizedBox(width: 110, child: _HeaderText(text: "Actions")),
        ],
      ),
    );
  }

  // Table Row
  Widget _buildTableRow(BuildContext context, ReportController controller, ReportModel report, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: report.isSelected,
              onChanged: (val) => controller.toggleSelectReport(index, val),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              side: const BorderSide(color: AppColors.borderColor, width: 1.5),
              activeColor: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundContainerOfNotification,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SvgPicture.asset(
                    IconString.companyTable,
                    height: 14,
                    width: 14,
                    colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    report.name,
                    style: TTextTheme.titleTwo(context).copyWith(
                      fontWeight: FontWeight.w600,
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
            child: Text(
              report.category,
              style: TTextTheme.titleFour(context).copyWith(
                color: AppColors.subtextColor,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              report.lastGenerated,
              style: TTextTheme.titleFour(context).copyWith(
                color: AppColors.subtextColor,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 120,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildStatusBadge(context, report.status),
            ),
          ),
      SizedBox(
        width: 110,
        child: Row(
          children: [
            _buildActionButton(
              icon: Icons.visibility_outlined,
              onTap: () {
                context.go('/Admin/reportsDetails');
              },
              hasBackground: true,
            ),
            const SizedBox(width: 6),
            _buildActionButton(
              icon: Icons.autorenew_rounded,
              onTap: () => controller.onRegenerateReport(report),
              hasBackground: false,
            ),
            const SizedBox(width: 6),
            _buildActionButton(
              icon: Icons.file_download_outlined,
              onTap: () {
                _showReportFailedDialog(
                  context,
                  onGenerateAgain: () {
                    controller.onRegenerateReport(report);
                  },
                );
              },
              hasBackground: true,
            ),
          ],
        ),
      ),
        ],
      ),
    );
  }

  // Status Badge Builder
  Widget _buildStatusBadge(BuildContext context, String status) {
    Color bgColor;
    Color textColor = AppColors.whiteColor;

    switch (status) {
      case 'Ready':
        bgColor = AppColors.approvedColor;
        break;
      case 'In Progress':
        bgColor = AppColors.inProgress;
        break;
      case 'No Reports':
        bgColor = AppColors.tertiaryTextColor;
        textColor = AppColors.whiteColor;
        break;
      case 'Failed':
        bgColor = AppColors.rejectedColor;
        break;
      default:
        bgColor = AppColors.crossBackground;
        textColor = AppColors.whiteColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TTextTheme.titleFour(context).copyWith(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // Action Button Builder
  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasBackground = true,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: hasBackground ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 16,
            color: hasBackground ? AppColors.whiteColor : AppColors.textColor,
          ),
        ),
      ),
    );
  }

  // Pagination Footer
  Widget _buildPaginationControls(BuildContext context, ReportController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Results per page",
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
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.backgroundOfScreenColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Icon(Icons.chevron_left, size: 14, color: AppColors.tertiaryTextColor),
                  const SizedBox(width: 2),
                  Text(
                    "Prev",
                    style: TTextTheme.titleSeven(context).copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _buildPageNumberBox(context, "1", isSelected: true),
            _buildPageNumberBox(context, "2"),
            _buildPageNumberBox(context, "3"),
            _buildPageNumberBox(context, "4"),
            const SizedBox(width: 8),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Row(
                    children: [
                      Text(
                        "Next",
                        style: TTextTheme.titleFive(context).copyWith(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.chevron_right, size: 14, color: AppColors.textColor),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPageNumberBox(BuildContext context, String number, {bool isSelected = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
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
          style: isSelected
              ? TTextTheme.btnTextOne(context)
              : TTextTheme.titleTwo(context).copyWith(fontSize: 12),
        ),
      ),
    );
  }


  /// Dialog
  void _showReportFailedDialog(BuildContext context, {required VoidCallback onGenerateAgain}) {
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
                        color: const Color(0xFFFEF0C7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFDC6803),
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Report Generation Failed",
                            style: TTextTheme.h3Style(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Database timeout occurred while processing the report.",
                            style: TTextTheme.titleFour(context).copyWith(
                              color: AppColors.tertiaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Last Attempt: 07 Aug 2026 • 10:45 AM",
                    textAlign: TextAlign.center,
                    style: TTextTheme.loginTexts(context).copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primaryColor, width: 1),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Back To Reports",
                          style: TTextTheme.ForgotPasswordText(context).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onGenerateAgain();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Generate Again",
                          style: TTextTheme.whiteColorBtn(context),
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
}

  /// ----------- Class ----------- ///
// Header Text
class _HeaderText extends StatelessWidget {
  final String text;
  const _HeaderText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TTextTheme.titleSeven(context),
      overflow: TextOverflow.ellipsis,
    );
  }
}
