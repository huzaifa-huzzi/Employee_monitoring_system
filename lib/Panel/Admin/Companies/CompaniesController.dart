import 'package:employee_monitoring_system/Panel/Admin/Companies/ReusableWidget/CustomDatePickerCompanyDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

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
  final String? phone;
  final String? address;
  final String? licenseNumber;
  final String? taxNumber;
  final String? endDate;
  final Uint8List? logoBytes;
  final String? logoFileName;
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? linkedin;
  final String? youtube;

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
    this.phone,
    this.address,
    this.licenseNumber,
    this.taxNumber,
    this.endDate,
    this.logoBytes,
    this.logoFileName,
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
    this.youtube,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ownerName': ownerName,
      'email': email,
      'emailStatus': emailStatus,
      'accountStatus': accountStatus,
      'subscription': subscription,
      'subscriptionStatus': subscriptionStatus,
      'joiningDate': joiningDate,
      'employeesCount': employeesCount,
      'phone': phone,
      'address': address,
      'licenseNumber': licenseNumber,
      'taxNumber': taxNumber,
      'endDate': endDate,
      'facebook': facebook,
      'twitter': twitter,
      'instagram': instagram,
      'linkedin': linkedin,
      'youtube': youtube,
    };
  }
}

class CompaniesController extends GetxController {
  var totalCompaniesCount = 35.obs;
  var activeCompaniesCount = 22.obs;
  var suspendedCompaniesCount = 6.obs;
  var newJoinedCompaniesCount = 8.obs;

  var isAccountStatusOpen = false.obs;
  var isPlanOpen = false.obs;
  var isPlanStatusOpen = false.obs;

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
      name: 'TechLogix Global',
      ownerName: 'Sarah Jenkins',
      email: 'contact@techlogix.io',
      emailStatus: 'Verified',
      accountStatus: 'Active',
      subscription: 'Yearly',
      subscriptionStatus: 'Subscribed',
      joiningDate: '20 June, 2026',
      employeesCount: 350,
    ),
    CompanyModel(
      id: '4',
      name: 'PlushDrives Rentals',
      ownerName: 'Michael Vance',
      email: 'info@plushdrives.com',
      emailStatus: 'Verified',
      accountStatus: 'Active',
      subscription: 'Yearly',
      subscriptionStatus: 'Subscribed',
      joiningDate: '01 May, 2026',
      employeesCount: 85,
    ),
    CompanyModel(
      id: '5',
      name: 'Nexus Cloud Services',
      ownerName: 'David Miller',
      email: 'support@nexuscloud.net',
      emailStatus: 'Not Verified',
      accountStatus: 'Inactive',
      subscription: 'Monthly',
      subscriptionStatus: 'Overdue',
      joiningDate: '18 April, 2026',
      employeesCount: 15,
    ),
    CompanyModel(
      id: '6',
      name: 'Apex Digital Solutions',
      ownerName: 'Elena Rostova',
      email: 'hello@apexdigital.org',
      emailStatus: 'Verified',
      accountStatus: 'Pending',
      subscription: 'Monthly',
      subscriptionStatus: 'Demo',
      joiningDate: '10 March, 2026',
      employeesCount: 40,
    ),
    CompanyModel(
      id: '7',
      name: 'Swift Logistics Hub',
      ownerName: 'Robert Vance',
      email: 'dispatch@swiftlogistics.com',
      emailStatus: 'Verified',
      accountStatus: 'Active',
      subscription: 'Yearly',
      subscriptionStatus: 'Subscribed',
      joiningDate: '14 February, 2026',
      employeesCount: 210,
    ),
    CompanyModel(
      id: '8',
      name: 'Horizon Software Ltd',
      ownerName: 'Sophia Chen',
      email: 'billing@horizonsoft.co',
      emailStatus: 'Not Verified',
      accountStatus: 'Pending',
      subscription: 'Monthly',
      subscriptionStatus: 'Cancelled',
      joiningDate: '28 January, 2026',
      employeesCount: 65,
    ),
    CompanyModel(
      id: '9',
      name: 'Vanguard Cyber Tech',
      ownerName: 'James Wilson',
      email: 'sec@vanguardcyber.com',
      emailStatus: 'Verified',
      accountStatus: 'Active',
      subscription: 'Yearly',
      subscriptionStatus: 'Subscribed',
      joiningDate: '05 January, 2026',
      employeesCount: 500,
    ),
    CompanyModel(
      id: '10',
      name: 'GreenField Energy',
      ownerName: 'Emma Watson',
      email: 'corporate@greenfield.io',
      emailStatus: 'Verified',
      accountStatus: 'Inactive',
      subscription: 'Monthly',
      subscriptionStatus: 'Overdue',
      joiningDate: '12 December, 2025',
      employeesCount: 95,
    ),
  ].obs;


  final nameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final licenseController = TextEditingController();
  final joiningDate = TextEditingController();
  final noOfEmployee = TextEditingController();
  final endDateController = TextEditingController();
  final employeesCountController = TextEditingController();

  final facebookController = TextEditingController();
  final twitterController = TextEditingController();
  final instagramController = TextEditingController();
  final linkedinController = TextEditingController();
  final youtubeController = TextEditingController();

  var accountStatus = 'Active'.obs;
  var emailStatus = 'Verified'.obs;
  var plan = 'Monthly'.obs;
  var planStatus = 'Subscribed'.obs;
  final startDateController = TextEditingController();

   // Image Picker
  Rx<Uint8List?> selectedImageBytes = Rx<Uint8List?>(null);
  RxnString selectedFileName = RxnString();

  Future<void> pickLogo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'webp'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;

        if (file.bytes != null) {
          selectedImageBytes.value = file.bytes;
        } else if (file.path != null) {
          selectedImageBytes.value = await File(file.path!).readAsBytes();
        }

        selectedFileName.value = file.name;
        selectedImageBytes.refresh();
        selectedFileName.refresh();
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  void submitForm() {
    final newCompany = CompanyModel(
      id: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
      name: nameController.text
          .trim()
          .isEmpty ? 'New Company' : nameController.text.trim(),
      ownerName: ownerNameController.text
          .trim()
          .isEmpty ? 'Admin' : ownerNameController.text.trim(),
      email: emailController.text.trim(),
      emailStatus: emailStatus.value,
      accountStatus: accountStatus.value,
      subscription: plan.value,
      subscriptionStatus: planStatus.value,
      joiningDate: joiningDate.text
          .trim()
          .isEmpty ? '21 August, 2026' : joiningDate.text.trim(),
      employeesCount: int.tryParse(employeesCountController.text.trim()) ?? 0,
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      licenseNumber: licenseController.text.trim(),
      taxNumber: noOfEmployee.text.trim(),
      endDate: endDateController.text.trim(),
      logoBytes: selectedImageBytes.value,
      logoFileName: selectedFileName.value,
      facebook: facebookController.text.trim(),
      twitter: twitterController.text.trim(),
      instagram: instagramController.text.trim(),
      linkedin: linkedinController.text.trim(),
      youtube: youtubeController.text.trim(),
    );

    companiesList.insert(0, newCompany);
    totalCompaniesCount.value++;
    clearForm();
    Get.back();
  }

  // Clear Form Fields
  void clearForm() {
    nameController.clear();
    ownerNameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    licenseController.clear();
    noOfEmployee.clear();
    joiningDate.clear();
    endDateController.clear();
    employeesCountController.clear();
    facebookController.clear();
    twitterController.clear();
    instagramController.clear();
    linkedinController.clear();
    youtubeController.clear();
    selectedImageBytes.value = null;
    selectedFileName.value = null;
  }

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
        return companiesList
            .where((c) => c.accountStatus == tabName)
            .length;
      case 'Plan Status':
        return companiesList
            .where((c) => c.subscriptionStatus == tabName)
            .length;
      case 'Email Status':
      default:
        return companiesList
            .where((c) => c.emailStatus == tabName)
            .length;
    }
  }

  List<CompanyModel> get filteredCompanies {
    return companiesList.where((company) {
      if (activeTab.value != 'All') {
        if (selectedFilterCategory.value == 'Email Status' &&
            company.emailStatus != activeTab.value) {
          return false;
        }
        if (selectedFilterCategory.value == 'Account Status' &&
            company.accountStatus != activeTab.value) {
          return false;
        }
        if (selectedFilterCategory.value == 'Plan Status' &&
            company.subscriptionStatus != activeTab.value) {
          return false;
        }
      }
      if (searchQuery.value.isNotEmpty) {
        String query = searchQuery.value.toLowerCase();
        if (searchFilterField.value == 'Company Name') {
          return company.name.toLowerCase().contains(query);
        }
        if (searchFilterField.value == 'Owner Name') {
          return company.ownerName.toLowerCase().contains(query);
        }
        if (searchFilterField.value == 'Email') {
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

  var selectedCompany = Rxn<CompanyModel>();

  void selectCompany(CompanyModel company) {
    selectedCompany.value = company;
  }

  void selectCompanyDate({
    required BuildContext context,
    required TextEditingController targetController,
  }) {
    DateTime initialDate = DateTime.now();
    if (targetController.text.isNotEmpty) {
      try {
        initialDate = DateFormat('dd/MM/yyyy').parse(targetController.text);
      } catch (_) {
        initialDate = DateTime.now();
      }
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: CustomDatePickerCompanyDialog(
            initialDate: initialDate,
            isWeekMode: false,
            onCancel: () {
              Navigator.of(dialogContext).pop();
            },
            onDateSelected: (selectedDate, _) {
              targetController.text =
                  DateFormat('dd/MM/yyyy').format(selectedDate);
              Navigator.of(dialogContext).pop();
            },
          ),
        );
      },
    );
  }
}