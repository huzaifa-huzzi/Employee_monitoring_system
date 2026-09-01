import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DemoRequestModel {
  final String requestId;
  final String company;
  final String ownerName;
  final String ownerEmail;
  final String phoneNumber;
  final int noOfEmployees;
  final String submissionDate;
  final String status;
  RxBool isSelected;

  DemoRequestModel({
    required this.requestId,
    required this.company,
    required this.ownerName,
    required this.ownerEmail,
    required this.phoneNumber,
    required this.noOfEmployees,
    required this.submissionDate,
    required this.status,
    bool isSelected = false,
  }) : isSelected = isSelected.obs;
}

class DemoController extends GetxController {
  final List<String> tabs = ["All", "New", "Scheduled", "Completed", "Closed"];
  RxString selectedTab = "All".obs;

  final RxString selectedSearchFilter = 'Company Name'.obs;
  final RxBool isFilterDropdownOpen = false.obs;

  // Pagination Dropdown States (existing)
  final RxInt resultsPerPage = 10.obs;
  final RxBool isResultsPerPageDropdownOpen = false.obs;

  final searchController = TextEditingController();
  RxString selectedFilter = "Company Name".obs;


  // Select All Header State
  RxBool isAllSelected = false.obs;

  var allRequests = <DemoRequestModel>[
    DemoRequestModel(
      requestId: "1234",
      company: "Journey One",
      ownerName: "Adam Jhones",
      ownerEmail: "adam@gmail.com",
      phoneNumber: "+61 4 1234 5678",
      noOfEmployees: 24,
      submissionDate: "4/07/27",
      status: "New",
    ),
    DemoRequestModel(
      requestId: "1234",
      company: "VGW",
      ownerName: "Adam Jhones",
      ownerEmail: "adam@gmail.com",
      phoneNumber: "+61 4 1234 5678",
      noOfEmployees: 32,
      submissionDate: "4/07/27",
      status: "Scheduled",
    ),
    DemoRequestModel(
      requestId: "1234",
      company: "Data Divers.io",
      ownerName: "Adam Jhones",
      ownerEmail: "adam@gmail.com",
      phoneNumber: "+61 4 1234 5678",
      noOfEmployees: 15,
      submissionDate: "4/07/27",
      status: "Scheduled",
    ),
    DemoRequestModel(
      requestId: "1234",
      company: "Horizon Power Digital",
      ownerName: "Adam Jhones",
      ownerEmail: "adam@gmail.com",
      phoneNumber: "+61 4 1234 5678",
      noOfEmployees: 30,
      submissionDate: "4/07/27",
      status: "Completed",
    ),
    DemoRequestModel(
      requestId: "1234",
      company: "Hello People",
      ownerName: "Adam Jhones",
      ownerEmail: "adam@gmail.com",
      phoneNumber: "+61 4 1234 5678",
      noOfEmployees: 40,
      submissionDate: "4/07/27",
      status: "Closed",
    ),
  ].obs;

  List<DemoRequestModel> get filteredRequests {
    if (selectedTab.value == "All") {
      return allRequests;
    }
    return allRequests
        .where((req) => req.status.toLowerCase() == selectedTab.value.toLowerCase())
        .toList();
  }

  void selectTab(String tab) {
    selectedTab.value = tab;
    checkIfAllSelected();
  }

  void toggleSelectAll(bool? value) {
    bool val = value ?? false;
    isAllSelected.value = val;
    for (var req in filteredRequests) {
      req.isSelected.value = val;
    }
  }

  void toggleIndividualSelect(DemoRequestModel item, bool? value) {
    item.isSelected.value = value ?? false;
    checkIfAllSelected();
  }

  void checkIfAllSelected() {
    if (filteredRequests.isEmpty) {
      isAllSelected.value = false;
      return;
    }
    isAllSelected.value = filteredRequests.every((req) => req.isSelected.value);
  }

  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  final RxBool isLoading = false.obs;

  void sendEmail() async {
    if (subjectController.text.trim().isEmpty || messageController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please fill all fields",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.rejectedColor,
          colorText: AppColors.whiteColor);
      return;
    }

    try {
      isLoading.value = true;
      // TODO: Add your API service call here
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar("Success", "Email sent successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.approvedColor,
          colorText: AppColors.whiteColor);

      subjectController.clear();
      messageController.clear();
    } catch (e) {
      Get.snackbar("Error", "Failed to send email: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.rejectedColor,
          colorText: AppColors.whiteColor);
    } finally {
      isLoading.value = false;
    }
  }


  final demoDateController = TextEditingController();
  final demoTimeController = TextEditingController();
  final durationController = TextEditingController();

  final RxString selectedMeetingType = 'Enter Type'.obs;
  final RxBool isMeetingTypeDropdownOpen = false.obs;

  void scheduleDemo() async {
    if (demoDateController.text.isEmpty ||
        demoTimeController.text.isEmpty ||
        durationController.text.isEmpty ||
        selectedMeetingType.value == 'Enter Type') {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.rejectedColor,
        colorText: AppColors.whiteColor,
      );
      return;
    }

    try {
      isLoading.value = true;
      // TODO: Call your Schedule Demo API endpoint here
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        "Success",
        "Demo scheduled successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.approvedColor,
        colorText: AppColors.whiteColor,
      );

      demoDateController.clear();
      demoTimeController.clear();
      durationController.clear();
      selectedMeetingType.value = 'Enter Type';
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to schedule demo: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.rejectedColor,
        colorText: AppColors.whiteColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    searchController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}