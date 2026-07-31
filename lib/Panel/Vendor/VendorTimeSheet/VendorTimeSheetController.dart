import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class TimeSheetEmployeeModel {
  final String name;
  final String email;
  final String designation;
  final String totalTime;
  final String activeTime;
  final String idleTime;
  final String productivity;
  bool isSelected;

  TimeSheetEmployeeModel({
    required this.name,
    required this.email,
    required this.designation,
    required this.totalTime,
    required this.activeTime,
    required this.idleTime,
    required this.productivity,
    this.isSelected = false,
  });
}

class TimeSheetTeamModel {
  final String teamName;
  final int teamMembers;
  final String totalTime;
  final String activeTime;
  final String idleTime;
  final String productivity;
  bool isSelected;

  TimeSheetTeamModel({
    required this.teamName,
    required this.teamMembers,
    required this.totalTime,
    required this.activeTime,
    required this.idleTime,
    required this.productivity,
    this.isSelected = false,
  });
}

class EmployeeDetailRowModel {
  final String duration;
  final String totalTime;
  final String activeTime;
  final String idleTime;
  final String productivity;

  EmployeeDetailRowModel({
    required this.duration,
    required this.totalTime,
    required this.activeTime,
    required this.idleTime,
    required this.productivity,
  });
}

class VendorTimeSheetController extends GetxController {

  var selectedTab = 0.obs;
  var selectedEmployee = Rxn<dynamic>();
  var selectedViewType = 0.obs;
  var selectedTimeFilter = "Day".obs;
  var searchQuery = "".obs;

  var currentPage = 1.obs;
  var totalPages = 10.obs;
  var selectedDate = DateTime.now().obs;
  var weekRange = Rxn<DateTimeRange>();

  void updateSelectedDate(DateTime date, DateTimeRange? range) {
    selectedDate.value = date;
    weekRange.value = range;
  }
  String get currentDateText {
    if (selectedTimeFilter.value == "Day") {
      return DateFormat('d MMMM, yyyy').format(selectedDate.value);
    } else if (selectedTimeFilter.value == "Week") {
      if (weekRange.value != null) {
        String start = DateFormat('d MMM, yyyy').format(weekRange.value!.start);
        String end = DateFormat('d MMM, yyyy').format(weekRange.value!.end);
        return "$start - $end";
      }
      return DateFormat('d MMMM, yyyy').format(selectedDate.value);
    } else {
      if (weekRange.value != null) {
        String start = DateFormat('d MMM, yy').format(weekRange.value!.start);
        String end = DateFormat('d MMM, yy').format(weekRange.value!.end);
        return "$start - $end";
      }
      return DateFormat('d MMMM, yyyy').format(selectedDate.value);
    }
  }
  var isAllSelected = false.obs;

  var employeesList = <TimeSheetEmployeeModel>[
    TimeSheetEmployeeModel(
      name: "Jack Milson",
      email: "jack@gmail.com",
      designation: "Front End Dev",
      totalTime: "8hrs",
      activeTime: "6hrs 50 mints",
      idleTime: "1hr 50 mints",
      productivity: "78%",
    ),
    TimeSheetEmployeeModel(
      name: "Talha bukhari",
      email: "talha@gmail.com",
      designation: "UI Ux Designer",
      totalTime: "8hrs",
      activeTime: "7 hrs 10 mints",
      idleTime: "50 mints",
      productivity: "80%",
    ),
    TimeSheetEmployeeModel(
      name: "Ayan Ali",
      email: "ayan@gmail.com",
      designation: "Back End Dev",
      totalTime: "7hrs",
      activeTime: "7 hrs 10 mints",
      idleTime: "50 mints",
      productivity: "80%",
    ),
  ].obs;

  void toggleSelectAll(bool? val) {
    isAllSelected.value = val ?? false;
    for (var item in employeesList) {
      item.isSelected = isAllSelected.value;
    }
    employeesList.refresh();
  }

  void toggleIndividualSelection(int index, bool? val) {
    employeesList[index].isSelected = val ?? false;
    isAllSelected.value = employeesList.every((element) => element.isSelected);
    employeesList.refresh();
  }

  //  Team Section
  var isAllTeamSelected = false.obs;
  var selectedTeam = Rxn<TimeSheetTeamModel>();

  var teamsList = <TimeSheetTeamModel>[
    TimeSheetTeamModel(teamName: "AI Engineer", teamMembers: 6, totalTime: "45 hrs", activeTime: "36 hrs 10 mints", idleTime: "8hrs 50 mints", productivity: "80%"),
    TimeSheetTeamModel(teamName: "UI Ux", teamMembers: 6, totalTime: "45 hrs", activeTime: "36 hrs 10 mints", idleTime: "8hrs 50 mints", productivity: "80%"),
    TimeSheetTeamModel(teamName: "Front End", teamMembers: 6, totalTime: "45 hrs", activeTime: "36 hrs 10 mints", idleTime: "8hrs 50 mints", productivity: "80%"),
  ].obs;

  void toggleSelectAllTeams(bool? val) {
    bool value = val ?? false;
    isAllTeamSelected.value = value;
    for (var item in teamsList) {
      item.isSelected = value;
    }
    teamsList.refresh();
  }

  void toggleIndividualTeamSelection(int index, bool? val) {
    teamsList[index].isSelected = val ?? false;
    isAllTeamSelected.value = teamsList.every((element) => element.isSelected == true);
    teamsList.refresh();
  }
  var isViewingMembers = false.obs;
  var isAllEmployeeSelected = false.obs;
  void toggleSelectAllEmployees(bool? val) {
    bool value = val ?? false;
    isAllEmployeeSelected.value = value;
    for (var employee in employeesList) {
      employee.isSelected = value;
    }
    employeesList.refresh();
  }

  void toggleIndividualEmployeeSelection(int index, bool? val) {
    employeesList[index].isSelected = val ?? false;
    isAllEmployeeSelected.value = employeesList.every((emp) => emp.isSelected == true);
    employeesList.refresh();
  }
  var selectedEmployeeDetail = Rxn<TimeSheetEmployeeModel>();
  var employeeDetailRows = <EmployeeDetailRowModel>[].obs;

  void viewEmployeeDetails(TimeSheetEmployeeModel employee) {
    selectedEmployeeDetail.value = employee;

    if (selectedTimeFilter.value == "Last 4 week") {
      employeeDetailRows.value = List.generate(28, (index) {
        int day = index + 1;
        bool isOff = (day % 6 == 0 || day % 7 == 0);
        return EmployeeDetailRowModel(
          duration: "$day May, 2026",
          totalTime: isOff ? "-----" : "8hrs",
          activeTime: isOff ? "-------" : "6hrs 50mints",
          idleTime: isOff ? "------" : "1hr 10mints",
          productivity: isOff ? "------" : "70%",
        );
      });
    } else {
      List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
      employeeDetailRows.value = days.map((day) {
        bool isOff = (day == "Saturday" || day == "Sunday");
        return EmployeeDetailRowModel(
          duration: day,
          totalTime: isOff ? "-----" : "8hrs",
          activeTime: isOff ? "-------" : "6hrs 50mints",
          idleTime: isOff ? "------" : "1hr 10mints",
          productivity: isOff ? "------" : "70%",
        );
      }).toList();
    }
  }

  void openEmployeeDetails(TimeSheetEmployeeModel employee) {
    selectedEmployeeDetail.value = employee;
  }

  void closeEmployeeDetails() {
    selectedEmployeeDetail.value = null;
  }
}