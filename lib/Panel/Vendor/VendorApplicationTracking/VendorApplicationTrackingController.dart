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
  RxBool isSelected;

  EmployeeModel({
    required this.name,
    required this.email,
    required this.topApp,
    required this.usageTime,
    required this.usage,
    required this.appUsed,
    bool isSelected = false,
  }) : isSelected = isSelected.obs;
}

class TeamModel {
  final String name;
  final int membersCount;
  final String topApp;
  final String usageTime;
  final String usage;
  final int appUsed;
  RxBool isSelected;

  TeamModel({
    required this.name,
    required this.membersCount,
    required this.topApp,
    required this.usageTime,
    required this.usage,
    required this.appUsed,
    bool isSelected = false,
  }) : isSelected = isSelected.obs;
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
  var isDetailView = false.obs;
  var isTeamEmployeeView = false.obs;

  var selectedFilter = 'Day'.obs;
  var searchQuery = ''.obs;
  var searchTeamEmployeeQuery = ''.obs;
  var currentPage = 1.obs;
  var totalPages = 10.obs;

  var selectedEmployee = Rxn<EmployeeModel>();
  var selectedTeam = Rxn<TeamModel>();
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

  void nextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  // Employees Section
  var isAllSelected = false.obs;

  var employeesList = <EmployeeModel>[
    EmployeeModel(name: 'Jack Wilson', email: 'jack@gmail.com', topApp: 'Figma', usageTime: '6hrs 10mints', usage: '75%', appUsed: 6),
    EmployeeModel(name: 'Ayan Ali', email: 'ayan@gmail.com', topApp: 'Vs Code', usageTime: '6hrs 10mints', usage: '75%', appUsed: 6),
    EmployeeModel(name: 'Talha bukhari', email: 'talha@gmail.com', topApp: 'Jira', usageTime: '5hrs 40mints', usage: '65%', appUsed: 6),
    EmployeeModel(name: 'Jack Wilson', email: 'jack@gmail.com', topApp: 'Figma', usageTime: '6hrs 10mints', usage: '75%', appUsed: 6),
    EmployeeModel(name: 'Jhon Doe', email: 'jhon@gmail.com', topApp: 'Vs Code', usageTime: '7hrs 10mints', usage: '80%', appUsed: 6),
  ].obs;

  void toggleAllSelection(bool? value) {
    bool val = value ?? false;
    isAllSelected.value = val;
    for (var emp in employeesList) {
      emp.isSelected.value = val;
    }
  }

  void toggleSingleSelection(int index, bool? value) {
    employeesList[index].isSelected.value = value ?? false;
    isAllSelected.value = employeesList.every((emp) => emp.isSelected.value);
  }

  void openEmployeeDetail(EmployeeModel employee) {
    selectedEmployee.value = employee;
    isDetailView.value = true;
  }

  void closeEmployeeDetail() {
    isDetailView.value = false;
    selectedEmployee.value = null;
  }

   // Team Data
  var isAllTeamSelected = false.obs;

  var teamsList = <TeamModel>[
    TeamModel(name: 'Ui Ux', membersCount: 10, topApp: 'Figma', usageTime: '60hrs 10mints', usage: '65%', appUsed: 8),
    TeamModel(name: 'Front End', membersCount: 10, topApp: 'Vs Code', usageTime: '60hrs 10mints', usage: '65%', appUsed: 8),
    TeamModel(name: 'Back End', membersCount: 10, topApp: 'Vs Code', usageTime: '60hrs 10mints', usage: '65%', appUsed: 8),
    TeamModel(name: 'QA', membersCount: 10, topApp: 'Google Chrome', usageTime: '60hrs 10mints', usage: '65%', appUsed: 8),
    TeamModel(name: 'AI Engineer', membersCount: 10, topApp: 'Vs Code', usageTime: '60hrs 10mints', usage: '65%', appUsed: 8),
    TeamModel(name: 'Ui Ux', membersCount: 10, topApp: 'Figma', usageTime: '60hrs 10mints', usage: '65%', appUsed: 8),
    TeamModel(name: 'Front End', membersCount: 10, topApp: 'Vs Code', usageTime: '60hrs 10mints', usage: '65%', appUsed: 8),
    TeamModel(name: 'Back End', membersCount: 10, topApp: 'Vs Code', usageTime: '60hrs 10mints', usage: '65%', appUsed: 8),
  ].obs;

  void toggleAllTeamSelection(bool? value) {
    bool val = value ?? false;
    isAllTeamSelected.value = val;
    for (var team in teamsList) {
      team.isSelected.value = val;
    }
  }

  void toggleTeamSelection(int index, bool? value) {
    teamsList[index].isSelected.value = value ?? false;
    isAllTeamSelected.value = teamsList.every((team) => team.isSelected.value);
  }

  void openTeamEmployeesView(TeamModel team) {
    selectedTeam.value = team;
    isTeamEmployeeView.value = true;
  }
  var isAllTeamEmpSelected = false.obs;

  var teamEmployeesList = <EmployeeModel>[
    EmployeeModel(name: 'Jack Milson', email: 'jack@gmail.com', topApp: 'Figma', usageTime: '6hrs 10mints', usage: '75%', appUsed: 8),
    EmployeeModel(name: 'Ayan Ali', email: 'ayan@gmail.com', topApp: 'Vs Code', usageTime: '6hrs 10mints', usage: '75%', appUsed: 6),
    EmployeeModel(name: 'Talha bukhari', email: 'talha@gmail.com', topApp: 'Jira', usageTime: '5hrs 40mints', usage: '65%', appUsed: 8),
    EmployeeModel(name: 'Jack Milson', email: 'jack@gmail.com', topApp: 'Figma', usageTime: '6hrs 10mints', usage: '75%', appUsed: 8),
    EmployeeModel(name: 'Jhon Doe', email: 'jhon@gmail.com', topApp: 'Vs Code', usageTime: '7hrs 10mints', usage: '80%', appUsed: 6),
    EmployeeModel(name: 'Talha bukhari', email: 'talha@gmail.com', topApp: 'Vs Code', usageTime: '6hrs 50mints', usage: '78%', appUsed: 6),
  ].obs;

  void toggleAllTeamEmpSelection(bool? value) {
    bool val = value ?? false;
    isAllTeamEmpSelected.value = val;
    for (var emp in teamEmployeesList) {
      emp.isSelected.value = val;
    }
  }

  void toggleTeamEmpSelection(int index, bool? value) {
    teamEmployeesList[index].isSelected.value = value ?? false;
    isAllTeamEmpSelected.value = teamEmployeesList.every((emp) => emp.isSelected.value);
  }

  void openEmployeeDetailFromTeam(EmployeeModel employee) {
    selectedEmployee.value = employee;
    isDetailView.value = true;
  }

   // Detailed Side
  var isAllAppsSelected = false.obs;

  var detailedAppList = <AppTrackingDetailModel>[
    AppTrackingDetailModel(appName: 'Figma', dailyTime: '6hrs 10mints', weeklyTime: '36hours', last4WeekTime: '132 hours', usagePercentage: '80% of total time', progress: 0.80, comparison: '12.3%', isIncrease: true),
    AppTrackingDetailModel(appName: 'Chrome', dailyTime: '30 minutes', weeklyTime: '4hours 10mints', last4WeekTime: '16 hours', usagePercentage: '5% of total time', progress: 0.70, comparison: '7.56%', isIncrease: true),
    AppTrackingDetailModel(appName: 'Slack', dailyTime: '30 minutes', weeklyTime: '4hours 10mints', last4WeekTime: '16 hours', usagePercentage: '5% of total time', progress: 0.70, comparison: '2.45%', isIncrease: true),
    AppTrackingDetailModel(appName: 'Photoshop', dailyTime: '10 minutes', weeklyTime: '1 hour 5mints', last4WeekTime: '4 hour', usagePercentage: '1% of total time', progress: 0.70, comparison: '2.3%', isIncrease: false),
    AppTrackingDetailModel(appName: 'Hub Staff', dailyTime: '20 minutes', weeklyTime: '2hour 10mints', last4WeekTime: '6 hour', usagePercentage: '3% of total time', progress: 0.70, comparison: '5.3%', isIncrease: true),
    AppTrackingDetailModel(appName: 'Vs Code', dailyTime: '30 minutes', weeklyTime: '3hour 5mints', last4WeekTime: '8 hour', usagePercentage: '6% of total time', progress: 0.70, comparison: '6.3%', isIncrease: false),
  ].obs;

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
  }
}