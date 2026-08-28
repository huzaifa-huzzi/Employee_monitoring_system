import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SubscriptionItem {
  final String id;
  final String companyName;
  final String plan;
  final String cycle;
  final String startDate;
  final String endDate;
  final String pricing;
  final String status;
  RxBool isSelected;

  SubscriptionItem({
    required this.id,
    required this.companyName,
    required this.plan,
    required this.cycle,
    required this.startDate,
    required this.endDate,
    required this.pricing,
    required this.status,
    bool isSelected = false,
  }) : isSelected = isSelected.obs;
}

class SubscriptionController extends GetxController {
  final selectedTab = 'All'.obs;
  final tabs = ['All', 'Active', 'Suspended', 'Expired'];
  final searchQuery = ''.obs;
  final selectedFilter = 'Company Name'.obs;
  final resultsPerPage = 5.obs;
  final currentPage = 1.obs;
  var rowsPerPage = 5.obs;
  final searchController = TextEditingController();

  // Master List Data
  final RxList<SubscriptionItem> allSubscriptions = <SubscriptionItem>[
    SubscriptionItem(id: '1', companyName: 'Journey One', plan: 'Enterprise', cycle: 'Monthly', startDate: '4/06/26', endDate: '4/07/26', pricing: '\$ 280', status: 'Active'),
    SubscriptionItem(id: '2', companyName: 'VGW', plan: 'Growth', cycle: 'Monthly', startDate: '4/06/26', endDate: '4/07/26', pricing: '\$ 280', status: 'Active'),
    SubscriptionItem(id: '3', companyName: 'Data Divers', plan: 'Growth', cycle: 'Yearly', startDate: '4/06/26', endDate: '4/07/27', pricing: '\$3200', status: 'Suspended'),
    SubscriptionItem(id: '4', companyName: 'Horizon Power', plan: 'Starter', cycle: 'Monthly', startDate: '4/06/26', endDate: '4/07/26', pricing: '\$ 280', status: 'Expired'),
    SubscriptionItem(id: '5', companyName: 'Hello People', plan: 'Trail', cycle: 'Yearly', startDate: '4/06/26', endDate: '4/07/27', pricing: '\$3200', status: 'Active'),
  ].obs;

  final totalNewSubscriptions = '12'.obs;
  final totalWeeklySubscriptions = '5'.obs;
  final totalMonthlySubscriptions = '345'.obs;
  final totalYearlySubscriptions = '10k'.obs;

  final isSelectAll = false.obs;

  List<SubscriptionItem> get filteredSubscriptions {
    return allSubscriptions.where((item) {
      bool matchesTab = selectedTab.value == 'All' || item.status == selectedTab.value;
      bool matchesSearch = item.companyName.toLowerCase().contains(searchQuery.value.toLowerCase());

      return matchesTab && matchesSearch;
    }).toList();
  }

  void toggleSelectAll(bool? val) {
    isSelectAll.value = val ?? false;
    for (var item in filteredSubscriptions) {
      item.isSelected.value = isSelectAll.value;
    }
  }

  void toggleRowSelection(SubscriptionItem item, bool? val) {
    item.isSelected.value = val ?? false;

    if (filteredSubscriptions.isNotEmpty) {
      isSelectAll.value = filteredSubscriptions.every((element) => element.isSelected.value);
    } else {
      isSelectAll.value = false;
    }
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
    isSelectAll.value = false;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}