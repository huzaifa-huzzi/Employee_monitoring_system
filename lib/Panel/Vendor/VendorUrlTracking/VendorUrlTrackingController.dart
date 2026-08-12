import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class VendorUrlController extends GetxController {
  // -----------------------------------------------------------------------------
  // TAB & GLOBAL CONTROLS
  // -----------------------------------------------------------------------------
  var selectedTab = 'Employees'.obs;
  var selectedTimeFilter = 'Day'.obs;
  var currentPage = 1.obs;
  var totalPages = 5.obs;

  // Global Navigation Reset Function
  void changeTab(String tab) {
    selectedTab.value = tab;
    isDetailView.value = false;
    isTeamEmpView.value = false;
  }

  // -----------------------------------------------------------------------------
  // EMPLOYEES TAB DATA & ACTIONS
  // -----------------------------------------------------------------------------
  var isDetailView = false.obs;
  var selectedEmployee = <String, dynamic>{}.obs;

  var employeesList = <Map<String, dynamic>>[
    {'name': 'Jack Milson', 'email': 'jack@gmail.com', 'topUrl': 'Google docs', 'usageTime': '10hrs 10mints', 'usage': '80%', 'urlUsed': '6', 'isSelected': false},
    {'name': 'Sarah Connor', 'email': 'sarah.c@gmail.com', 'topUrl': 'Behance', 'usageTime': '6hrs 45mints', 'usage': '65%', 'urlUsed': '4', 'isSelected': false},
    {'name': 'Alex Rivera', 'email': 'alex.rivera@gmail.com', 'topUrl': 'Chat GPT', 'usageTime': '8hrs 20mints', 'usage': '75%', 'urlUsed': '9', 'isSelected': false},
    {'name': 'Emma Watson', 'email': 'emma.w@gmail.com', 'topUrl': 'Figma', 'usageTime': '12hrs 30mints', 'usage': '90%', 'urlUsed': '5', 'isSelected': false},
    {'name': 'Michael Brown', 'email': 'michael.b@gmail.com', 'topUrl': 'Hubstaff.com', 'usageTime': '4hrs 15mints', 'usage': '40%', 'urlUsed': '3', 'isSelected': false},
    {'name': 'Sophia Taylor', 'email': 'sophia.t@gmail.com', 'topUrl': 'GitHub', 'usageTime': '9hrs 50mints', 'usage': '85%', 'urlUsed': '7', 'isSelected': false},
    {'name': 'David Miller', 'email': 'david.m@gmail.com', 'topUrl': 'Stack Overflow', 'usageTime': '5hrs 10mints', 'usage': '50%', 'urlUsed': '8', 'isSelected': false},
  ].obs;

  void showEmployeeDetail(Map<String, dynamic> emp) {
    selectedEmployee.value = emp;
    isDetailView.value = true;
    loadDetailTableData();
  }

  void showTableView() {
    isDetailView.value = false;
  }

  bool get isAllSelected => employeesList.every((e) => e['isSelected'] == true);

  void toggleSelectAll() {
    bool val = !isAllSelected;
    for (var e in employeesList) {
      e['isSelected'] = val;
    }
    employeesList.refresh();
  }

  void toggleSelectRow(int index) {
    employeesList[index]['isSelected'] = !(employeesList[index]['isSelected'] ?? false);
    employeesList.refresh();
  }

  // -----------------------------------------------------------------------------
  // TEAM TAB DATA & NAVIGATION (3-STEP VIEW)
  // -----------------------------------------------------------------------------
  var isTeamEmpView = false.obs; // Step 2: Show Team Employees
  var selectedTeam = <String, dynamic>{}.obs;

  // 1. Teams List Data
  var teamsList = <Map<String, dynamic>>[
    {'teamName': 'Ui Ux', 'members': '10', 'topUrl': 'Google Docs', 'usageTime': '816hrs 40mints', 'usage': '65%', 'appUsed': '8', 'isSelected': false},
    {'teamName': 'Front End', 'members': '10', 'topUrl': 'Github', 'usageTime': '816hrs 40mints', 'usage': '65%', 'appUsed': '8', 'isSelected': false},
    {'teamName': 'Back End', 'members': '10', 'topUrl': 'Github', 'usageTime': '816hrs 40mints', 'usage': '65%', 'appUsed': '8', 'isSelected': false},
    {'teamName': 'QA', 'members': '10', 'topUrl': 'Google Chrome', 'usageTime': '816hrs 40mints', 'usage': '65%', 'appUsed': '8', 'isSelected': false},
    {'teamName': 'Ai Engineer', 'members': '10', 'topUrl': 'Github', 'usageTime': '816hrs 40mints', 'usage': '65%', 'appUsed': '8', 'isSelected': false},
  ].obs;

  // 2. Team Employees Data
  var teamEmployeesList = <Map<String, dynamic>>[
    {'name': 'Jack Milson', 'email': 'jack@gmail.com', 'topUrl': 'Google docs', 'usageTime': '40hrs 10mints', 'usage': '75%', 'urlUsed': '8', 'isSelected': false},
    {'name': 'Ayan Ali', 'email': 'ayan@gmail.com', 'topUrl': 'Behance', 'usageTime': '40hrs 10mints', 'usage': '75%', 'urlUsed': '6', 'isSelected': false},
    {'name': 'Talha bukhari', 'email': 'talha@gmail.com', 'topUrl': 'Google docs', 'usageTime': '40hrs 10mints', 'usage': '65%', 'urlUsed': '8', 'isSelected': false},
    {'name': 'Jhon Doe', 'email': 'jhon@gmail.com', 'topUrl': 'Git hub', 'usageTime': '40hrs 10mints', 'usage': '80%', 'urlUsed': '6', 'isSelected': false},
  ].obs;

  // Team Navigation Actions
  void showTeamEmployees(Map<String, dynamic> team) {
    selectedTeam.value = team;
    isTeamEmpView.value = true;
    isDetailView.value = false;
  }

  bool get isAllTeamsSelected => teamsList.every((t) => t['isSelected'] == true);

  void toggleSelectAllTeams() {
    bool val = !isAllTeamsSelected;
    for (var t in teamsList) {
      t['isSelected'] = val;
    }
    teamsList.refresh();
  }

  void toggleSelectTeamRow(int index) {
    teamsList[index]['isSelected'] = !(teamsList[index]['isSelected'] ?? false);
    teamsList.refresh();
  }

  bool get isAllTeamEmpSelected => teamEmployeesList.every((e) => e['isSelected'] == true);

  void toggleSelectAllTeamEmp() {
    bool val = !isAllTeamEmpSelected;
    for (var e in teamEmployeesList) {
      e['isSelected'] = val;
    }
    teamEmployeesList.refresh();
  }

  void toggleSelectTeamEmpRow(int index) {
    teamEmployeesList[index]['isSelected'] = !(teamEmployeesList[index]['isSelected'] ?? false);
    teamEmployeesList.refresh();
  }

  // -----------------------------------------------------------------------------
  // DETAIL VIEW & CHART TRACKING DATA
  // -----------------------------------------------------------------------------
  var hoveredBarIndex = (-1).obs;
  var detailRows = <Map<String, dynamic>>[].obs;
  var isAllDetailSelected = false.obs;

  void loadDetailTableData() {
    String filter = selectedTimeFilter.value;
    List<Map<String, dynamic>> list = [];

    if (filter == 'Day') {
      list = [
        {'url': 'Google docs', 'time': '2hr 20minutes', 'timeBy': '80% of total time', 'comp': '↑ 12.3%', 'isUp': true, 'isSelected': false},
        {'url': 'Behance', 'time': '20minutes', 'timeBy': '10% of total time', 'comp': '↑ 7.56%', 'isUp': true, 'isSelected': false},
        {'url': 'Chat Gpt', 'time': '25minutes', 'timeBy': '5% of total time', 'comp': '↑ 2.45%', 'isUp': true, 'isSelected': false},
        {'url': 'Hubstaff.com', 'time': '30minutes', 'timeBy': '5% of total time', 'comp': '↓ 2.3%', 'isUp': false, 'isSelected': false},
      ];
    } else if (filter == 'Week') {
      list = [
        {'url': 'Google docs', 'time': '10hrs 10mints', 'timeBy': '80% of total time', 'comp': '↑ 12.3%', 'isUp': true, 'isSelected': false},
        {'url': 'Behance', 'time': '5hrs 24mints', 'timeBy': '10% of total time', 'comp': '↑ 7.56%', 'isUp': true, 'isSelected': false},
        {'url': 'Chat Gpt', 'time': '2hrs 14mints', 'timeBy': '5% of total time', 'comp': '↑ 2.45%', 'isUp': true, 'isSelected': false},
        {'url': 'Hubstaff.com', 'time': '4hrs 12mints', 'timeBy': '5% of total time', 'comp': '↓ 2.3%', 'isUp': false, 'isSelected': false},
      ];
    } else {
      list = [
        {'url': 'Google docs', 'time': '40hrs 50mints', 'timeBy': '80% of total time', 'comp': '↑ 12.3%', 'isUp': true, 'isSelected': false},
        {'url': 'Behance', 'time': '20hrs 24mints', 'timeBy': '10% of total time', 'comp': '↑ 7.56%', 'isUp': true, 'isSelected': false},
        {'url': 'Chat Gpt', 'time': '8hrs 14mints', 'timeBy': '5% of total time', 'comp': '↑ 2.45%', 'isUp': true, 'isSelected': false},
        {'url': 'Hubstaff.com', 'time': '16hrs 12mints', 'timeBy': '5% of total time', 'comp': '↓ 2.3%', 'isUp': false, 'isSelected': false},
      ];
    }

    detailRows.assignAll(list);
    isAllDetailSelected.value = false;
  }

  void toggleDetailSelectAll() {
    isAllDetailSelected.value = !isAllDetailSelected.value;
    for (var row in detailRows) {
      row['isSelected'] = isAllDetailSelected.value;
    }
    detailRows.refresh();
  }

  void toggleDetailRow(int index) {
    detailRows[index]['isSelected'] = !(detailRows[index]['isSelected'] ?? false);
    isAllDetailSelected.value = detailRows.every((r) => r['isSelected'] == true);
    detailRows.refresh();
  }

  // -----------------------------------------------------------------------------
  // DYNAMIC DATE RANGE PICKER
  // -----------------------------------------------------------------------------
  var selectedDateTime = DateTime.now().obs;
  var selectedWeekRange = Rxn<DateTimeRange>();

  String get formattedDateText {
    final mode = selectedTimeFilter.value.toLowerCase();
    final date = selectedDateTime.value;

    if (mode == 'day') {
      return DateFormat('d MMMM, yyyy').format(date);
    } else if (mode == 'week') {
      final range = selectedWeekRange.value ?? _getSingleWeekRange(date);
      return "${DateFormat('d MMM').format(range.start)} - ${DateFormat('d MMM, yyyy').format(range.end)}";
    } else {
      final range = selectedWeekRange.value ?? _getLast4WeeksRange(date);
      return "${DateFormat('d MMM').format(range.start)} - ${DateFormat('d MMM, yyyy').format(range.end)}";
    }
  }

  void changeDateOffset(int offset) {
    final mode = selectedTimeFilter.value.toLowerCase();
    if (mode == 'day') {
      selectedDateTime.value = selectedDateTime.value.add(Duration(days: offset));
    } else if (mode == 'week') {
      selectedDateTime.value = selectedDateTime.value.add(Duration(days: offset * 7));
      selectedWeekRange.value = _getSingleWeekRange(selectedDateTime.value);
    } else {
      selectedDateTime.value = selectedDateTime.value.add(Duration(days: offset * 28));
      selectedWeekRange.value = _getLast4WeeksRange(selectedDateTime.value);
    }
    if (isDetailView.value) {
      loadDetailTableData();
    }
  }

  DateTimeRange _getSingleWeekRange(DateTime date) {
    int currentDayOfWeek = date.weekday;
    DateTime startOfWeek = date.subtract(Duration(days: currentDayOfWeek - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
    return DateTimeRange(
      start: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
      end: DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day),
    );
  }

  DateTimeRange _getLast4WeeksRange(DateTime date) {
    DateTime endOfWeek = _getSingleWeekRange(date).end;
    DateTime startOf4Weeks = endOfWeek.subtract(const Duration(days: 27));
    return DateTimeRange(
      start: DateTime(startOf4Weeks.year, startOf4Weeks.month, startOf4Weeks.day),
      end: DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day),
    );
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  void nextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
    }
  }
}