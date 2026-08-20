import 'package:get/get.dart';


class CompanyModel {
  final String id;
  final String name;
  final String ownerName;
  final String email;
  final String emailStatus;
  final String accountStatus;
  final String subscription;
  final String subscriptionStatus;
  final String joiningDate;
  final int employeesCount;
  bool isSelected;

  CompanyModel({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.email,
    required this.emailStatus,
    required this.accountStatus,
    required this.subscription,
    required this.subscriptionStatus,
    required this.joiningDate,
    required this.employeesCount,
    this.isSelected = false,
  });
}

class CompaniesController extends GetxController {
    /// Main Screen
  var totalCompaniesCount = 35.obs;
  var activeCompaniesCount = 22.obs;
  var suspendedCompaniesCount = 6.obs;
  var newJoinedCompaniesCount = 8.obs;
  var selectedFilterCategory = 'Email Status'.obs;
  var activeTab = 'All'.obs;
  var searchFilterField = 'Company Name'.obs;
  var searchQuery = ''.obs;

  var isCategoryDropdownOpen = false.obs;
  var isSearchDropdownOpen = false.obs;
  var isResultsPerPageDropdownOpen = false.obs;

  var resultsPerPage = 5.obs;
  var currentPage = 1.obs;
  var isAllSelected = false.obs;
  RxList<CompanyModel> companiesList = <CompanyModel>[
    CompanyModel(
      id: '1',
      name: 'Journey One',
      ownerName: 'Adam Jhon',
      email: 'operations@rmkble.com.au',
      emailStatus: 'Not Verified',
      accountStatus: 'Active',
      subscription: 'Monthly',
      subscriptionStatus: 'Demo',
      joiningDate: '5 August, 2026',
      employeesCount: 50,
    ),
    CompanyModel(
      id: '2',
      name: 'VGW',
      ownerName: 'Adam Jhon',
      email: 'media@vgw.co',
      emailStatus: 'Verified',
      accountStatus: 'Pending',
      subscription: 'Monthly',
      subscriptionStatus: 'Subscribed',
      joiningDate: '12 July, 2026',
      employeesCount: 120,
    ),
    CompanyModel(
      id: '3',
      name: 'Data Divers.io',
      ownerName: 'Adam Jhon',
      email: 'datadivers@gmail.com.au',
      emailStatus: 'Not Verified',
      accountStatus: 'Active',
      subscription: 'Yearly',
      subscriptionStatus: 'Overdue',
      joiningDate: '10 June, 2026',
      employeesCount: 15,
    ),
    CompanyModel(
      id: '4',
      name: 'Horizon Power Digital',
      ownerName: 'Adam Jhon',
      email: 'horizon@gmail.com.au',
      emailStatus: 'Verified',
      accountStatus: 'Inactive',
      subscription: 'Monthly',
      subscriptionStatus: 'Cancelled',
      joiningDate: '1 January, 2026',
      employeesCount: 200,
    ),
    CompanyModel(
      id: '5',
      name: 'Hello People',
      ownerName: 'Adam Jhon',
      email: 'info@hellopeople.com.au',
      emailStatus: 'Verified',
      accountStatus: 'Pending',
      subscription: 'Yearly',
      subscriptionStatus: 'Demo',
      joiningDate: '28 February, 2026',
      employeesCount: 45,
    ),
  ].obs;

  void changeFilterCategory(String category) {
    selectedFilterCategory.value = category;
    activeTab.value = 'All';
  }
  List<String> get currentCategoryTabs {
    switch (selectedFilterCategory.value) {
      case 'Account Status':
        return ['All', 'Pending', 'Active', 'Inactive'];
      case 'Plan Status':
        return ['All', 'Demo', 'Subscribed', 'Overdue', 'Cancelled'];
      case 'Email Status':
      default:
        return ['All', 'Verified', 'Not Verified'];
    }
  }
  int getTabCount(String tabName) {
    if (tabName == 'All') return companiesList.length;

    switch (selectedFilterCategory.value) {
      case 'Account Status':
        return companiesList.where((c) => c.accountStatus == tabName).length;
      case 'Plan Status':
        return companiesList.where((c) => c.subscriptionStatus == tabName).length;
      case 'Email Status':
      default:
        return companiesList.where((c) => c.emailStatus == tabName).length;
    }
  }
  List<CompanyModel> get filteredCompanies {
    return companiesList.where((company) {
      if (activeTab.value != 'All') {
        if (selectedFilterCategory.value == 'Email Status' && company.emailStatus != activeTab.value) {
          return false;
        }
        if (selectedFilterCategory.value == 'Account Status' && company.accountStatus != activeTab.value) {
          return false;
        }
        if (selectedFilterCategory.value == 'Plan Status' && company.subscriptionStatus != activeTab.value) {
          return false;
        }
      }
      if (searchQuery.value.isNotEmpty) {
        String query = searchQuery.value.toLowerCase();
        if (searchFilterField.value == 'Company Name') {
          return company.name.toLowerCase().contains(query);
        } else if (searchFilterField.value == 'Owner Name') {
          return company.ownerName.toLowerCase().contains(query);
        } else if (searchFilterField.value == 'Email') {
          return company.email.toLowerCase().contains(query);
        }
      }
      return true;
    }).toList();
  }

  void toggleSelectAll(bool? val) {
    isAllSelected.value = val ?? false;
    for (var company in companiesList) {
      company.isSelected = isAllSelected.value;
    }
    companiesList.refresh();
  }

  void toggleItemSelection(CompanyModel company, bool? val) {
    company.isSelected = val ?? false;
    isAllSelected.value = companiesList.every((e) => e.isSelected);
    companiesList.refresh();
  }
}