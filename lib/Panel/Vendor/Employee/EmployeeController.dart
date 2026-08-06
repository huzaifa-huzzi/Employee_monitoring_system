import 'package:country_picker/country_picker.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EmployeeStatus { online, offline, invited }

class Country {
  final String name;
  final String phoneCode;
  final String countryCode;

  Country({
    required this.name,
    required this.phoneCode,
    required this.countryCode,
  });
}

class EmployeeModel {
   String name;
   String email;
   String role;
   String department;
   String joiningDate;
  final EmployeeStatus status;
  bool isSelected;

  EmployeeModel({
    required this.name,
    required this.email,
    required this.role,
    required this.department,
    required this.joiningDate,
    required this.status,
    this.isSelected = false,
  });
}

class EmployeeController extends GetxController {
  /// Main Screen
  var selectedTabIndex = 0.obs;
  var searchQuery = ''.obs;
  var selectedDepartmentFilter = 'Employee Name'.obs;
  final RxInt resultsPerPage = 8.obs;

  var allEmployees = <EmployeeModel>[
    EmployeeModel(name: "Jack Milson", email: "jack@gmail.com", role: "Ui Ux designer", department: "Design", joiningDate: "08/08/26", status: EmployeeStatus.online),
    EmployeeModel(name: "Talha bukhari", email: "talha@gmail.com", role: "Front end Dev", department: "Development", joiningDate: "08/08/26", status: EmployeeStatus.online),
    EmployeeModel(name: "Hussain Ali", email: "hussain@gmail.com", role: "Ui Ux designer", department: "Design", joiningDate: "08/08/26", status: EmployeeStatus.invited),
    EmployeeModel(name: "Ayan Ali", email: "ayan@gmail.com", role: "Back End dev", department: "Development", joiningDate: "08/08/26", status: EmployeeStatus.online),
    EmployeeModel(name: "Jhon Doe", email: "Jhon@gmail.com", role: "QA", department: "Development", joiningDate: "08/08/26", status: EmployeeStatus.invited),
    EmployeeModel(name: "Jhon Doe", email: "Jhon@gmail.com", role: "P.Manager", department: "Management", joiningDate: "08/08/26", status: EmployeeStatus.offline),
  ].obs;

  int get totalCount => allEmployees.length;
  int get onlineCount => allEmployees.where((e) => e.status == EmployeeStatus.online).length;
  int get offlineCount => allEmployees.where((e) => e.status == EmployeeStatus.offline).length;

  List<EmployeeModel> get filteredEmployees {
    return allEmployees.where((emp) {
      bool matchesTab = true;
      if (selectedTabIndex.value == 1) matchesTab = emp.status == EmployeeStatus.online;
      if (selectedTabIndex.value == 2) matchesTab = emp.status == EmployeeStatus.offline;
      if (selectedTabIndex.value == 3) matchesTab = emp.status == EmployeeStatus.invited;
      bool matchesSearch = emp.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          emp.department.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          emp.role.toLowerCase().contains(searchQuery.value.toLowerCase());

      return matchesTab && matchesSearch;
    }).toList();
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void toggleSelectAll(bool? val) {
    for (var emp in filteredEmployees) {
      emp.isSelected = val ?? false;
    }
    allEmployees.refresh();
  }

   /// Employee Invitation
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final roleController = TextEditingController();
  final departmentController = TextEditingController();
  final searchController = TextEditingController();
  var selectedCountryName = ''.obs;
  var selectedCode = ''.obs;
  var countryList = <Country>[].obs;
  var isLoadingCountries = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllWorldCountries();
  }
  void loadAllWorldCountries() {
    isLoadingCountries.value = true;

    try {
      List<dynamic> allCountries = CountryService().getAll();

      countryList.value = allCountries.map((c) {
        return Country(
          name: c.name,
          phoneCode: c.phoneCode,
          countryCode: c.countryCode,
        );
      }).toList();
      if (countryList.isNotEmpty) {
        Country defaultCountry = countryList.firstWhere(
              (c) => c.countryCode.toUpperCase() == 'AU' || c.name.toLowerCase() == 'australia',
          orElse: () => countryList.first,
        );
        selectedCountryName.value = defaultCountry.name;
        selectedCode.value = "+${defaultCountry.phoneCode}";
      }
    } catch (e) {
      debugPrint("Error fetching countries: $e");
    } finally {
      isLoadingCountries.value = false;
    }
  }
  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    if (!GetUtils.isEmail(value.trim())) {
      return "Enter a valid email address";
    }
    return null;
  }
  void sendInvitation() {
    if (formKey.currentState!.validate()) {
      final newEmp = EmployeeModel(
        name: "${firstNameController.text.trim()} ${lastNameController.text.trim()}",
        email: emailController.text.trim(),
        role: roleController.text.trim(),
        department: departmentController.text.trim().isEmpty ? "N/A" : departmentController.text.trim(),
        joiningDate: "08/08/26",
        status: EmployeeStatus.invited,
      );

      allEmployees.add(newEmp);
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      phoneController.clear();
      roleController.clear();
      departmentController.clear();

      Get.snackbar(
        "Success",
        "Invitation sent successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.approvedColor,
        colorText: AppColors.whiteColor,
      );
    }
  }

  String countryCodeToEmoji(String countryCode) {
    if (countryCode.length < 2) return '🌐';

    final String cleanCode = countryCode.substring(0, 2).toUpperCase();
    int firstLetter = cleanCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    int secondLetter = cleanCode.codeUnitAt(1) - 0x41 + 0x1F1E6;

    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }


  /// Edit Employee

  final editEmployeeFormKey = GlobalKey<FormState>();

  final editEmpFirstNameCtrl = TextEditingController();
  final editEmpLastNameCtrl = TextEditingController();
  final editEmpEmailCtrl = TextEditingController();
  final editEmpPhoneCtrl = TextEditingController();
  final editPhoneSearchController = TextEditingController();

  var editEmpSelectedRole = ''.obs;
  var editEmpSelectedDept = ''.obs;
  var editEmpJoiningDate = ''.obs;
  var editSelectedCountryName = ''.obs;
  var editSelectedCode = ''.obs;

  var targetEditingEmployee = Rxn<EmployeeModel>();

  void prepareEmployeeForEditing(EmployeeModel employee) {
    targetEditingEmployee.value = employee;
    List<String> nameParts = employee.name.trim().split(" ");
    editEmpFirstNameCtrl.text = nameParts.isNotEmpty ? nameParts.first : "";
    editEmpLastNameCtrl.text = nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";

    editEmpEmailCtrl.text = employee.email;
    editEmpSelectedRole.value = employee.role;
    editEmpSelectedDept.value = employee.department;
    editEmpJoiningDate.value = employee.joiningDate;
    if (countryList.isNotEmpty && editSelectedCountryName.value.isEmpty) {
      Country defaultCountry = countryList.firstWhere(
            (c) => c.countryCode.toUpperCase() == 'AU' || c.name.toLowerCase() == 'australia',
        orElse: () => countryList.first,
      );
      editSelectedCountryName.value = defaultCountry.name;
      editSelectedCode.value = "+${defaultCountry.phoneCode}";
    }
  }
  void saveUpdatedEmployeeData() {
    if (editEmployeeFormKey.currentState!.validate() && targetEditingEmployee.value != null) {
      EmployeeModel emp = targetEditingEmployee.value!;

      emp.name = "${editEmpFirstNameCtrl.text.trim()} ${editEmpLastNameCtrl.text.trim()}".trim();
      emp.email = editEmpEmailCtrl.text.trim();
      emp.role = editEmpSelectedRole.value;
      emp.department = editEmpSelectedDept.value;
      emp.joiningDate = editEmpJoiningDate.value;

      allEmployees.refresh();
      Get.back();

      Get.snackbar(
        "Updated",
        "Employee details updated successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.approvedColor,
        colorText: AppColors.whiteColor,
      );
    }
  }

  String? validateEditField(String? value, String fieldLabel) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldLabel field is required";
    }
    return null;
  }

  // On close function
  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    roleController.dispose();
    departmentController.dispose();
    searchController.dispose();
    editEmpFirstNameCtrl.dispose();
    editEmpLastNameCtrl.dispose();
    editEmpEmailCtrl.dispose();
    editEmpPhoneCtrl.dispose();
    editPhoneSearchController.dispose();
    super.onClose();
  }
}