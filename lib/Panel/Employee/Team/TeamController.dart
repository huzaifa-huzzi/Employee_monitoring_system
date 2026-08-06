import 'package:get/get.dart';
import 'package:employee_monitoring_system/Resources/ImageString.dart';

// Models
class TeamProjectModel {
  final String projectName;
  final String startDate;
  final String endDate;
  final List<String> avatars;
  final int remainingCount;
  bool isSelected;

  TeamProjectModel({
    required this.projectName,
    required this.startDate,
    required this.endDate,
    required this.avatars,
    required this.remainingCount,
    this.isSelected = false,
  });
}

class TeamMemberModel {
  final String name;
  final String email;
  final String role;
  final String department;
  final String status;
  final String avatarUrl;

  TeamMemberModel({
    required this.name,
    required this.email,
    required this.role,
    required this.department,
    required this.status,
    required this.avatarUrl,
  });
}

class TeamController extends GetxController {

  // Project List
  RxInt currentPage = 1.obs;
  RxInt totalPages = 10.obs;
  RxBool selectAll = false.obs;

  RxList<TeamProjectModel> projects = <TeamProjectModel>[
    TeamProjectModel(
      projectName: 'WorkPulse',
      startDate: '2 feb,2026',
      endDate: 'In progress',
      avatars: [
        ImageString.user1,
        ImageString.user2,
        ImageString.user3,
      ],
      remainingCount: 5,
    ),
    TeamProjectModel(
      projectName: 'WorkPulse',
      startDate: '2 feb,2026',
      endDate: 'In progress',
      avatars: [
        ImageString.user1,
        ImageString.user2,
        ImageString.user3,
      ],
      remainingCount: 5,
    ),
    TeamProjectModel(
      projectName: 'WorkPulse',
      startDate: '2 feb,2026',
      endDate: 'In progress',
      avatars: [
        ImageString.user1,
        ImageString.user2,
        ImageString.user3,
      ],
      remainingCount: 5,
    ),
    TeamProjectModel(
      projectName: 'WorkPulse',
      startDate: '2 feb,2026',
      endDate: 'In progress',
      avatars: [
        ImageString.user1,
        ImageString.user2,
        ImageString.user3,
      ],
      remainingCount: 5,
    ),
    TeamProjectModel(
      projectName: 'WorkPulse',
      startDate: '2 feb,2026',
      endDate: 'In progress',
      avatars: [
        ImageString.user1,
        ImageString.user2,
        ImageString.user3,
      ],
      remainingCount: 5,
    ),
    TeamProjectModel(
      projectName: 'WorkPulse',
      startDate: '2 feb,2026',
      endDate: 'In progress',
      avatars: [
        ImageString.user1,
        ImageString.user2,
        ImageString.user3,
      ],
      remainingCount: 5,
    ),
    TeamProjectModel(
      projectName: 'WorkPulse',
      startDate: '2 feb,2026',
      endDate: 'In progress',
      avatars: [
        ImageString.user1,
        ImageString.user2,
        ImageString.user3,
      ],
      remainingCount: 5,
    ),
  ].obs;

  void toggleSelectAll(bool? val) {
    selectAll.value = val ?? false;
    for (var p in projects) {
      p.isSelected = selectAll.value;
    }
    projects.refresh();
  }

  void toggleItemSelect(int index, bool? val) {
    projects[index].isSelected = val ?? false;
    projects.refresh();
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

  //  Team Members Screen

  final List<String> memberTabs = ['All', 'Active', 'Offline', 'Idle'];
  RxString selectedTab = 'All'.obs;

  RxList<TeamMemberModel> allMembers = <TeamMemberModel>[
    TeamMemberModel(
      name: 'Ali Hamza',
      email: 'alihamza@gmail.com',
      role: 'UI UX Designer',
      department: 'Design',
      status: 'Active',
      avatarUrl: ImageString.user1,
    ),
    TeamMemberModel(
      name: 'Talha Bukhari',
      email: 'talha83@gmail.com',
      role: 'Front End Dev',
      department: 'Development',
      status: 'Offline',
      avatarUrl: ImageString.user2,
    ),
    TeamMemberModel(
      name: 'Ahmad Ali',
      email: 'ahmadali@gmail.com',
      role: 'SEO',
      department: 'Marketing',
      status: 'Idle',
      avatarUrl: ImageString.user3,
    ),
    TeamMemberModel(
      name: 'Athar Ahmad',
      email: 'athar@gmail.com',
      role: 'Project Manager',
      department: 'Management',
      status: 'Active',
      avatarUrl: ImageString.user1,
    ),
    TeamMemberModel(
      name: 'bilal Ali',
      email: 'bilal83@gmail.com',
      role: 'Back End Dev',
      department: 'Development',
      status: 'Offline',
      avatarUrl: ImageString.user2,
    ),
    TeamMemberModel(
      name: 'Huzaifa Zia',
      email: 'Huzaifa@gmail.com',
      role: 'Ai Engineer',
      department: 'Development',
      status: 'Idle',
      avatarUrl: ImageString.user3,
    ),
  ].obs;


  List<TeamMemberModel> get filteredMembers {
    if (selectedTab.value == 'All') {
      return allMembers;
    } else {
      return allMembers
          .where((m) => m.status.toLowerCase() == selectedTab.value.toLowerCase())
          .toList();
    }
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }
}