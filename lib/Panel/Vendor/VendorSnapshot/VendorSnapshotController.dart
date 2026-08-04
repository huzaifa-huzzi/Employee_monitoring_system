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

  final isShowingEmployeeDetailView = false.obs;
  final selectedEmployeeDetails = <String, dynamic>{}.obs;

  final teamLogs = <Map<String, dynamic>>[].obs;
  final employeeLogs = <Map<String, dynamic>>[].obs;

  final isTeamHeaderSelected = false.obs;
  final selectedTeamRows = <bool>[].obs;

  final isEmployeeHeaderSelected = false.obs;
  final selectedEmployeeRows = <bool>[].obs;
  final screenshotTimeGroups = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    updateSelectedDate(DateTime.now());
    loadTeamDummyData();
    loadEmployeeDummyData();
    loadScreenshotDetailsDummyData();
  }

  void updateSelectedDate(DateTime date) {
    rawSelectedDate.value = date;
    selectedDateText.value = DateFormat('d MMMM, yyyy').format(date);
  }

  void openEmployeeDetailView(Map<String, dynamic> empData) {
    selectedEmployeeDetails.value = empData;
    isShowingEmployeeDetailView.value = true;
  }

  void closeEmployeeDetailView() {
    isShowingEmployeeDetailView.value = false;
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
    ];

    teamLogs.assignAll(dummyTeams);
    selectedTeamRows.assignAll(List.generate(teamLogs.length, (_) => false));
    isTeamHeaderSelected.value = false;
  }

  void loadEmployeeDummyData() {
    List<Map<String, dynamic>> dummyEmployees = [
      {"name": "Jack Milson", "email": "jack@gmail.com", "totalScreenshots": "144", "activeTime": "8 hrs", "idleTime": "1 hr 10 mints", "productivity": "65%"},
      {"name": "Sarah Connor", "email": "sarah@example.com", "totalScreenshots": "144", "activeTime": "6 hrs 30 mints", "idleTime": "1 hr 10 mints", "productivity": "85%"},
      {"name": "John Doe", "email": "john@example.com", "totalScreenshots": "120", "activeTime": "5 hrs 45 mints", "idleTime": "45 mints", "productivity": "90%"},
    ];

    employeeLogs.assignAll(dummyEmployees);
    selectedEmployeeRows.assignAll(List.generate(employeeLogs.length, (_) => false));
    isEmployeeHeaderSelected.value = false;
  }

  void loadScreenshotDetailsDummyData() {
    List<Map<String, dynamic>> groups = [
      {
        "timeRange": "2:00 pm - 3:00 pm",
        "totalWorked": "0:54:43",
        "shots": [
          {"time": "2:00 pm - 2:10 pm", "activity": 53, "imageUrl": "https://picsum.photos/400/250?random=11"},
          {"time": "2:10 pm - 2:20 pm", "activity": 53, "imageUrl": "https://picsum.photos/400/250?random=12"},
          {"time": "2:20 pm - 2:30 pm", "activity": 53, "imageUrl": "https://picsum.photos/400/250?random=13"},
          {"time": "2:30 pm - 2:40 pm", "activity": 53, "imageUrl": "https://picsum.photos/400/250?random=14"},
          {"time": "2:40 pm - 2:50 pm", "activity": 53, "imageUrl": "https://picsum.photos/400/250?random=15"},
          {"time": "2:50 pm - 3:00 pm", "activity": 53, "imageUrl": "https://picsum.photos/400/250?random=16"},
        ]
      },
      {
        "timeRange": "3:00 pm - 4:00 pm",
        "totalWorked": "01:06:00",
        "shots": [
          {"time": "3:00 pm - 3:10 pm", "activity": 53, "imageUrl": "https://picsum.photos/400/250?random=21"},
          {"time": "3:10 pm - 3:20 pm", "activity": 53, "imageUrl": "https://picsum.photos/400/250?random=22"},
          {"time": "3:20 pm - 3:30 pm", "activity": 53, "imageUrl": "https://picsum.photos/400/250?random=23"},
        ]
      }
    ];
    screenshotTimeGroups.assignAll(groups);
  }
}