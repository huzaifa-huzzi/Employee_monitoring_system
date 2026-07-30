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

class VendorTimeSheetController extends GetxController {
  var selectedTab = 0.obs;
  var selectedEmployee = Rxn<dynamic>();
  var selectedViewType = 0.obs;
  var selectedTimeFilter = "Day".obs;
  var searchQuery = "".obs;

  var currentPage = 1.obs;
  var totalPages = 10.obs;


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
    TimeSheetEmployeeModel(
      name: "Jhon Doe",
      email: "jhon@gmail.com",
      designation: "Front End",
      totalTime: "6hrs",
      activeTime: "7 hrs 10 mints",
      idleTime: "50 mints",
      productivity: "80%",
    ),
    TimeSheetEmployeeModel(
      name: "Jack Milson",
      email: "jack@gmail.com",
      designation: "Front End Dev",
      totalTime: "8hrs",
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

  var selectedDate = DateTime
      .now()
      .obs;
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
}