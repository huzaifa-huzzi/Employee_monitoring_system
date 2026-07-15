import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class SessionBreakdownModel {
  String timeSlot;
  String mousePercentage;
  String keyboardPercentage;
  String idlePercentage;
  String overallPercentage;
  bool isSelected;

  SessionBreakdownModel({
    required this.timeSlot,
    required this.mousePercentage,
    required this.keyboardPercentage,
    required this.idlePercentage,
    required this.overallPercentage,
    this.isSelected = false,
  });
}

class WeeklyGraphDataModel {
  final String day;
  final double percentage;
  final Color color;

  WeeklyGraphDataModel({
    required this.day,
    required this.percentage,
    required this.color,
  });
}

class ActivityController extends GetxController {
  var selectedViewIndex = 0.obs;

  var selectedDateStr = "".obs;
  var currentSelectedDate = DateTime.now().obs;
  var currentWeekRange = Rxn<DateTimeRange>();

  var isAllSelected = false.obs;

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

    if (index == 1 && currentWeekRange.value == null) {
      currentWeekRange.value = _getWeekRange(currentSelectedDate.value);
    }

    _updateDisplayFormat();
  }
  void updateSelectedDate(DateTime date, DateTimeRange? range, bool isWeekMode) {
    currentSelectedDate.value = date;
    if (isWeekMode && range != null) {
      currentWeekRange.value = range;
    } else {
      currentWeekRange.value = _getWeekRange(date);
    }
    _updateDisplayFormat();
  }

  void updateSelectedMonth(String monthName) {
    int monthIndex = monthsList.indexOf(monthName) + 1;
    currentSelectedDate.value = DateTime(currentSelectedDate.value.year, monthIndex, 1);
    currentWeekRange.value = _getWeekRange(currentSelectedDate.value);
    _updateDisplayFormat();
  }
  DateTimeRange _getWeekRange(DateTime date) {
    int currentDayOfWeek = date.weekday;
    DateTime startOfWeek = date.subtract(Duration(days: currentDayOfWeek - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
    return DateTimeRange(
      start: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
      end: DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day),
    );
  }

  var weeklyGraphData = <WeeklyGraphDataModel>[
    WeeklyGraphDataModel(day: "Mon", percentage: 80, color: const Color(0xFF10B981)),
    WeeklyGraphDataModel(day: "Tue", percentage: 55, color: const Color(0xFF10B981)),
    WeeklyGraphDataModel(day: "Wed", percentage: 100, color: const Color(0xFF10B981)),
    WeeklyGraphDataModel(day: "Thu", percentage: 90, color: const Color(0xFFFBBF24)),
    WeeklyGraphDataModel(day: "Fri", percentage: 62, color: const Color(0xFF10B981)),
    WeeklyGraphDataModel(day: "Sat", percentage: 94, color: const Color(0xFFD1D5DB)),
    WeeklyGraphDataModel(day: "Sun", percentage: 86, color: const Color(0xFFD1D5DB)),
  ].obs;
  var monthlyGraphData = <WeeklyGraphDataModel>[
    WeeklyGraphDataModel(day: "Week 1", percentage: 80, color: const Color(0xFF10B981)),
    WeeklyGraphDataModel(day: "Week 2", percentage: 51, color: const Color(0xFF10B981)),
    WeeklyGraphDataModel(day: "Week 3", percentage: 105, color: const Color(0xFF10B981)), // Max 100 se thoda upar ya 100 tak rakhein
    WeeklyGraphDataModel(day: "Week 4", percentage: 91, color: const Color(0xFFFBBF24)),
  ].obs;

  void _updateDisplayFormat() {
    if (selectedViewIndex.value == 1) {
      final range = currentWeekRange.value ??
          _getWeekRange(currentSelectedDate.value);
      String start = DateFormat('d MMM, yyyy').format(range.start);
      String end = DateFormat('d MMM, yyyy').format(range.end);
      selectedDateStr.value = "$start - $end";
    } else if (selectedViewIndex.value == 2) {
      selectedDateStr.value =
          DateFormat('MMM, yyyy').format(currentSelectedDate.value);
    } else {
      selectedDateStr.value =
          DateFormat('d MMM, yyyy').format(currentSelectedDate.value);
    }
  }

  void toggleItemCheckbox(int index, bool? val) {
    sessionList[index].isSelected = val ?? false;
    sessionList.refresh();
    isAllSelected.value = sessionList.every((element) => element.isSelected);
  }

  void toggleAllCheckboxes(bool? val) {
    isAllSelected.value = val ?? false;
    for (var item in sessionList) {
      item.isSelected = isAllSelected.value;
    }
    sessionList.refresh();
  }
  var sessionList = <SessionBreakdownModel>[
    SessionBreakdownModel(
      timeSlot: "09:00 AM - 10:00 AM",
      mousePercentage: "85%",
      keyboardPercentage: "70%",
      idlePercentage: "15%",
      overallPercentage: "78%",
      isSelected: false,
    ),
    SessionBreakdownModel(
      timeSlot: "10:00 AM - 11:00 AM",
      mousePercentage: "40%",
      keyboardPercentage: "30%",
      idlePercentage: "60%",
      overallPercentage: "60%",
      isSelected: false,
    ),
    SessionBreakdownModel(
      timeSlot: "11:00 AM - 12:00 PM",
      mousePercentage: "90%",
      keyboardPercentage: "85%",
      idlePercentage: "5%",
      overallPercentage: "95%",
      isSelected: false,
    ),
  ].obs;


}