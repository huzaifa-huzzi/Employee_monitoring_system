
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UrlTrackingController extends GetxController {
  var selectedViewIndex = 0.obs;
  var selectedDateStr = "".obs;
  var currentSelectedDate = DateTime.now().obs;
  var currentWeekRange = Rxn<DateTimeRange>();

  var isAllSelected = false.obs;
  var expandedIndices = <int>[].obs;

  final List<String> monthsList = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  @override
  void onInit() {
    super.onInit();
    _updateDisplayFormat();
  }

  void toggleView(int index) {
    selectedViewIndex.value = index;
    _updateDisplayFormat();
  }

  void toggleExpansion(int index) {
    if (expandedIndices.contains(index)) {
      expandedIndices.remove(index);
    } else {
      expandedIndices.add(index);
    }
  }

  void updateSelectedDate(DateTime date, DateTimeRange? range, bool isWeekMode) {
    currentSelectedDate.value = date;
    if (isWeekMode && range != null) {
      currentWeekRange.value = range;
    }
    _updateDisplayFormat();
  }

  void updateSelectedMonth(String monthName) {
    int monthIndex = monthsList.indexOf(monthName) + 1;
    currentSelectedDate.value = DateTime(currentSelectedDate.value.year, monthIndex, 1);
    _updateDisplayFormat();
  }

  void _updateDisplayFormat() {
    if (selectedViewIndex.value == 1) {
      selectedDateStr.value = "1 Feb, 2026 - 7 Feb, 2026";
    } else if (selectedViewIndex.value == 2) {
      selectedDateStr.value = DateFormat('MMMM, yyyy').format(currentSelectedDate.value);
    } else {
      selectedDateStr.value = DateFormat('d MMM, yyyy').format(currentSelectedDate.value);
    }
  }

  final List<Map<String, dynamic>> topCards = [
    {'title': 'Total tracked time', 'value': '1hr 24m', 'sub': '↑ 8.7% vs last day', 'icon': IconString.idleTime, 'color': AppColors.primaryColor, 'isPositive': true},
    {'title': 'Active Time', 'value': '87%', 'sub': '↑ 8.7% vs last day', 'icon': IconString.averageActivity, 'color': AppColors.approvedColor, 'isPositive': true},
    {'title': 'Idle Time', 'value': '10m', 'sub': '5% of the total time', 'icon': IconString.idleTime, 'color': AppColors.rejectedColor, 'isPositive': false},
    {'title': 'Url used', 'value': '4', 'sub': 'Across work hours', 'icon': IconString.urlICon, 'color': AppColors.graphColor, 'isPositive': true},
    {'title': 'Productive time', 'value': '77%', 'sub': '↑ 8.7% vs last day', 'icon': IconString.averageActivity, 'color': AppColors.approvedColor, 'isPositive': true},
  ];

  var urlsData = <Map<String, dynamic>>[
    {
      'name': 'Google docs', 'time': '40 minutes', 'percentage': '80% of total time', 'progress': 0.8, 'compare': '12.3%', 'isUp': true, 'isSelected': false,
      'dayData': [{'date': '3 Feb,2026', 'isHoliday': false, 'total': '0hr 40m', 'high': '0hr 30m', 'low': '0hr 10m'}],
      'weekData': List.generate(7, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i>=5), 'total': '0hr 40m', 'high': '0hr 30m', 'low': '0hr 10m'}),
      'monthData': List.generate(29, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i%7==5 || i%7==6), 'total': '0hr 40m', 'high': '0hr 30m', 'low': '0hr 10m'})
    },
    {
      'name': 'Behance', 'time': '10 minutes', 'percentage': '10% of total time', 'progress': 0.1, 'compare': '7.56%', 'isUp': true, 'isSelected': false,
      'dayData': [{'date': '3 Feb,2026', 'isHoliday': false, 'total': '0hr 10m', 'high': '0hr 08m', 'low': '0hr 02m'}],
      'weekData': List.generate(7, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i>=5), 'total': '0hr 10m', 'high': '0hr 08m', 'low': '0hr 02m'}),
      'monthData': List.generate(29, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i%7==5 || i%7==6), 'total': '0hr 10m', 'high': '0hr 08m', 'low': '0hr 02m'})
    },
    {
      'name': 'Chat Gpt', 'time': '05 minutes', 'percentage': '5% of total time', 'progress': 0.05, 'compare': '2.45%', 'isUp': true, 'isSelected': false,
      'dayData': [{'date': '3 Feb,2026', 'isHoliday': false, 'total': '0hr 05m', 'high': '0hr 04m', 'low': '0hr 01m'}],
      'weekData': List.generate(7, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i>=5), 'total': '0hr 05m', 'high': '0hr 04m', 'low': '0hr 01m'}),
      'monthData': List.generate(29, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i%7==5 || i%7==6), 'total': '0hr 05m', 'high': '0hr 04m', 'low': '0hr 01m'})
    },
    {
      'name': 'Hubstaff.com', 'time': '05 minutes', 'percentage': '5% of total time', 'progress': 0.05, 'compare': '2.3%', 'isUp': false, 'isSelected': false,
      'dayData': [{'date': '3 Feb,2026', 'isHoliday': false, 'total': '0hr 05m', 'high': '0hr 03m', 'low': '0hr 02m'}],
      'weekData': List.generate(7, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i>=5), 'total': '0hr 05m', 'high': '0hr 03m', 'low': '0hr 02m'}),
      'monthData': List.generate(29, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i%7==5 || i%7==6), 'total': '0hr 05m', 'high': '0hr 03m', 'low': '0hr 02m'})
    },
  ].obs;

  void toggleUrlCheckbox(int index, bool? val) {
    if (val != null) {
      urlsData[index]['isSelected'] = val;
      urlsData.refresh();
      isAllSelected.value = urlsData.every((element) => element['isSelected'] == true);
    }
  }

  void toggleAllCheckboxes(bool? val) {
    if (val != null) {
      isAllSelected.value = val;
      for (var url in urlsData) {
        url['isSelected'] = val;
      }
      urlsData.refresh();
    }
  }
}