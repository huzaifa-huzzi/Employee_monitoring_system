import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ApplicationTrackingController extends GetxController {
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
      selectedDateStr.value = "1 Feb, 2026";
    }
  }

  final List<Map<String, dynamic>> topCards = [
    {'title': 'Total tracked time', 'value': '6hrs 24m', 'sub': '+ 8.7% vs last day', 'icon': IconString.idleTime, 'color': AppColors.primaryColor, 'isPositive': true},
    {'title': 'Active Time', 'value': '87%', 'sub': '+ 8.7% vs last day', 'icon': IconString.averageActivity, 'color':AppColors.approvedColor, 'isPositive': true},
    {'title': 'Idle Time', 'value': '45m', 'sub': '5% of the total time', 'icon': IconString.idleTime, 'color': AppColors.rejectedColor, 'isPositive': false},
    {'title': 'Application used', 'value': '6', 'sub': 'Across work hours', 'icon': IconString.applicationUsedIcon, 'color': AppColors.graphColor, 'isPositive': true},
    {'title': 'Productive time', 'value': '77%', 'sub': '+ 8.7% vs last day', 'icon': IconString.averageActivity, 'color': AppColors.approvedColor, 'isPositive': true},
  ];
  var appsData = <Map<String, dynamic>>[
    {
      'name': 'Figma', 'time': '48 hours', 'percentage': '80% of total time', 'progress': 0.8, 'compare': '12.3%', 'isUp': true, 'isSelected': false,
      'dayData': [
        {'date': '1 Feb,2026', 'isHoliday': false, 'total': '8hr 23m', 'high': '7hr 12m', 'low': '1hr 11m'}
      ],
      'weekData': [
        {'date': '1 Feb,2026', 'isHoliday': false, 'total': '8hr 23m', 'high': '7hr 12m', 'low': '1hr 11m'},
        {'date': '2 Feb,2026', 'isHoliday': false, 'total': '8hr 23m', 'high': '7hr 12m', 'low': '1hr 11m'},
        {'date': '3 Feb,2026', 'isHoliday': false, 'total': '8hr 23m', 'high': '7hr 12m', 'low': '1hr 11m'},
        {'date': '4 Feb,2026', 'isHoliday': false, 'total': '8hr 23m', 'high': '7hr 12m', 'low': '1hr 11m'},
        {'date': '5 Feb,2026', 'isHoliday': false, 'total': '8hr 23m', 'high': '7hr 12m', 'low': '1hr 11m'},
        {'date': '6 Feb,2026', 'isHoliday': true},
        {'date': '7 Feb,2026', 'isHoliday': true},
      ],
      'monthData': List.generate(29, (i) {
        int d = i + 1;
        bool isH = (d == 6 || d == 7 || d == 13 || d == 14 || d == 20 || d == 21 || d == 27 || d == 28);
        return {
          'date': '$d Feb,2026',
          'isHoliday': isH,
          'total': '8hr 23m',
          'high': '7hr 12m',
          'low': '1hr 11m'
        };
      })
    },
    {
      'name': 'Chrome', 'time': '30 minutes', 'percentage': '5% of total time', 'progress': 0.05, 'compare': '7.5%', 'isUp': true, 'isSelected': false,
      'dayData': [{'date': '1 Feb,2026', 'isHoliday': false, 'total': '0hr 30m', 'high': '0hr 20m', 'low': '0hr 10m'}],
      'weekData': List.generate(7, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i>=5), 'total': '0hr 30m', 'high': '0hr 20m', 'low': '0hr 10m'}),
      'monthData': List.generate(29, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i%7==5 || i%7==6), 'total': '0hr 30m', 'high': '0hr 20m', 'low': '0hr 10m'})
    },
    {
      'name': 'Slack', 'time': '30 minutes', 'percentage': '5% of total time', 'progress': 0.05, 'compare': '2.1%', 'isUp': false, 'isSelected': false,
      'dayData': [{'date': '1 Feb,2026', 'isHoliday': false, 'total': '0hr 30m', 'high': '0hr 20m', 'low': '0hr 10m'}],
      'weekData': List.generate(7, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i>=5), 'total': '0hr 30m', 'high': '0hr 20m', 'low': '0hr 10m'}),
      'monthData': List.generate(29, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i%7==5 || i%7==6), 'total': '0hr 30m', 'high': '0hr 20m', 'low': '0hr 10m'})
    },
    {
      'name': 'Photoshop', 'time': '10 minutes', 'percentage': '1% of total time', 'progress': 0.01, 'compare': '0.5%', 'isUp': true, 'isSelected': false,
      'dayData': [{'date': '1 Feb,2026', 'isHoliday': false, 'total': '0hr 10m', 'high': '0hr 08m', 'low': '0hr 02m'}],
      'weekData': List.generate(7, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i>=5), 'total': '0hr 10m', 'high': '0hr 08m', 'low': '0hr 02m'}),
      'monthData': List.generate(29, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i%7==5 || i%7==6), 'total': '0hr 10m', 'high': '0hr 08m', 'low': '0hr 02m'})
    },
    {
      'name': 'Hub staff', 'time': '20 minutes', 'percentage': '3% of total time', 'progress': 0.03, 'compare': '1.2%', 'isUp': true, 'isSelected': false,
      'dayData': [{'date': '1 Feb,2026', 'isHoliday': false, 'total': '0hr 20m', 'high': '0hr 15m', 'low': '0hr 05m'}],
      'weekData': List.generate(7, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i>=5), 'total': '0hr 20m', 'high': '0hr 15m', 'low': '0hr 05m'}),
      'monthData': List.generate(29, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i%7==5 || i%7==6), 'total': '0hr 20m', 'high': '0hr 15m', 'low': '0hr 05m'})
    },
    {
      'name': 'Vs Code', 'time': '30 minutes', 'percentage': '6% of total time', 'progress': 0.06, 'compare': '4.3%', 'isUp': false, 'isSelected': false,
      'dayData': [{'date': '1 Feb,2026', 'isHoliday': false, 'total': '0hr 30m', 'high': '0hr 25m', 'low': '0hr 05m'}],
      'weekData': List.generate(7, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i>=5), 'total': '0hr 30m', 'high': '0hr 25m', 'low': '0hr 05m'}),
      'monthData': List.generate(29, (i) => {'date': '${i+1} Feb,2026', 'isHoliday': (i%7==5 || i%7==6), 'total': '0hr 30m', 'high': '0hr 25m', 'low': '0hr 05m'})
    },
  ].obs;

  void toggleAppCheckbox(int index, bool? val) {
    if (val != null) {
      appsData[index]['isSelected'] = val;
      appsData.refresh();
      isAllSelected.value = appsData.every((element) => element['isSelected'] == true);
    }
  }

  void toggleAllCheckboxes(bool? val) {
    if (val != null) {
      isAllSelected.value = val;
      for (var app in appsData) {
        app['isSelected'] = val;
      }
      appsData.refresh();
    }
  }
}