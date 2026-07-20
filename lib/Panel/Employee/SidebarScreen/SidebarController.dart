import 'package:get/get.dart';
import 'dart:async';

class SideBarController extends GetxController {
  var selected = "Dashboard".obs;
  var selectedSubItem = "".obs;
  var isTimeSheetExpanded = false.obs;
  var isReportExpanded = false.obs;
  var notificationCount = 0.obs;
  var isCollapsed = false.obs;

  void toggleSidebar() {
    isCollapsed.value = !isCollapsed.value;
  }

  void toggleTimeSheet() {
    isTimeSheetExpanded.value = !isTimeSheetExpanded.value;
    selected.value = "Time Sheet";
  }

  void toggleReport() {
    isReportExpanded.value = !isReportExpanded.value;
    selected.value = "Report";
  }

  void selectMenu(String title, {String subItem = ""}) {
    selected.value = title;
    selectedSubItem.value = subItem;

    if (title != "Time Sheet") isTimeSheetExpanded.value = false;
    if (title != "Report") isReportExpanded.value = false;
  }

  void syncWithRoute(String route) {
    if (route == '/dashboard' || route == '/') {
      selected.value = "Dashboard";
      selectedSubItem.value = "";
    } else if (route.startsWith('/team')) {
      selected.value = "Team";
      selectedSubItem.value = "";
    } else if (route.startsWith('/time-sheet')) {
      selected.value = "Time Sheet";
      isTimeSheetExpanded.value = true;
      if (route.contains('approvals')) {
        selectedSubItem.value = "Approvals";
      } else {
        selectedSubItem.value = "My time sheet";
      }
    } else if (route.startsWith('/screenshots')) {
      selected.value = "Screen Shots";
      selectedSubItem.value = "";
    } else if (route.startsWith('/activity')) {
      selected.value = "Activity Tracking";
      selectedSubItem.value = "";
    } else if (route.startsWith('/app-tracking')) {
      selected.value = "Application Tracking";
      selectedSubItem.value = "";
    } else if (route.startsWith('/url-tracking')) {
      selected.value = "URL Tracking";
      selectedSubItem.value = "";
    } else if (route.startsWith('/meeting')) {
      selected.value = "Meeting";
      selectedSubItem.value = "";
    } else if (route.startsWith('/projects')) {
      selected.value = "Project Management";
      selectedSubItem.value = "";
    } else if (route.startsWith('/report')) {
      selected.value = "Report";
      isReportExpanded.value = true;
      selectedSubItem.value = "";
    } else if (route.startsWith('/settings')) {
      selected.value = "Setting";
      selectedSubItem.value = "";
    } else if (route.startsWith('/help')) {
      selected.value = "Help & Support";
      selectedSubItem.value = "";
    }
  }

  void setNotification(int value) {
    notificationCount.value = value;
  }

  /// Timer Logic
  var isRunning = false.obs;
  var seconds = 0.obs;
  Timer? _timer;

  void toggleTimer() {
    if (isRunning.value) {
      _timer?.cancel();
      isRunning.value = false;
    } else {
      isRunning.value = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        seconds.value++;
      });
    }
  }

  String get formattedTime {
    int h = seconds.value ~/ 3600;
    int m = (seconds.value % 3600) ~/ 60;
    int s = seconds.value % 60;
    return "$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  void signOut() {
    print("User Signed Out");
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}