import 'package:employee_monitoring_system/ActivityTracking/ActivityTrackingController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MonthlyActivityGraphWidget extends StatelessWidget {
  final ActivityController controller;

  const MonthlyActivityGraphWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

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
          Text(
           TextString.monthlyTitle,
            style: TTextTheme.titleOne(context).copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            TextString.monthlySubtitle,
            style: TTextTheme.titleSeven(context).copyWith(color: AppColors.tertiaryTextColor),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildLegendItem(context, TextString.highActivity, AppColors.approvedColor),
                const SizedBox(width: 16),
                _buildLegendItem(context, TextString.lowActivity, AppColors.pendingColor),
                const SizedBox(width: 16),
                _buildLegendItem(context, TextString.idleTime, AppColors.borderColor),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    TextString.activityPercent,
                    style: TextStyle(
                      color: AppColors.tertiaryTextColor.withValues(alpha: 0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: isMobile
                    ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    width: 450,
                    height: 250,
                    child: _buildMonthlyBarChart(context),
                  ),
                )
                    : SizedBox(
                  height: 250,
                  child: _buildMonthlyBarChart(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

   /// ------------ Extra Widget ----------///
  // Montly chart
  Widget _buildMonthlyBarChart(BuildContext context) {
    return Obx(() {
      return BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                interval: 20,
                getTitlesWidget: (value, meta) {
                  return Text(
                    "${value.toInt()}-",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < controller.monthlyGraphData.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        controller.monthlyGraphData[index].day,
                        style: const TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: controller.monthlyGraphData.asMap().entries.map((entry) {
            int index = entry.key;
            var data = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data.percentage > 100 ? 100 : data.percentage,
                  color: data.color,
                  width: 32,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            );
          }).toList(),
        ),
      );
    });
  }

   // Legend Item
  Widget _buildLegendItem(BuildContext context, String title, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: TTextTheme.titleSeven(context).copyWith(
            fontSize: 12,
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}