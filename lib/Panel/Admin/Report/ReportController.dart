



import 'package:get/get.dart';

class ReportModel {
  final String id;
  final String name;
  final String category;
  final String lastGenerated;
  final String status; // 'Ready', 'In Progress', 'No Reports', 'Failed'
  bool isSelected;

  ReportModel({
    required this.id,
    required this.name,
    required this.category,
    required this.lastGenerated,
    required this.status,
    this.isSelected = false,
  });
}

class ReportController extends GetxController {
  // Loading & State Indicators
  var isLoading = false.obs;

  // Stat Summary Data
  var totalReports = '0'.obs;
  var reportsGeneratedToday = '0'.obs;
  var totalDownloads = '0'.obs;
  var lastGeneratedReport = ''.obs;

  // Pagination & Table State
  var rowsPerPage = 5.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var isAllSelected = false.obs;

  // Reactive List
  RxList<ReportModel> reportsList = <ReportModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReports(); // Controller initialize hone par data automatically fetch hoga
  }

  // API Call to Fetch Data
  Future<void> fetchReports() async {
    try {
      isLoading.value = true;

      // TODO: Replace with your actual backend API Service call
      // Example: var response = await ApiService.getReports(page: currentPage.value, limit: rowsPerPage.value);

      // Demo Data Assignment
      await Future.delayed(const Duration(milliseconds: 500)); // Simulating network delay

      // Update Stats & Pagination from Backend Response
      totalReports.value = '6';
      reportsGeneratedToday.value = '10';
      totalDownloads.value = '23';
      lastGeneratedReport.value = 'Company Growth';
      totalPages.value = 4;

    } catch (e) {
      Get.snackbar("Error", "Failed to load reports: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Checkbox Selection Logic
  void toggleSelectAll(bool? val) {
    isAllSelected.value = val ?? false;
    for (var report in reportsList) {
      report.isSelected = isAllSelected.value;
    }
    reportsList.refresh();
  }

  void toggleSelectReport(int index, bool? val) {
    reportsList[index].isSelected = val ?? false;
    isAllSelected.value = reportsList.every((element) => element.isSelected);
    reportsList.refresh();
  }

  // Backend Actions
  Future<void> onViewReport(ReportModel report) async {
    // Navigate or fetch report details API
  }

  Future<void> onRegenerateReport(ReportModel report) async {
    // Call Regenerate API
  }

  Future<void> onDownloadReport(ReportModel report) async {
    // Call Download API / File Saver
  }
}