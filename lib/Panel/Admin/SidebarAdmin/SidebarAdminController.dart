


import 'dart:async';
import 'package:get/get.dart';

class SidebarAdminController extends GetxController {
  var selected = "Dashboard".obs;
  var selectedSubItem = "".obs;
  var notificationCount = 0.obs;
  var isCollapsed = false.obs;

  void toggleSidebar() {
    isCollapsed.value = !isCollapsed.value;
  }

  void selectMenu(String title, {String subItem = ""}) {
    selected.value = title;
    selectedSubItem.value = subItem;
  }

  void syncWithRoute(String route) {
    if (route == '/dashboard' || route == '/') {
      selected.value = "Dashboard";
      selectedSubItem.value = "";
    } else if (route.startsWith('/companies')) {
      selected.value = "Companies";
      selectedSubItem.value = "";
    } else if (route.startsWith('/reports')) {
      selected.value = "Reports";
      selectedSubItem.value = "";
    } else if (route.startsWith('/subscription')) {
      selected.value = "Subscription";
      selectedSubItem.value = "";
    } else if (route.startsWith('/pricing-plans')) {
      selected.value = "Pricing Plans";
      selectedSubItem.value = "";
    } else if (route.startsWith('/demo-requests')) {
      selected.value = "Demo Requests";
      selectedSubItem.value = "";
    } else if (route.startsWith('/payment')) {
      selected.value = "Payment";
      selectedSubItem.value = "";
    } else if (route.startsWith('/user-and-role')) {
      selected.value = "User and Role";
      selectedSubItem.value = "";
    } else if (route.startsWith('/help-center')) {
      selected.value = "Help Center";
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