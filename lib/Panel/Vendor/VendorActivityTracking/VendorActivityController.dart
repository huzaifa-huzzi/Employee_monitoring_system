import 'package:employee_monitoring_system/Panel/Vendor/Team/TeamController.dart';
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

class TeamActivityModel {
  final String id;
  final String teamName;
  final int membersCount;
  final String mousePercent;
  final String keyboardPercent;
  final String idlePercent;
  final int overallPercent;
  bool isSelected;

  TeamActivityModel({
    required this.id,
    required this.teamName,
    required this.membersCount,
    required this.mousePercent,
    required this.keyboardPercent,
    required this.idlePercent,
    required this.overallPercent,
    this.isSelected = false,
  });
}

class TeamEmployeeModel {
  String name;
  String email;
  String mousePercent;
  String keyboardPercent;
  String idlePercent;
  int overallPercent;
  bool isSelected;

  TeamEmployeeModel({
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
  ].obs;

  var selectedSessionIndices = <int>{}.obs;
  var selectedWeekDayIndices = <int>{}.obs;
  var selectedDayIndices = <int>{}.obs;
  var selectedWeekIndices = <int>{}.obs;
  var isShowingTeamEmployees = false.obs;
  var isTeamAllSelected = false.obs;


  final RxList<TeamActivityModel> teamList = <TeamActivityModel>[].obs;

  var isTeamEmpAllSelected = false.obs;
  var teamEmployeeList = <TeamEmployeeModel>[].obs;
  final RxList<TeamEmployeeModel> _allTeamEmployees = <TeamEmployeeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyTeams();
    _loadDummyTeamEmployees();
  }

  void _loadDummyTeams() {
    teamList.assignAll([
      TeamActivityModel(
        id: '1',
        teamName: 'UI/UX Design',
        membersCount: 8,
        mousePercent: '75%',
        keyboardPercent: '60%',
        idlePercent: '5%',
        overallPercent: 88,
      ),
      TeamActivityModel(
        id: '2',
        teamName: 'Flutter Developers',
        membersCount: 12,
        mousePercent: '82%',
        keyboardPercent: '88%',
        idlePercent: '4%',
        overallPercent: 92,
      ),
      TeamActivityModel(
        id: '3',
        teamName: 'Backend Team',
        membersCount: 6,
        mousePercent: '45%',
        keyboardPercent: '90%',
        idlePercent: '10%',
        overallPercent: 78,
      ),
      TeamActivityModel(
        id: '4',
        teamName: 'QA & Automation',
        membersCount: 5,
        mousePercent: '60%',
        keyboardPercent: '50%',
        idlePercent: '15%',
        overallPercent: 65,
      ),
    ]);
  }

  void _loadDummyTeamEmployees() {
    _allTeamEmployees.assignAll([
      TeamEmployeeModel(name: "Jack Milson", email: "jack@gmail.com", mousePercent: "33%", keyboardPercent: "55%", idlePercent: "5%", overallPercent: 78),
      TeamEmployeeModel(name: "Ayan Ali", email: "ayan@gmail.com", mousePercent: "44%", keyboardPercent: "45%", idlePercent: "10%", overallPercent: 90),
      TeamEmployeeModel(name: "Talha bukhari", email: "talha@gmail.com", mousePercent: "55%", keyboardPercent: "65%", idlePercent: "8%", overallPercent: 60),
      TeamEmployeeModel(name: "Jack Milson", email: "jack@gmail.com", mousePercent: "33%", keyboardPercent: "55%", idlePercent: "5%", overallPercent: 78),
      TeamEmployeeModel(name: "Jhon Doe", email: "jhon@gmail.com", mousePercent: "44%", keyboardPercent: "45%", idlePercent: "10%", overallPercent: 90),
      TeamEmployeeModel(name: "Talha bukhari", email: "talha@gmail.com", mousePercent: "55%", keyboardPercent: "65%", idlePercent: "8%", overallPercent: 60),
    ]);

    teamEmployeeList.assignAll(_allTeamEmployees);
  }
  List<EmployeeActivityModel> get filteredList {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      return employeeList;
    }
    return employeeList
        .where((e) =>
    e.name.toLowerCase().contains(query) ||
        e.email.toLowerCase().contains(query))
        .toList();
  }

  void openEmployeeDetail(EmployeeActivityModel employee) {
    selectedEmployeeForDetail.value = employee;
    isDetailView.value = true;
  }

  void backToEmployeeList() {
    isDetailView.value = false;
    selectedEmployeeForDetail.value = null;
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

  void toggleDaySelection(int index) {
    if (selectedDayIndices.contains(index)) {
      selectedDayIndices.remove(index);
    } else {
      selectedDayIndices.add(index);
    }
  }

  void toggleSelectAllDays(int totalDays) {
    if (selectedDayIndices.length == totalDays) {
      selectedDayIndices.clear();
    } else {
      selectedDayIndices.assignAll(List.generate(totalDays, (index) => index));
    }
  }

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

  void toggleSelectAllTeams(bool? val) {
    isTeamAllSelected.value = val ?? false;
    for (var item in teamList) {
      item.isSelected = isTeamAllSelected.value;
    }
    teamList.refresh();
  }

  void toggleSelectTeamItem(int index, bool? val) {
    teamList[index].isSelected = val ?? false;
    isTeamAllSelected.value = teamList.every((element) => element.isSelected);
    teamList.refresh();
  }

  void viewEmployeesForTeam(TeamActivityModel team) {
    selectedMainTab.value = 'Team';

    if (_allTeamEmployees.isEmpty) {
      _loadDummyTeamEmployees();
    } else {
      teamEmployeeList.assignAll(_allTeamEmployees);
    }

    isShowingTeamEmployees.value = true;
    teamEmployeeList.refresh();
  }

  void backToTeamList() {
    isShowingTeamEmployees.value = false;
  }

  void searchTeamEmployee(String? query) {
    final searchStr = query?.trim().toLowerCase() ?? '';

    if (searchStr.isEmpty) {
      teamEmployeeList.assignAll(_allTeamEmployees);
    } else {
      teamEmployeeList.assignAll(
        _allTeamEmployees.where((emp) =>
        emp.name.toLowerCase().contains(searchStr) ||
            emp.email.toLowerCase().contains(searchStr)
        ).toList(),
      );
    }
    teamEmployeeList.refresh();
  }

  void toggleSelectAllTeamEmployees(bool? val) {
    isTeamEmpAllSelected.value = val ?? false;
    for (var emp in teamEmployeeList) {
      emp.isSelected = isTeamEmpAllSelected.value;
    }
    teamEmployeeList.refresh();
  }

  void toggleSelectTeamEmpItem(int index, bool? val) {
    teamEmployeeList[index].isSelected = val ?? false;
    isTeamEmpAllSelected.value = teamEmployeeList.every((emp) => emp.isSelected);
    teamEmployeeList.refresh();
  }

  void viewIndividualEmployeeDetail(TeamEmployeeModel emp) {

  }

  void nextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
    }
  }

  void prevPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  final isShowingTeamDetail = false.obs;
  final selectedTeamDetail = Rxn<TeamModel>();

  void viewTeamDetail(TeamModel team) {
    selectedTeamDetail.value = team;
    isShowingTeamDetail.value = true;
  }

  void hideTeamDetail() {
    isShowingTeamDetail.value = false;
    selectedTeamDetail.value = null;
  }

  final isShowingTeamEmployeeDetail = false.obs;
  final selectedTeamEmployeeDetail = Rxn<TeamEmployeeModel>();

  void viewTeamEmployeeDetail(TeamEmployeeModel emp) {
    selectedTeamEmployeeDetail.value = emp;
    isShowingTeamEmployeeDetail.value = true;
  }

  void hideTeamEmployeeDetail() {
    isShowingTeamEmployeeDetail.value = false;
    selectedTeamEmployeeDetail.value = null;
  }
}