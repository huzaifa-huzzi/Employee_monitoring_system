import 'package:employee_monitoring_system/Panel/Admin/Report/ReportController.dart';
import 'package:employee_monitoring_system/Panel/Admin/Report/ReusableWidget/CustomDatePickerReport.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class ReportDetailScreen extends StatelessWidget {
  const ReportDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxString selectedHeaderFilter = "Week".obs;
    final RxString selectedRevenueFilter = "Weekly".obs;
    final RxString selectedCompanyFilter = "Company Name".obs;
    final RxString resultsPerPage = "5".obs;

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopHeader(context, isMobile, screenWidth, selectedHeaderFilter),
            const SizedBox(height: 24),
            _buildStatCards(context, isMobile),
            const SizedBox(height: 24),
            isMobile
                ? Column(
              children: [
                _buildWeeklyRevenueCard(context, isMobile, screenWidth, selectedRevenueFilter),
                const SizedBox(height: 20),
                _buildIndustryCard(context),
              ],
            )
                : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildWeeklyRevenueCard(context, isMobile, screenWidth, selectedRevenueFilter)),
                const SizedBox(width: 20),
                Expanded(child: _buildIndustryCard(context)),
              ],
            ),
            const SizedBox(height: 24),
            _buildNewlyJoinedCompaniesCard(context, isMobile, screenWidth, selectedCompanyFilter, resultsPerPage),
          ],
        ),
      ),
    );
  }

  /// ----------- Extra Widget -------------- ///

  // Top Header Bar
  Widget _buildTopHeader(
      BuildContext context,
      bool isMobile,
      double screenWidth,
      RxString selectedHeaderFilter,
      ) {
    final Rx<DateTime> selectedDate = DateTime.now().obs;

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  context.go('/Admin/reports');
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.arrow_back, size: 18, color: AppColors.textColor),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    TextString.adminReportDetailTitle,
                    style: TTextTheme.h2Style(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                   TextString.adminReportDetailSubtitle,
                    style: TTextTheme.titleSix(context).copyWith(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() {
                final filter = selectedHeaderFilter.value;
                final currentDate = selectedDate.value;
                String dateText = "";

                if (filter == "Day") {
                  dateText = "${currentDate.day} ${_getFullMonthName(currentDate.month)}, ${currentDate.year}";
                } else if (filter == "Month") {
                  dateText = "${_getFullMonthName(currentDate.month)} ${currentDate.year}";
                } else {
                  final startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday - 1));
                  final endOfWeek = startOfWeek.add(const Duration(days: 6));
                  dateText = "${startOfWeek.day} ${_getFullMonthName(startOfWeek.month)}, ${startOfWeek.year} - ${endOfWeek.day} ${_getFullMonthName(endOfWeek.month)}, ${endOfWeek.year}";
                }

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          if (filter == "Day") {
                            selectedDate.value = currentDate.subtract(const Duration(days: 1));
                          } else if (filter == "Month") {
                            selectedDate.value = DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
                          } else {
                            selectedDate.value = currentDate.subtract(const Duration(days: 7));
                          }
                        },
                        child: const Icon(Icons.chevron_left, size: 18, color: AppColors.subtextColor),
                      ),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: () {
                          _showCustomDatePicker(
                            context,
                            initialDate: selectedDate.value,
                            onDateSelected: (newDate) {
                              selectedDate.value = newDate;
                            },
                          );
                        },
                        child: Text(
                          dateText,
                          style: TTextTheme.titleFive(context).copyWith(fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: () {
                          if (filter == "Day") {
                            selectedDate.value = currentDate.add(const Duration(days: 1));
                          } else if (filter == "Month") {
                            selectedDate.value = DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
                          } else {
                            selectedDate.value = currentDate.add(const Duration(days: 7));
                          }
                        },
                        child: const Icon(Icons.chevron_right, size: 18, color: AppColors.subtextColor),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(width: 12),
              _buildCustomPopupMenu(
                context: context,
                currentValue: selectedHeaderFilter,
                options: const ["Day", "Week", "Month"],
                onSelected: (val) {
                  selectedHeaderFilter.value = val;
                },
                width: 110,
              ),
            ],
          ),
        ],
      ),
    );
  }
  String _getFullMonthName(int monthIndex) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[monthIndex - 1];
  }

  // Stat Cards
  Widget _buildStatCards(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          _buildStatCardItem(context, IconString.companyTable,TextString.adminReportDetailKpiOne ,TextString.adminReportDetailKpiTwo ,TextString.adminReportDetailKpiThree , true),
          const SizedBox(height: 12),
          _buildStatCardItem(context, IconString.companyTable,TextString.adminReportDetailKpiFour ,TextString.adminReportDetailKpiFive ,TextString.adminReportDetailKpiSix , true),
          const SizedBox(height: 12),
          _buildStatCardItem(context, IconString.NetGrowth,TextString.adminReportDetailKpiSeven ,TextString.adminReportDetailKpiEight ,TextString.adminReportDetailKpiNine , true),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: _buildStatCardItem(context, IconString.companyTable, TextString.adminReportDetailKpiOne, TextString.adminReportDetailKpiTwo, TextString.adminReportDetailKpiThree, true),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCardItem(context, IconString.companyTable, TextString.adminReportDetailKpiFour, TextString.adminReportDetailKpiFive, TextString.adminReportDetailKpiSix, true),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCardItem(context, IconString.NetGrowth, TextString.adminReportDetailKpiSeven, TextString.adminReportDetailKpiEight, TextString.adminReportDetailKpiNine, true),
        ),
      ],
    );
  }

  Widget _buildStatCardItem(
      BuildContext context,
      String iconPath,
      String title,
      String value,
      String badgeText,
      bool isUp,
      ) {
    return Container(
      padding: const EdgeInsets.all(20),
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
                iconPath,
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
                  title,
                  style: TTextTheme.titleFour(context).copyWith(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TTextTheme.h2Style(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            badgeText,
            style: isUp ? TTextTheme.upNumbers(context) : TTextTheme.downNumbers(context),
          ),
        ],
      ),
    );
  }

  // Weekly Revenue
  Widget _buildWeeklyRevenueCard(
      BuildContext context,
      bool isMobile,
      double screenWidth,
      RxString revenueFilter,
      ) {
    final Rx<DateTime> selectedDate = DateTime.now().obs;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                        () => Text(
                      revenueFilter.value == "Monthly" ? "Monthly Revenue" : "Weekly Revenue",
                      style: TTextTheme.h3Style(context).copyWith(fontSize: 16),
                    ),
                  ),
                  Obx(
                        () => Text(
                      revenueFilter.value == "Monthly" ? "Revenue per month" : "Revenue per day",
                      style: TTextTheme.titleSix(context).copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _showCustomDatePicker(
                        context,
                        initialDate: selectedDate.value,
                        onDateSelected: (newDate) {
                          selectedDate.value = newDate;
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            IconString.calendarIcon,
                            width: 14,
                            height: 14,
                            colorFilter: const ColorFilter.mode(
                              AppColors.subtextColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            TextString.PickDate,
                            style: TTextTheme.titleSix(context).copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildCustomPopupMenu(
                    context: context,
                    currentValue: revenueFilter,
                    options: const ["Weekly", "Monthly"],
                    onSelected: (val) {
                      revenueFilter.value = val;
                    },
                    width: 110,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() {
            final chosenDate = selectedDate.value;
            final isMonthly = revenueFilter.value == "Monthly";
            String dateText = "";

            if (isMonthly) {
              dateText = "${_getMonthAbbr(chosenDate.month)}, ${chosenDate.year}";
            } else {
              final startOfWeek = chosenDate.subtract(Duration(days: chosenDate.weekday - 1));
              final endOfWeek = startOfWeek.add(const Duration(days: 6));
              dateText = "${startOfWeek.day} ${_getMonthAbbr(startOfWeek.month)}, ${startOfWeek.year} - ${endOfWeek.day} ${_getMonthAbbr(endOfWeek.month)}, ${endOfWeek.year}";
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.backgroundOfScreenColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    IconString.calendarIcon,
                    width: 14,
                    height: 14,
                    colorFilter: const ColorFilter.mode(
                      AppColors.subtextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Selected Date: $dateText",
                        style: TTextTheme.titleFive(context).copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ["60", "45", "30", "15", "0"]
                      .map((e) => Text(e, style: TTextTheme.titleFour(context).copyWith(fontSize: 10)))
                      .toList(),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Obx(() {
                        final isMonthly = revenueFilter.value == "Monthly";

                        if (isMonthly) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildBar("Jan", 0.4),
                              _buildBar("Feb", 0.6),
                              _buildBar("Mar", 0.8),
                              _buildBar("Apr", 0.5),
                              _buildBar("May", 0.9),
                              _buildBar("Jun", 0.7),
                              _buildBar("Jul", 0.85),
                              _buildBar("Aug", 0.6),
                              _buildBar("Sep", 0.75),
                              _buildBar("Oct", 0.5),
                              _buildBar("Nov", 0.8),
                              _buildBar("Dec", 0.95),
                            ],
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildBar("Mon", 0.9),
                            _buildBar("Tue", 0.6),
                            _buildBar("Wed", 0.9),
                            _buildBar("Thu", 0.75),
                            _buildBar("Fri", 0.75),
                            _buildBar("Sat", 0.6),
                            _buildBar("Sun", 0.85),
                          ],
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String day, double heightFactor) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: heightFactor,
                child: Container(
                  width: 18,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(day, style: const TextStyle(fontSize: 10, color: AppColors.subtextColor)),
          ),
        ],
      ),
    );
  }

  // Industry Card
  Widget _buildIndustryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.adminIndustryOrganization, style: TTextTheme.h3Style(context).copyWith(fontSize: 16)),
          const SizedBox(height: 24),
          SizedBox(
            height: 220,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildHorizontalBar(TextString.adminIndustryTechnology, 0.95),
                _buildHorizontalBar(TextString.adminBpoService, 0.3),
                _buildHorizontalBar(TextString.adminReportHealthCar, 0.5),
                _buildHorizontalBar(TextString.adminReportFinance, 0.52),
                _buildHorizontalBar(TextString.adminReportEducation, 0.52),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ["0", "15", "30", "45", "60", "75", "90"]
                  .map((e) => Text(e, style: TTextTheme.titleFour(context).copyWith(fontSize: 10)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalBar(String label, double factor) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.subtextColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(height: 18, color: Colors.transparent),
              FractionallySizedBox(
                widthFactor: factor,
                child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Newly Joined Companies Card
  Widget _buildNewlyJoinedCompaniesCard(
      BuildContext context,
      bool isMobile,
      double screenWidth,
      RxString companyFilter,
      RxString resultsPerPage,
      ) {
    final ReportController controller = Get.find<ReportController>();

    const companyList = [
      {"name": "Journey One", "owner": "Adam Jhon", "email": "operations@rmkble.com.au", "emp": "50", "sub": "Monthly", "status": "Active"},
      {"name": "VGW", "owner": "Adam Jhon", "email": "media@vgw.co", "emp": "100", "sub": "Monthly", "status": "Active"},
      {"name": "Data Divers.io", "owner": "Adam Jhon", "email": "datadivers@gmail.com.au", "emp": "1k", "sub": "Monthly", "status": "Active"},
      {"name": "Horizon Power Digital", "owner": "Adam Jhon", "email": "horizon@gmail.com.au", "emp": "223", "sub": "Monthly", "status": "Active"},
      {"name": "Hello People", "owner": "Adam Jhon", "email": "info@hellopeople.com.au", "emp": "224", "sub": "Yearly", "status": "Active"},
    ];

    return Container(
      width: double.infinity,
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
            TextString.adminReportJoinedCompanies,
            style: TTextTheme.h3Style(context).copyWith(fontSize: 16),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  width: isMobile ? screenWidth - 80 : 240,
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, size: 16, color: AppColors.tertiaryTextColor),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          cursorColor: AppColors.textColor,
                          decoration: InputDecoration(
                            hintText: TextString.adminReportFieldText,
                            hintStyle: TextStyle(
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
                ),
                _buildCustomPopupMenu(
                  context: context,
                  currentValue: companyFilter,
                  options: const ["Company Name", "Owner Name", "Email"],
                  onSelected: (val) {},
                  width: 150,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final double availableWidth = constraints.maxWidth;
              const double minTableWidth = 850;
              final double tableWidth = availableWidth > minTableWidth ? availableWidth : minTableWidth;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: tableWidth,
                  child: Column(
                    children: [
                      _buildTableHeader(controller),
                      const SizedBox(height: 10),
                      ...List.generate(
                        companyList.length,
                            (index) {
                          final item = companyList[index];
                          return _buildTableRow(
                            context,
                            controller,
                            index,
                            item["name"]!,
                            item["owner"]!,
                            item["email"]!,
                            item["emp"]!,
                            item["sub"]!,
                            item["status"]!,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildTablePagination(context, isMobile, screenWidth, controller),
        ],
      ),
    );
  }

  Widget _buildTableHeader(ReportController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfScreenColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Obx(
                () => _CustomCheckbox(
              value: controller.isAllSelected.value,
              onChanged: (val) => controller.toggleSelectAll(val),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(flex: 3, child: _HeaderText(text: TextString.adminReportDetailCompany )),
          const Expanded(flex: 2, child: _HeaderText(text: TextString.adminReportDetailOwner)),
          const Expanded(flex: 3, child: _HeaderText(text: TextString.adminReportDetailEmail )),
          const Expanded(flex: 2, child: _HeaderText(text: TextString.adminReportDetailEmployee )),
          const Expanded(flex: 2, child: _HeaderText(text: TextString.adminReportDetailSubscription )),
          const SizedBox(width: 80, child: _HeaderText(text: TextString.adminReportDetailStatus)),
        ],
      ),
    );
  }

  Widget _buildTableRow(
      BuildContext context,
      ReportController controller,
      int index,
      String company,
      String owner,
      String email,
      String emp,
      String sub,
      String status,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Obx(
                () => _CustomCheckbox(
              value: controller.reportsList[index].isSelected,
              onChanged: (val) => controller.toggleSelectReport(index, val),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                SvgPicture.asset(
                  IconString.companyTable,
                  width: 14,
                  height: 14,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    company,
                    style: TTextTheme.titleFive(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              owner,
              style: TTextTheme.titleSix(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              email,
              style: TTextTheme.titleSix(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              emp,
              style: TTextTheme.titleSix(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              sub,
              style: TTextTheme.titleSix(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 80,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.approvedColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: TTextTheme.whiteColorBtn(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTablePagination(
      BuildContext context,
      bool isMobile,
      double screenWidth,
      ReportController controller,
      ) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Row(
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
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: AppColors.subtextColor,
                      ),
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
                    const Icon(
                      Icons.chevron_left,
                      size: 14,
                      color: AppColors.tertiaryTextColor,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      TextString.adminReportPrev,
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
                          TextString.adminReportNext,
                          style: TTextTheme.titleFive(context).copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.chevron_right,
                          size: 14,
                          color: AppColors.textColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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

  // Custom Pop Menu
  Widget _buildCustomPopupMenu({
    required BuildContext context,
    required RxString currentValue,
    required List<String> options,
    required Function(String) onSelected,
    double width = 120,
  }) {
    final RxBool isOpen = false.obs;

    return PopupMenuButton<String>(
      constraints: BoxConstraints(
        minWidth: width,
        maxWidth: width,
        maxHeight: 300,
      ),
      offset: const Offset(0, 42),
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
        height: 40,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.borderColor.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                currentValue.value,
                overflow: TextOverflow.ellipsis,
                style: TTextTheme.titleFour(context).copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor,
                ),
              ),
            ),
            Icon(
              isOpen.value ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
              color: AppColors.tertiaryTextColor,
              size: 18,
            ),
          ],
        ),
      )),
      itemBuilder: (BuildContext context) {
        return options.map((String opt) {
          return PopupMenuItem<String>(
            value: opt,
            height: 38,
            child: Text(
              opt,
              style: TTextTheme.titleFour(context).copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
          );
        }).toList();
      },
    );
  }

  // Dialog Trigger Function
  void _showCustomDatePicker(
      BuildContext context, {
        DateTime? initialDate,
        required Function(DateTime) onDateSelected,
      }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: CustomDatePickerReport(
            initialDate: initialDate,
            onCancel: () => Navigator.of(dialogContext).pop(),
            onDateSelected: (selectedDate) {
              onDateSelected(selectedDate);
              Navigator.of(dialogContext).pop();
            },
          ),
        );
      },
    );
  }
   // Month Abbreviation
  String _getMonthAbbr(int monthIndex) {
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return months[monthIndex - 1];
  }
}


 /// ------- Extra Class -------- ///

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

 // Custom Check box
class _CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _CustomCheckbox({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: value ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: value ? AppColors.primaryColor : AppColors.borderColor,
            width: 1.5,
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
}
