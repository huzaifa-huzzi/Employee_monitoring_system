import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeeModel {
  final String name;
  final String email;
  final String topApp;
  final String usageTime;
  final String usage;
  final int appUsed;
  bool isSelected;

  EmployeeModel({
    required this.name,
    required this.email,
    required this.topApp,
    required this.usageTime,
    required this.usage,
    required this.appUsed,
    this.isSelected = false,
  });
}

class AppTrackingDetailModel {
  final String appName;
  final String dailyTime;
  final String weeklyTime;
  final String last4WeekTime;
  final double progress;
  final String usagePercentage;
  final String comparison;
  final bool isIncrease;
  late RxBool isSelected;

  AppTrackingDetailModel({
    required this.appName,
    required this.dailyTime,
    required this.weeklyTime,
    required this.last4WeekTime,
    required this.progress,
    required this.usagePercentage,
    required this.comparison,
    required this.isIncrease,
    bool isSelected = false,
  }) {
    this.isSelected = isSelected.obs;
  }
}

class VendorApplicationTrackingController extends GetxController {
  var isEmployeesTab = true.obs;
  var selectedFilter = 'Day'.obs;
  var searchQuery = ''.obs;

  var currentPage = 1.obs;
  var totalPages = 10.obs;

  var isAllSelected = false.obs;
  var isDetailView = false.obs;
  var selectedEmployee = Rxn<EmployeeModel>();


  var selectedDate = DateTime.now().obs;
  var selectedWeekRange = Rxn<DateTimeRange>();

  @override
  void onInit() {
    super.onInit();
    updateWeekRanges(selectedDate.value);
  }

  void updateWeekRanges(DateTime date) {
    selectedDate.value = date;
    int currentDayOfWeek = date.weekday;

    DateTime startOfWeek = date.subtract(Duration(days: currentDayOfWeek - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    selectedWeekRange.value = DateTimeRange(
      start: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
      end: DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day),
    );
  }

  String get formattedDateText {
    if (selectedFilter.value == 'Day') {
      return DateFormat('d MMMM, yyyy').format(selectedDate.value);
    } else if (selectedFilter.value == 'Week') {
      if (selectedWeekRange.value == null) return '';
      final start = DateFormat('d MMM').format(selectedWeekRange.value!.start);
      final end = DateFormat('d MMM, yyyy').format(selectedWeekRange.value!.end);
      return '$start - $end';
    } else {
      if (selectedWeekRange.value == null) return '';
      DateTime start4Weeks = selectedWeekRange.value!.end.subtract(const Duration(days: 27));
      final start = DateFormat('d MMM').format(start4Weeks);
      final end = DateFormat('d MMM, yyyy').format(selectedWeekRange.value!.end);
      return '$start - $end';
    }
  }

  void navigateDate(bool isNext) {
    int factor = isNext ? 1 : -1;
    if (selectedFilter.value == 'Day') {
      updateWeekRanges(selectedDate.value.add(Duration(days: factor)));
    } else if (selectedFilter.value == 'Week') {
      updateWeekRanges(selectedDate.value.add(Duration(days: 7 * factor)));
    } else {
      updateWeekRanges(selectedDate.value.add(Duration(days: 28 * factor)));
    }
  }

  void openEmployeeDetail(EmployeeModel employee) {
    selectedEmployee.value = employee;
    isDetailView.value = true;
  }

  void closeEmployeeDetail() {
    isDetailView.value = false;
    selectedEmployee.value = null;
  }

  var employeesList = <EmployeeModel>[
    EmployeeModel(name: 'Jack Wilson', email: 'jack@gmail.com', topApp: 'Figma', usageTime: '6hrs 10mints', usage: '75%', appUsed: 6),
    EmployeeModel(name: 'Ayan Ali', email: 'ayan@gmail.com', topApp: 'Vs Code', usageTime: '6hrs 10mints', usage: '75%', appUsed: 6),
    EmployeeModel(name: 'Talha bukhari', email: 'talha@gmail.com', topApp: 'Jira', usageTime: '5hrs 40mints', usage: '65%', appUsed: 6),
    EmployeeModel(name: 'Jack Wilson', email: 'jack@gmail.com', topApp: 'Figma', usageTime: '6hrs 10mints', usage: '75%', appUsed: 6),
    EmployeeModel(name: 'Jhon Doe', email: 'jhon@gmail.com', topApp: 'Vs Code', usageTime: '7hrs 10mints', usage: '80%', appUsed: 6),
  ].obs;

  var detailedAppList = <AppTrackingDetailModel>[
    AppTrackingDetailModel(appName: 'Figma', dailyTime: '6hrs 10mints', weeklyTime: '36hours', last4WeekTime: '132 hours', usagePercentage: '80% of total time', progress: 0.80, comparison: '12.3%', isIncrease: true),
    AppTrackingDetailModel(appName: 'Chrome', dailyTime: '30 minutes', weeklyTime: '4hours 10mints', last4WeekTime: '16 hours', usagePercentage: '5% of total time', progress: 0.70, comparison: '7.56%', isIncrease: true),
    AppTrackingDetailModel(appName: 'Slack', dailyTime: '30 minutes', weeklyTime: '4hours 10mints', last4WeekTime: '16 hours', usagePercentage: '5% of total time', progress: 0.70, comparison: '2.45%', isIncrease: true),
    AppTrackingDetailModel(appName: 'Photoshop', dailyTime: '10 minutes', weeklyTime: '1 hour 5mints', last4WeekTime: '4 hour', usagePercentage: '1% of total time', progress: 0.70, comparison: '2.3%', isIncrease: false),
    AppTrackingDetailModel(appName: 'Hub Staff', dailyTime: '20 minutes', weeklyTime: '2hour 10mints', last4WeekTime: '6 hour', usagePercentage: '3% of total time', progress: 0.70, comparison: '5.3%', isIncrease: true),
    AppTrackingDetailModel(appName: 'Vs Code', dailyTime: '30 minutes', weeklyTime: '3hour 5mints', last4WeekTime: '8 hour', usagePercentage: '6% of total time', progress: 0.70, comparison: '6.3%', isIncrease: false),
  ].obs;

  void toggleAllSelection(bool? value) {
    isAllSelected.value = value ?? false;
    for (var emp in employeesList) {
      emp.isSelected = isAllSelected.value;
    }
    employeesList.refresh();
  }

  void toggleSingleSelection(int index, bool? value) {
    employeesList[index].isSelected = value ?? false;
    isAllSelected.value = employeesList.every((emp) => emp.isSelected);
    employeesList.refresh();
  }

  var isAllAppsSelected = false.obs;

  void toggleAllAppsSelection(bool? value) {
    bool val = value ?? false;
    isAllAppsSelected.value = val;
    for (var app in detailedAppList) {
      app.isSelected.value = val;
    }
  }

  void toggleAppSelection(int index, bool? value) {
    bool val = value ?? false;
    detailedAppList[index].isSelected.value = val;

    isAllAppsSelected.value = detailedAppList.every((app) => app.isSelected.value);

    detailedAppList.refresh();
  }
}