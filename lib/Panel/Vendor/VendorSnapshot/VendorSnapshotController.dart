import 'package:get/get.dart';
import 'package:intl/intl.dart';


class VendorSnapshotController extends GetxController {
  final selectedToggleIndex = 0.obs;
  final isShowingTeamEmpDetails = false.obs;
  final selectedTeamName = "".obs;
  final rawSelectedDate = DateTime.now().obs;
  final selectedDateText = ''.obs;
  final searchQuery = ''.obs;
  final currentPage = 1.obs;
  final totalPages = 10.obs;


  final teamLogs = <Map<String, dynamic>>[].obs;
  final employeeLogs = <Map<String, dynamic>>[].obs;

  final isTeamHeaderSelected = false.obs;
  final selectedTeamRows = <bool>[].obs;

  final isEmployeeHeaderSelected = false.obs;
  final selectedEmployeeRows = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    updateSelectedDate(DateTime.now());
    loadTeamDummyData();
    loadEmployeeDummyData();
  }

  void updateSelectedDate(DateTime date) {
    rawSelectedDate.value = date;
    selectedDateText.value = DateFormat('d MMMM, yyyy').format(date);
  }

  void toggleSelectAllTeam(bool? val) {
    isTeamHeaderSelected.value = val ?? false;
    selectedTeamRows.assignAll(List.generate(teamLogs.length, (_) => isTeamHeaderSelected.value));
  }

  void onTeamRowSelected(int index, bool? val) {
    if (index < selectedTeamRows.length) {
      selectedTeamRows[index] = val ?? false;
      isTeamHeaderSelected.value = selectedTeamRows.every((e) => e == true);
    }
  }

  void toggleSelectAllEmployee(bool? val) {
    isEmployeeHeaderSelected.value = val ?? false;
    selectedEmployeeRows.assignAll(List.generate(employeeLogs.length, (_) => isEmployeeHeaderSelected.value));
  }

  void onEmployeeRowSelected(int index, bool? val) {
    if (index < selectedEmployeeRows.length) {
      selectedEmployeeRows[index] = val ?? false;
      isEmployeeHeaderSelected.value = selectedEmployeeRows.every((e) => e == true);
    }
  }

  void loadTeamDummyData() {
    List<Map<String, dynamic>> dummyTeams = [
      {"teamName": "AI Engineer", "members": 6, "totalScreenshots": "480", "activeTime": "36 hrs 10 mints", "idleTime": "8hrs 50 mints", "productivity": "80%"},
      {"teamName": "UI Ux", "members": 6, "totalScreenshots": "480", "activeTime": "36 hrs 10 mints", "idleTime": "8hrs 50 mints", "productivity": "80%"},
      {"teamName": "Front End", "members": 6, "totalScreenshots": "480", "activeTime": "36 hrs 10 mints", "idleTime": "8hrs 50 mints", "productivity": "80%"},
      {"teamName": "AI Engineer", "members": 6, "totalScreenshots": "480", "activeTime": "36 hrs 10 mints", "idleTime": "8hrs 50 mints", "productivity": "80%"},
      {"teamName": "UI Ux", "members": 6, "totalScreenshots": "480", "activeTime": "36 hrs 10 mints", "idleTime": "8hrs 50 mints", "productivity": "80%"},
      {"teamName": "Front End", "members": 6, "totalScreenshots": "480", "activeTime": "36 hrs 10 mints", "idleTime": "8hrs 50 mints", "productivity": "80%"},
    ];

    teamLogs.assignAll(dummyTeams);
    selectedTeamRows.assignAll(List.generate(teamLogs.length, (_) => false));
    isTeamHeaderSelected.value = false;
  }

  void loadEmployeeDummyData() {
    List<Map<String, dynamic>> dummyEmployees = [
      {"name": "Sarah Connor", "email": "sarah@example.com", "totalScreenshots": "144", "activeTime": "6 hrs 30 mints", "idleTime": "1 hr 10 mints", "productivity": "85%"},
      {"name": "John Doe", "email": "john@example.com", "totalScreenshots": "120", "activeTime": "5 hrs 45 mints", "idleTime": "45 mints", "productivity": "90%"},
      {"name": "Alex Smith", "email": "alex@example.com", "totalScreenshots": "160", "activeTime": "7 hrs 15 mints", "idleTime": "30 mints", "productivity": "94%"},
      {"name": "Emma Watson", "email": "emma@example.com", "totalScreenshots": "110", "activeTime": "4 hrs 50 mints", "idleTime": "1 hr 30 mints", "productivity": "75%"},
    ];

    employeeLogs.assignAll(dummyEmployees);
    selectedEmployeeRows.assignAll(List.generate(employeeLogs.length, (_) => false));
    isEmployeeHeaderSelected.value = false;
  }
}