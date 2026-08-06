

import 'package:get/get.dart';




class EmployeeActivityModel {
  final String id;
  final String name;
  final String email;
  final String mousePercent;
  final String keyboardPercent;
  final String idlePercent;
  final int overallPercent;
  bool isSelected;

  EmployeeActivityModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mousePercent,
    required this.keyboardPercent,
    required this.idlePercent,
    required this.overallPercent,
    this.isSelected = false,
  });
}

class VendorActivityController extends GetxController {
  var selectedMainTab = 'Employees'.obs;
  var selectedTimeframe = 'Day'.obs;
  var searchQuery = ''.obs;
  var currentPage = 1.obs;
  var totalPages = 10.obs;
  var isAllSelected = false.obs;

  var selectedDate = DateTime.now().obs;
  var dateRangeText = "Select Date".obs;

  var isDetailView = false.obs;
  var selectedEmployeeForDetail = Rxn<EmployeeActivityModel>();

  void openEmployeeDetail(EmployeeActivityModel employee) {
    selectedEmployeeForDetail.value = employee;
    isDetailView.value = true;
  }

  void backToEmployeeList() {
    isDetailView.value = false;
    selectedEmployeeForDetail.value = null;
  }

  var employeeList = <EmployeeActivityModel>[
    EmployeeActivityModel(
      id: '1',
      name: 'Jack Milson',
      email: 'jack@gmail.com',
      mousePercent: '33%',
      keyboardPercent: '55%',
      idlePercent: '5%',
      overallPercent: 76,
    ),
    EmployeeActivityModel(
      id: '2',
      name: 'Ayan Ali',
      email: 'ayan@gmail.com',
      mousePercent: '44%',
      keyboardPercent: '45%',
      idlePercent: '10%',
      overallPercent: 90,
    ),
    EmployeeActivityModel(
      id: '3',
      name: 'Talha bukhari',
      email: 'talha@gmail.com',
      mousePercent: '55%',
      keyboardPercent: '65%',
      idlePercent: '8%',
      overallPercent: 60,
    ),
    EmployeeActivityModel(
      id: '4',
      name: 'Jack Milson',
      email: 'jack@gmail.com',
      mousePercent: '33%',
      keyboardPercent: '55%',
      idlePercent: '5%',
      overallPercent: 76,
    ),
    EmployeeActivityModel(
      id: '5',
      name: 'Jhon Doe',
      email: 'jhon@gmail.com',
      mousePercent: '44%',
      keyboardPercent: '45%',
      idlePercent: '10%',
      overallPercent: 90,
    ),
    EmployeeActivityModel(
      id: '6',
      name: 'Talha bukhari',
      email: 'talha@gmail.com',
      mousePercent: '55%',
      keyboardPercent: '65%',
      idlePercent: '8%',
      overallPercent: 60,
    ),
    EmployeeActivityModel(
      id: '7',
      name: 'Jack Milson',
      email: 'jack@gmail.com',
      mousePercent: '33%',
      keyboardPercent: '55%',
      idlePercent: '5%',
      overallPercent: 76,
    ),
  ].obs;

  List<EmployeeActivityModel> get filteredList {
    if (searchQuery.value.trim().isEmpty) {
      return employeeList;
    }
    return employeeList
        .where((e) =>
    e.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        e.email.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void toggleSelectAll(bool? val) {
    isAllSelected.value = val ?? false;
    for (var item in employeeList) {
      item.isSelected = isAllSelected.value;
    }
    employeeList.refresh();
  }

  void toggleSelectMember(int index, bool? val) {
    filteredList[index].isSelected = val ?? false;
    isAllSelected.value = employeeList.every((e) => e.isSelected);
    employeeList.refresh();
  }
  var selectedSessionIndices = <int>{}.obs;
  void toggleSelectAllSessions(int totalCount) {
    if (selectedSessionIndices.length == totalCount) {
      selectedSessionIndices.clear();
    } else {
      selectedSessionIndices.addAll(List.generate(totalCount, (index) => index));
    }
  }

  void toggleSessionSelection(int index) {
    if (selectedSessionIndices.contains(index)) {
      selectedSessionIndices.remove(index);
    } else {
      selectedSessionIndices.add(index);
    }
  }

  var selectedWeekDayIndices = <int>{}.obs;

  void toggleSelectAllWeekDays(int total) {
    if (selectedWeekDayIndices.length == total) {
      selectedWeekDayIndices.clear();
    } else {
      selectedWeekDayIndices.addAll(List.generate(total, (i) => i));
    }
  }

  void toggleWeekDaySelection(int index) {
    if (selectedWeekDayIndices.contains(index)) {
      selectedWeekDayIndices.remove(index);
    } else {
      selectedWeekDayIndices.add(index);
    }
  }

  var selectedDayIndices = <int>{}.obs;

  // Single day checkbox toggle karne ke liye method
  void toggleDaySelection(int index) {
    if (selectedDayIndices.contains(index)) {
      selectedDayIndices.remove(index);
    } else {
      selectedDayIndices.add(index);
    }
  }

  // Select All checkbox toggle karne ke liye method
  void toggleSelectAllDays(int totalDays) {
    if (selectedDayIndices.length == totalDays) {
      selectedDayIndices.clear();
    } else {
      selectedDayIndices.assignAll(List.generate(totalDays, (index) => index));
    }
  }

  var selectedWeekIndices = <int>{}.obs;

  void toggleWeekSelection(int index) {
    if (selectedWeekIndices.contains(index)) {
      selectedWeekIndices.remove(index);
    } else {
      selectedWeekIndices.add(index);
    }
  }

  void toggleSelectAllWeeks(int totalWeeks) {
    if (selectedWeekIndices.length == totalWeeks) {
      selectedWeekIndices.clear();
    } else {
      selectedWeekIndices.assignAll(List.generate(totalWeeks, (index) => index));
    }
  }
}