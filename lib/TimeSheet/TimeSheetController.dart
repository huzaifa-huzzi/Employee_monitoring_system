import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeSheetController extends GetxController {
    /// My TimeSheet
  var selectedDate = DateTime.now().obs;
  var selectedViewIndex = 0.obs;
  var formattedDateString = ''.obs;

  @override
  void onInit() {
    super.onInit();
    updateFormattedDate();
  }

  void toggleView(int index) {
    selectedViewIndex.value = index;
    updateFormattedDate();
  }

  bool get isWeekMode => selectedViewIndex.value == 1;

  void updateFormattedDate() {
    if (isWeekMode) {
      DateTimeRange range = getWeekRange(selectedDate.value);
      final start = DateFormat('d MMM').format(range.start);
      final end = DateFormat('d MMM, yyyy').format(range.end);
      formattedDateString.value = "$start - $end";
    } else {
      formattedDateString.value = DateFormat('d- MMMM, yyyy').format(selectedDate.value);
    }
  }

  String get formattedDate => formattedDateString.value;

  DateTimeRange getWeekRange(DateTime date) {
    int currentDayOfWeek = date.weekday;
    DateTime startOfWeek = date.subtract(Duration(days: currentDayOfWeek - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
    return DateTimeRange(
      start: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
      end: DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day),
    );
  }

  void previousDate() {
    if (isWeekMode) {
      selectedDate.value = selectedDate.value.subtract(const Duration(days: 7));
    } else {
      selectedDate.value = selectedDate.value.subtract(const Duration(days: 1));
    }
    updateFormattedDate();
  }

  void nextDate() {
    if (isWeekMode) {
      selectedDate.value = selectedDate.value.add(const Duration(days: 7));
    } else {
      selectedDate.value = selectedDate.value.add(const Duration(days: 1));
    }
    updateFormattedDate();
  }

  var isAllSelected = false.obs;
  var timeSheetList = <TimeSheetItem>[
    TimeSheetItem(project: "Hub Staff", startTime: "12:12pm", stopTime: "12:12pm", duration: "5 hrs"),
    TimeSheetItem(project: "Hub Staff", startTime: "12:12pm", stopTime: "12:12pm", duration: "5 hrs"),
    TimeSheetItem(project: "Hub Staff", startTime: "12:12pm", stopTime: "12:12pm", duration: "5 hrs"),
    TimeSheetItem(project: "Hub Staff", startTime: "12:12pm", stopTime: "12:12pm", duration: "5 hrs"),
  ].obs;

  void toggleAllCheckboxes(bool? value) {
    isAllSelected.value = value ?? false;
    for (var item in timeSheetList) {
      item.isSelected = isAllSelected.value;
    }
    timeSheetList.refresh();
  }

  void toggleItemCheckbox(int index, bool? value) {
    timeSheetList[index].isSelected = value ?? false;
    isAllSelected.value = timeSheetList.every((item) => item.isSelected);
    timeSheetList.refresh();
  }

  void updateTimeSheetEntry({
    required int index,
    required String? project,
    required String startTime,
    required String stopTime,
    required String? reason,
  }) {
    if (index >= 0 && index < timeSheetList.length) {
      var item = timeSheetList[index];

      if (project != null && project.isNotEmpty) {
        item.project = project;
      }

      item.startTime = startTime;
      item.stopTime = stopTime;


      timeSheetList[index] = item;
      timeSheetList.refresh();
    }
  }
}

class TimeSheetItem {
  String project;
  String startTime;
  String stopTime;
  String duration;
  bool isSelected;
  String? mondayHours;
  String? tuesdayHours;
  String? wednesdayHours;
  String? thursdayHours;
  String? fridayHours;
  String? saturdayHours;
  String? sundayHours;
  String? totalHours;

  TimeSheetItem({
    required this.project,
    required this.startTime,
    required this.stopTime,
    required this.duration,
    this.isSelected = false,
  });
}