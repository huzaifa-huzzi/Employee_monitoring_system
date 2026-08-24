



import 'package:get/get.dart';

class ReportModel {
  final String id;
  final String name;
  final String category;
  final String lastGenerated;
  final String status;
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
  var isLoading = false.obs;

  var totalReports = '0'.obs;
  var reportsGeneratedToday = '0'.obs;
  var totalDownloads = '0'.obs;
  var lastGeneratedReport = ''.obs;

  var rowsPerPage = 5.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var isAllSelected = false.obs;

  RxList<ReportModel> reportsList = <ReportModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReports();
  }

  Future<void> fetchReports() async {
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(milliseconds: 500));

      totalReports.value = '6';
      reportsGeneratedToday.value = '10';
      totalDownloads.value = '23';
      lastGeneratedReport.value = 'Company Growth';
      totalPages.value = 4;

      reportsList.assignAll([
        ReportModel(
          id: '1',
          name: 'Organization Growth Report',
          category: 'Organization',
          lastGenerated: 'Today',
          status: 'Ready',
        ),
        ReportModel(
          id: '2',
          name: 'Revenue Report',
          category: 'Finance',
          lastGenerated: 'Today',
          status: 'Ready',
        ),
        ReportModel(
          id: '3',
          name: 'Subscription Report',
          category: 'Billing',
          lastGenerated: 'Yesterday',
          status: 'In Progress',
        ),
        ReportModel(
          id: '4',
          name: 'Payment Report',
          category: 'Finance',
          lastGenerated: '5 August, 2026',
          status: 'In Progress',
        ),
        ReportModel(
          id: '5',
          name: 'Platform Usage Report',
          category: 'Usage',
          lastGenerated: 'Today',
          status: 'No Reports',
        ),
        ReportModel(
          id: '6',
          name: 'Organization Performance Report',
          category: 'Analytics',
          lastGenerated: 'Yesterday',
          status: 'Failed',
        ),
      ]);

    } catch (e) {
      Get.snackbar("Error", "Failed to load reports: $e");
    } finally {
      isLoading.value = false;
    }
  }

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

  Future<void> onViewReport(ReportModel report) async {}
  Future<void> onRegenerateReport(ReportModel report) async {}
  Future<void> onDownloadReport(ReportModel report) async {}
}