



import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamModel {
  final String id;
  final String name;
  final String creationDate;
  final int memberCount;
  bool isSelected;

  TeamModel({
    required this.id,
    required this.name,
    required this.creationDate,
    required this.memberCount,
    this.isSelected = false,
  });
}

class TeamMemberModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String department;
  final String joiningDate;
  bool isSelected;

  TeamMemberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.department,
    required this.joiningDate,
    this.isSelected = false,
  });
}

enum MemberStatus { active, offline, idle }

class EmployeeMemberModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String department;
  final String joiningDate;
  final MemberStatus status;
  final String? profileImage;

  EmployeeMemberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.department,
    required this.joiningDate,
    required this.status,
    this.profileImage,
  });
}

class TeamVendorController extends GetxController {
  /// Main Screen
  var currentPage = 1.obs;
  var totalPages = 10.obs;
  var isAllSelected = false.obs;


  var teamsList = <TeamModel>[
    TeamModel(id: "1", name: "AI Engineer", creationDate: "2 feb,2026", memberCount: 5),
    TeamModel(id: "2", name: "UI Ux", creationDate: "2 feb,2026", memberCount: 8),
    TeamModel(id: "3", name: "Front End", creationDate: "2 feb,2026", memberCount: 7),
  ].obs;

  void toggleSelectAll(bool? val) {
    isAllSelected.value = val ?? false;
    for (var team in teamsList) {
      team.isSelected = isAllSelected.value;
    }
    teamsList.refresh();
  }

  void toggleTeamSelection(int index, bool? val) {
    teamsList[index].isSelected = val ?? false;
    isAllSelected.value = teamsList.every((team) => team.isSelected);
    teamsList.refresh();
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

         /// Edit Team
  final editTeamNameCtrl = TextEditingController(text: "AI Engineer");
  var selectedFilter = "Employee Name".obs;
  var searchQuery = "".obs;
  var isMemberAllSelected = false.obs;
  var teamMembersList = <TeamMemberModel>[
    TeamMemberModel(
      id: "1",
      name: "Jack Milson",
      email: "jack@gmail.com",
      role: "Ui Ux designer",
      department: "Design",
      joiningDate: "08/08/26",
    ),
    TeamMemberModel(
      id: "2",
      name: "Talha bukhari",
      email: "talha@gmail.com",
      role: "Front end Dev",
      department: "Development",
      joiningDate: "08/08/26",
    ),
    TeamMemberModel(
      id: "3",
      name: "Hussain Ali",
      email: "hussain@gmail.com",
      role: "Ui Ux designer",
      department: "Design",
      joiningDate: "08/08/26",
    ),
    TeamMemberModel(
      id: "4",
      name: "Ayan Ali",
      email: "ayan@gmail.com",
      role: "Back End dev",
      department: "Development",
      joiningDate: "08/08/26",
    ),
  ].obs;

  void toggleSelectAllMembers(bool? val) {
    isMemberAllSelected.value = val ?? false;
    for (var member in teamMembersList) {
      member.isSelected = isMemberAllSelected.value;
    }
    teamMembersList.refresh();
  }

  void toggleMemberSelection(int index, bool? val) {
    teamMembersList[index].isSelected = val ?? false;
    isMemberAllSelected.value = teamMembersList.every((m) => m.isSelected);
    teamMembersList.refresh();
  }
  void removeMember(int index) {
    teamMembersList.removeAt(index);
    teamMembersList.refresh();
  }


   /// Add Team
  final addTeamNameCtrl = TextEditingController();
  var addSearchQuery = "".obs;
  var addSelectedFilter = "Employee Name".obs;
  var isAddMemberAllSelected = false.obs;
  var addCurrentPage = 1.obs;
  var addTotalPages = 4.obs;
  var addItemsPerPage = 8.obs;
  var addTeamMembersList = <TeamMemberModel>[
    TeamMemberModel(
      id: "1",
      name: "Jack Milson",
      email: "jack@gmail.com",
      role: "Ui Ux designer",
      department: "Design",
      joiningDate: "08/08/26",
    ),
    TeamMemberModel(
      id: "2",
      name: "Talha bukhari",
      email: "talha@gmail.com",
      role: "Front end Dev",
      department: "Development",
      joiningDate: "08/08/26",
    ),
    TeamMemberModel(
      id: "3",
      name: "Hussain Ali",
      email: "hussain@gmail.com",
      role: "Ui Ux designer",
      department: "Design",
      joiningDate: "08/08/26",
    ),
    TeamMemberModel(
      id: "4",
      name: "Ayan Ali",
      email: "ayan@gmail.com",
      role: "Back End dev",
      department: "Development",
      joiningDate: "08/08/26",
    ),
    TeamMemberModel(
      id: "5",
      name: "Jhon Doe",
      email: "jhon@gmail.com",
      role: "QA",
      department: "Development",
      joiningDate: "08/08/26",
    ),
  ].obs;


  /// Add Team

  void toggleSelectAllAddMembers(bool? val) {
    isAddMemberAllSelected.value = val ?? false;
    for (var member in addTeamMembersList) {
      member.isSelected = isAddMemberAllSelected.value;
    }
    addTeamMembersList.refresh();
  }

  void toggleAddMemberSelection(int index, bool? val) {
    addTeamMembersList[index].isSelected = val ?? false;
    isAddMemberAllSelected.value = addTeamMembersList.every((m) => m.isSelected);
    addTeamMembersList.refresh();
  }

  void removeAddMember(int index) {
    addTeamMembersList.removeAt(index);
    addTeamMembersList.refresh();
  }
  void createTeam() {
    if (addTeamNameCtrl.text.isNotEmpty) {
      teamsList.add(
        TeamModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: addTeamNameCtrl.text,
          creationDate: "08/08/26",
          memberCount: addTeamMembersList.where((m) => m.isSelected).length,
        ),
      );
      addTeamNameCtrl.clear();
    }
  }
  void addNextPage() {
    if (addCurrentPage.value < addTotalPages.value) {
      addCurrentPage.value++;
    }
  }

  void addPreviousPage() {
    if (addCurrentPage.value > 1) {
      addCurrentPage.value--;
    }
  }



}

   /// View Team
extension TeamViewExtension on TeamVendorController {

  static final selectedTabIndex = 0.obs;

  static final membersList = <EmployeeMemberModel>[
    EmployeeMemberModel(
      id: "1",
      name: "Ali Hamza",
      email: "alihamza@gmail.com",
      role: "UI UX Designer",
      department: "Design",
      joiningDate: "8/06/26",
      status: MemberStatus.active,
    ),
    EmployeeMemberModel(
      id: "2",
      name: "Talha Bukhari",
      email: "talha83@gmail.com",
      role: "Front End Dev",
      department: "Development",
      joiningDate: "8/06/26",
      status: MemberStatus.offline,
    ),
    EmployeeMemberModel(
      id: "3",
      name: "Ahmad Ali",
      email: "ahmadali@gmail.com",
      role: "SEO",
      department: "Marketing",
      joiningDate: "8/06/26",
      status: MemberStatus.idle,
    ),
    EmployeeMemberModel(
      id: "4",
      name: "Athar Ahmad",
      email: "athar@gmail.com",
      role: "Project Manager",
      department: "Management",
      joiningDate: "8/06/26",
      status: MemberStatus.active,
    ),
    EmployeeMemberModel(
      id: "5",
      name: "bilal Ali",
      email: "bilal83@gmail.com",
      role: "Back End Dev",
      department: "Development",
      joiningDate: "8/06/26",
      status: MemberStatus.offline,
    ),
    EmployeeMemberModel(
      id: "6",
      name: "Huzaifa Zia",
      email: "Huzaifa@gmail.com",
      role: "Ai Engineer",
      department: "Development",
      joiningDate: "8/06/26",
      status: MemberStatus.idle,
    ),
  ].obs;
  List<EmployeeMemberModel> get filteredMembers {
    if (selectedTabIndex.value == 1) {
      return membersList.where((m) => m.status == MemberStatus.active).toList();
    } else if (selectedTabIndex.value == 2) {
      return membersList.where((m) => m.status == MemberStatus.offline).toList();
    } else if (selectedTabIndex.value == 3) {
      return membersList.where((m) => m.status == MemberStatus.idle).toList();
    }
    return membersList;
  }

  void deleteMember(String id) {
    membersList.removeWhere((m) => m.id == id);
    membersList.refresh();
  }
}