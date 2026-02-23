import 'package:get/get.dart';
import 'dart:async';

class SideBarController extends GetxController {
  var selected = "Dashboard".obs;
  var isTimeSheetExpanded = false.obs;
  var isReportExpanded = false.obs;
  var notificationCount = 0.obs;
  var isCollapsed = false.obs;

  void toggleSidebar() {
    isCollapsed.value = !isCollapsed.value;
  }

  // Time Sheet dropdown toggle
  void toggleTimeSheet() {
    isTimeSheetExpanded.value = !isTimeSheetExpanded.value;
    selected.value = "Time Sheet";
  }

  // Report dropdown toggle
  void toggleReport() {
    isReportExpanded.value = !isReportExpanded.value;
    selected.value = "Report";
  }

  void selectMenu(String title) {
    selected.value = title;

    if (title != "Time Sheet") isTimeSheetExpanded.value = false;
    if (title != "Report") isReportExpanded.value = false;
  }


  void syncWithRoute(String route) {

    if (route == '/dashboard' || route == '/') {
      selected.value = "Dashboard";
    } else if (route.startsWith('/team')) {
      selected.value = "Team";
    } else if (route.startsWith('/screenshots')) {
      selected.value = "Screen Shots";
    } else if (route.startsWith('/activity')) {
      selected.value = "Activity Tracking";
    } else if (route.startsWith('/app-tracking')) {
      selected.value = "Application Tracking";
    } else if (route.startsWith('/url-tracking')) {
      selected.value = "URL Tracking";
    } else if (route.startsWith('/meeting')) {
      selected.value = "Meeting";
    } else if (route.startsWith('/projects')) {
      selected.value = "Project Management";
    } else if (route.startsWith('/settings')) {
      selected.value = "Setting";
    } else if (route.startsWith('/help')) {
      selected.value = "Help & Support";
    }
  }

  void setNotification(int value) {
    notificationCount.value = value;
  }


  /// Web App Bar
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