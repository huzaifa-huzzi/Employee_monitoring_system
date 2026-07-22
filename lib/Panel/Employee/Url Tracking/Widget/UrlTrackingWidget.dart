import 'package:employee_monitoring_system/Panel/Employee/Url%20Tracking/ReusableWidget/customDatePickerUrlDialog.dart';
import 'package:employee_monitoring_system/Panel/Employee/Url%20Tracking/UrlTrackingController.dart';
import 'package:employee_monitoring_system/Resources/AppSizes.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UrlTrackingWidget extends StatelessWidget {
  const UrlTrackingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final UrlTrackingController controller = Get.find<UrlTrackingController>();
    final bool webMode = AppSizes.isWeb(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDateSelectorBar(context, controller),
        const SizedBox(height: 20),
        _buildStatsGrid(context, webMode, controller),
        const SizedBox(height: 20),
        _buildUrlBrowseSection(context, webMode, controller),
        const SizedBox(height: 20),
        _buildDailyTrackingTable(context, webMode, controller),
      ],
    );
  }

   /// ------------- Extra Widget --------------- ///

  //  Date Selector Bar
  Widget _buildDateSelectorBar(BuildContext context, UrlTrackingController controller) {
    final RxBool isDropdownOpen = false.obs;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: isMobile ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              SvgPicture.asset(
                IconString.calendarIcon,
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.subtextColor,
                  BlendMode.srcIn,
                ),
              ),
              Obx(() {
                final bool isMonthMode = controller.selectedViewIndex.value == 2;
                return Text(
                  isMonthMode ? TextString.selectedMonth : TextString.selectedDate,
                  style: TTextTheme.titleSeven(context).copyWith(fontSize: 13),
                );
              }),
              Obx(() => Text(
                controller.selectedDateStr.value,
                style: TTextTheme.FieldWriteTheText(context).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )),
            ],
          ),
          if (isMobile) const SizedBox(height: 12),
          Obx(() {
            final bool isMonthMode = controller.selectedViewIndex.value == 2;

            if (isMonthMode) {
              final DateTime currentDate = controller.currentSelectedDate.value;
              final String currentMonth = DateFormat('MMMM').format(currentDate);

              return PopupMenuButton<String>(
                constraints: BoxConstraints(
                  minWidth: isMobile ? screenWidth - 60 : 120,
                  maxWidth: isMobile ? screenWidth - 60 : 140,
                  maxHeight: 350,
                ),
                offset: const Offset(0, 42),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: AppColors.whiteColor,
                elevation: 4,
                onOpened: () => isDropdownOpen.value = true,
                onCanceled: () => isDropdownOpen.value = false,
                onSelected: (String val) {
                  controller.updateSelectedMonth(val);
                  isDropdownOpen.value = false;
                },
                child: Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 10),
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderColor, width: 1.2),
                  ),
                  child: Row(
                    mainAxisAlignment: isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                    mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                    children: [
                      Text(
                        currentMonth,
                        style: TTextTheme.InsideAlreadyWrittenText(context).copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        isDropdownOpen.value ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textColor,
                        size: 18,
                      ),
                    ],
                  ),
                )),
                itemBuilder: (BuildContext context) {
                  return controller.monthsList.map((String month) {
                    final bool isSelected = month == currentMonth;
                    return PopupMenuItem<String>(
                      value: month,
                      height: 40,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryColor.withValues(alpha: 0.08) : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          month,
                          style: TTextTheme.titleSeven(context).copyWith(
                            color: isSelected ? AppColors.primaryColor : AppColors.textColor,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }).toList();
                },
              );
            } else {
              return OutlinedButton(
                onPressed: () {
                  final DateTime currentDate = controller.currentSelectedDate.value;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: CustomDatePickerUrlDialog(
                          initialDate: currentDate,
                          isWeekMode: controller.selectedViewIndex.value == 1,
                          onCancel: () => Navigator.pop(context),
                          onDateSelected: (DateTime selectedDate, DateTimeRange? weekRange) {
                            controller.updateSelectedDate(
                              selectedDate,
                              weekRange,
                              controller.selectedViewIndex.value == 1,
                            );
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.borderColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      IconString.calendarIcon,
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        AppColors.subtextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      TextString.pickDateTitle,
                      style: TTextTheme.InsideAlreadyWrittenText(context).copyWith(fontSize: 12),
                    ),
                  ],
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  //  Stat Grids
  Widget _buildStatsGrid(BuildContext context, bool webMode, UrlTrackingController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        int crossAxisCount = 1;
        if (width > 1100) {
          crossAxisCount = 5;
        } else if (width > 800) {
          crossAxisCount = 3;
        } else if (width > 500) {
          crossAxisCount = 2;
        }

        double childAspectRatio = 2.2;
        if (width < 320) {
          childAspectRatio = 1.7;
        } else if (width < 400) {
          childAspectRatio = 1.9;
        } else if (width > 1100) {
          childAspectRatio = 1.9;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.topCards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            final card = controller.topCards[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        card['icon'],
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(card['color'], BlendMode.srcIn),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          card['title'],
                          style: TTextTheme.titleSeven(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      card['value'],
                      style: TTextTheme.h3Style(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    card['sub'],
                    style: TTextTheme.Numbers(context).copyWith(
                      color: card['isPositive'] ? AppColors.approvedColor : AppColors.subtextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  //  Url Browse Section
  Widget _buildUrlBrowseSection(BuildContext context, bool webMode, UrlTrackingController controller) {
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
          Text(TextString.urlBrowsingText, style: TTextTheme.titleEight(context)),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              bool useGrid = constraints.maxWidth > 650;

              if (useGrid) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.urlsData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 68,
                  ),
                  itemBuilder: (context, i) => _buildProgressRow(context, controller.urlsData[i]),
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.urlsData.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, i) => _buildProgressRow(context, controller.urlsData[i]),
                );
              }
            },
          ),
        ],
      ),
    );
  }
  Widget _buildProgressRow(BuildContext context, Map<String, dynamic> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item['name'], style: TTextTheme.titleFive(context)),
            Text(item['time'], style: TTextTheme.titleEight(context)),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: item['progress'],
          backgroundColor: AppColors.borderColor.withValues(alpha: 0.3),
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          minHeight: 6,
          borderRadius: BorderRadius.circular(10),
        ),
        const SizedBox(height: 4),
        Text(item['percentage'], style: TTextTheme.titleFour(context)),
      ],
    );
  }

  //  Daily Tracking Table
  Widget _buildDailyTrackingTable(BuildContext context, bool webMode, UrlTrackingController controller) {
    final tableWidget = Container(
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
            TextString.dailyTrackingTitle,
            style: TTextTheme.titleEight(context),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfScreenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Obx(() => Checkbox(
                    value: controller.isAllSelected.value,
                    onChanged: (val) => controller.toggleAllCheckboxes(val),
                    side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                    activeColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  )),
                ),
                const SizedBox(width: 12),
                Expanded(flex: 3, child: Text(TextString.url, style: TTextTheme.titleSeven(context))),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: AppColors.tertiaryTextColor),
                      const SizedBox(width: 4),
                      Text(TextString.totalTime, style: TTextTheme.titleSeven(context)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: AppColors.tertiaryTextColor),
                      const SizedBox(width: 4),
                      Text(TextString.timeByPercent, style: TTextTheme.titleSeven(context)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconString.comparisonIcon,
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(TextString.comparison, style: TTextTheme.titleSeven(context)),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
            final listState = controller.expandedIndices.toList();

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.urlsData.length,
              itemBuilder: (context, index) {
                final urlItem = controller.urlsData[index];
                final bool isOpen = listState.contains(index);

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.toggleExpansion(index);
                          controller.expandedIndices.refresh();
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: urlItem['isSelected'] ?? false,
                                  onChanged: (val) => controller.toggleUrlCheckbox(index, val),
                                  side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                                  activeColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 3,
                                child: Text(urlItem['name'] ?? '', style: TTextTheme.titleEight(context)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(urlItem['time'] ?? '', style: TTextTheme.titleFour(context)),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(urlItem['percentage'] ?? '', style: TTextTheme.titleFour(context)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      (urlItem['isUp'] ?? true) ? Icons.arrow_upward : Icons.arrow_downward,
                                      size: 14,
                                      color: (urlItem['isUp'] ?? true) ? AppColors.approvedColor : AppColors.rejectedColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${urlItem['compare']}",
                                      style: (urlItem['isUp'] ?? true) ? TTextTheme.upNumbers(context) : TTextTheme.downNumbers(context),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                color: AppColors.textColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isOpen)
                        Container(
                          padding: const EdgeInsets.only(left: 52, right: 40, bottom: 16, top: 4),
                          width: double.infinity,
                          color: AppColors.whiteColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TextString.dailyBrakdown,
                                style: TTextTheme.titleTen(context),
                              ),
                              const SizedBox(height: 8),
                              Builder(
                                builder: (ctx) {
                                  List<dynamic> targetBreakdown = [];
                                  if (controller.selectedViewIndex.value == 0) {
                                    targetBreakdown = urlItem['dayData'] ?? [];
                                  } else if (controller.selectedViewIndex.value == 1) {
                                    targetBreakdown = urlItem['weekData'] ?? [];
                                  } else {
                                    targetBreakdown = urlItem['monthData'] ?? [];
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: targetBreakdown.length,
                                    itemBuilder: (ctx, subIndex) {
                                      final currentDay = targetBreakdown[subIndex];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              currentDay['date'] ?? '',
                                              style: TTextTheme.DateBreakDown(context),
                                            ),
                                            currentDay['isHoliday'] == true
                                                ? Text(
                                              TextString.holiday,
                                              style: TTextTheme.titleTen(context),
                                            )
                                                : RichText(
                                              text: TextSpan(
                                                style: TTextTheme.TotalTimeHour(context),
                                                children: [
                                                  const TextSpan(text: TextString.totalSimpleText),
                                                  TextSpan(text: "${currentDay['total']}   ", style: TTextTheme.TotalTimeHour(context)),
                                                  const TextSpan(text: "High Activity: "),
                                                  TextSpan(text: "${currentDay['high']} ", style: TTextTheme.upNumbers(context)),
                                                  const TextSpan(text: ", Low Activity: "),
                                                  TextSpan(text: "${currentDay['low']}", style: TTextTheme.downNumbers(context)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 650) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(width: 650, child: tableWidget),
          );
        }
        return tableWidget;
      },
    );
  }
}