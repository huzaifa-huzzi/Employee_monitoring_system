import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Employee/EmployeeController.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Employee/ReusableWidget/CustomDatePickerEmployee.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/ImageString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class EditEmployeeWidget extends StatelessWidget {
  const EditEmployeeWidget({super.key});

  Map<String, dynamic> _getStatusConfig(EmployeeStatus status) {
    switch (status) {
      case EmployeeStatus.online:
        return {
          "text": "Active",
          "bgColor": AppColors.approvedColor,
          "textColor": AppColors.whiteColor,
          "dotColor": AppColors.approvedColor,
        };
      case EmployeeStatus.offline:
        return {
          "text": "Offline",
          "bgColor": AppColors.rejectedColor,
          "textColor": AppColors.whiteColor,
          "dotColor": AppColors.rejectedColor,
        };
      case EmployeeStatus.invited:
        return {
          "text": "Invited",
          "bgColor": AppColors.pendingColor,
          "textColor": AppColors.textColor,
          "dotColor": AppColors.pendingColor,
        };
    }
  }

   // Department List
  static const List<Map<String, String>> departmentList = [
    {"label": "Engineering / Development"},
    {"label": "UI/UX Design"},
    {"label": "Quality Assurance (QA)"},
    {"label": "Project Management (PMO)"},
    {"label": "Product Management"},
    {"label": "DevOps / Infrastructure"},
  ];

  // Role List
  static const List<String> roleList = [
    "Software Engineer",
    "Frontend Developer",
    "Backend Developer",
    "Full Stack Developer",
    "Mobile Developer (Android/iOS)",
    "DevOps Engineer",
    "Software Architect",
    "Technical Lead",
    "Engineering Manager",
    "UI Designer",
    "UX Designer",
    "Product Designer",
    "Graphic Designer",
    "Design Lead",
    "Quality Assurance (QA)",
    "QA Engineer",
    "Manual QA Engineer",
    "Automation QA Engineer",
    "QA Lead",
    "Test Analyst",
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmployeeController>();

    return Obx(() {
      final employee = controller.targetEditingEmployee.value;
      if (employee == null) {
        return const Center(child: Text("No Employee Selected"));
      }

      final statusConfig = _getStatusConfig(employee.status);

      return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          bool isDesktop = width >= 900;
          bool isTablet = width >= 600 && width < 900;

          return Container(
            color: AppColors.backgroundOfScreenColor,
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(width < 400 ? 12 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      context.go('/vendor/employee');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textColor),
                        const SizedBox(width: 8),
                        Text(TextString.editEmployeeTitle, style: TTextTheme.h1Style(context)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 26.0),
                    child: Text(
                      TextString.editEmployeeSubtitle,
                      style: TTextTheme.titleFour(context),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                    ),
                    child: LayoutBuilder(
                      builder: (context, headerConstraints) {
                        bool isMobile = headerConstraints.maxWidth < 500;

                        Widget avatarAndDetails = Row(
                          mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  backgroundColor: AppColors.crossBackground,
                                  backgroundImage: AssetImage(ImageString.user1),
                                ),
                                Positioned(
                                  right: 2,
                                  bottom: 2,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: statusConfig["dotColor"],
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.whiteColor, width: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    employee.name,
                                    style: TTextTheme.h3Style(context),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Employee  •  Since, ${employee.joiningDate}",
                                    style: TTextTheme.titleSix(context),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );

                        Widget statusBadge = Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                          decoration: BoxDecoration(
                            color: statusConfig["bgColor"],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            statusConfig["text"],
                            style: TTextTheme.titleRegular12White(context),
                          ),
                        );
                        if (!isMobile) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: avatarAndDetails),
                              const SizedBox(width: 16),
                              statusBadge,
                            ],
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            avatarAndDetails,
                            const SizedBox(height: 16),
                            statusBadge,
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Employee Info Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(width < 400 ? 16 : 24),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                    ),
                    child: Form(
                      key: controller.editEmployeeFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(TextString.employeeInfo, style: TTextTheme.h2Style(context)),
                          const SizedBox(height: 24),
                          LayoutBuilder(
                            builder: (context, innerConstraints) {
                              int columns = isDesktop ? 3 : (isTablet ? 2 : 1);

                              return Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                children: [
                                  _buildResponsiveField(
                                    context: context,
                                    width: innerConstraints.maxWidth,
                                    columns: columns,
                                    label: TextString.employeeFirstName,
                                    child: TextFormField(
                                      cursorColor: AppColors.textColor,
                                      controller: controller.editEmpFirstNameCtrl,
                                      style: TTextTheme.FieldWriteTheText(context),
                                      decoration: _inputDecoration(TextString.employeeFirstSubtitle),
                                      validator: (val) => controller.validateEditField(val, "First Name"),
                                    ),
                                  ),
                                  _buildResponsiveField(
                                    context: context,
                                    width: innerConstraints.maxWidth,
                                    columns: columns,
                                    label: TextString.employeeLastName,
                                    child: TextFormField(
                                      cursorColor: AppColors.textColor,
                                      controller: controller.editEmpLastNameCtrl,
                                      style: TTextTheme.FieldWriteTheText(context),
                                      decoration: _inputDecoration(TextString.employeeFirstSubtitle),
                                      validator: (val) => controller.validateEditField(val, "Last Name"),
                                    ),
                                  ),
                                  _buildResponsiveField(
                                    context: context,
                                    width: innerConstraints.maxWidth,
                                    columns: columns,
                                    label: TextString.employeeEmail,
                                    child: TextFormField(
                                      cursorColor: AppColors.textColor,
                                      controller: controller.editEmpEmailCtrl,
                                      style: TTextTheme.FieldWriteTheText(context),
                                      decoration: _inputDecoration(TextString.employeeEmailSubtitle),
                                      validator: (val) => controller.validateEmail(val),
                                    ),
                                  ),
                                  _buildResponsiveField(
                                    context: context,
                                    width: innerConstraints.maxWidth,
                                    columns: columns,
                                    label: TextString.employeePhone,
                                    child: _buildPhoneField(context, controller),
                                  ),
                                  _buildResponsiveField(
                                    context: context,
                                    width: innerConstraints.maxWidth,
                                    columns: columns,
                                    label: TextString.employeeRole,
                                    child: _buildRolePopupMenu(context, controller),
                                  ),
                                  _buildResponsiveField(
                                    context: context,
                                    width: innerConstraints.maxWidth,
                                    columns: columns,
                                    label: TextString.employeeDetailDept,
                                    child: _buildDepartmentPopupMenu(context, controller),
                                  ),
                                  _buildResponsiveField(
                                    context: context,
                                    width: innerConstraints.maxWidth,
                                    columns: columns,
                                    label: TextString.employeeJoining,
                                    child: _buildJoiningDatePickerField(context, controller),
                                  ),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: LayoutBuilder(
                              builder: (context, btnConstraints) {
                                bool isSmallScreen = btnConstraints.maxWidth < 360;

                                return Wrap(
                                  alignment: isSmallScreen ? WrapAlignment.center : WrapAlignment.end,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    SizedBox(
                                      width: isSmallScreen ? double.infinity : null,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          _showEditEmployeeDialog(context, controller, employee);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryColor,
                                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: Text("Save Changes", style: TTextTheme.TabsSelectedText(context)),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

   /// --------------- Extra Widget -------------- ///

  // Joining Date Picker
  Widget _buildJoiningDatePickerField(BuildContext context, EmployeeController controller) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (dialogContext) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: CustomDatePickerEmployee(
                initialDate: DateTime.now(),
                onCancel: () {
                  Navigator.of(dialogContext).pop();
                },
                onDateSelected: (selectedDate) {
                  controller.editEmpJoiningDate.value =
                  "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year.toString().substring(2)}";
                  Navigator.of(dialogContext).pop();
                },
              ),
            );
          },
        );
      },
      child: InputDecorator(
        decoration: _inputDecoration(TextString.selectDate).copyWith(
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              IconString.calendarIcon,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                AppColors.tertiaryTextColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        child: Obx(
              () => Text(
            controller.editEmpJoiningDate.value.isEmpty
                ? TextString.selectDate
                : controller.editEmpJoiningDate.value,
            style: controller.editEmpJoiningDate.value.isEmpty
                ? TTextTheme.selectProjectText(context)
                : TTextTheme.FieldWriteTheText(context),
          ),
        ),
      ),
    );
  }

  // Department Dropdown
  Widget _buildDepartmentPopupMenu(BuildContext context, EmployeeController controller) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: PopupMenuButton<String>(
          tooltip: '',
          elevation: 8,
          offset: const Offset(0, 52),
          constraints: const BoxConstraints(maxHeight: 280),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: AppColors.whiteColor,
          onSelected: (String value) {
            controller.editEmpSelectedDept.value = value;
          },
          itemBuilder: (BuildContext context) => departmentList.map((item) {
            return PopupMenuItem<String>(
              value: item["label"]!,
              child: Row(
                children: [
                  Text(
                    item["label"]!,
                    style: TTextTheme.FieldWriteTheText(context).copyWith(fontSize: 13),
                  ),
                ],
              ),
            );
          }).toList(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                      () {
                    final selectedLabel = controller.editEmpSelectedDept.value;
                    final found = departmentList.firstWhere(
                          (d) => d["label"] == selectedLabel,
                      orElse: () => {},
                    );

                    if (selectedLabel.isEmpty || found.isEmpty) {
                      return Text(TextString.selectDepartment, style: TTextTheme.selectProjectText(context));
                    }

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          found["label"]!,
                          style: TTextTheme.FieldWriteTheText(context),
                        ),
                      ],
                    );
                  },
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: AppColors.tertiaryTextColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Role Dropdown
  Widget _buildRolePopupMenu(BuildContext context, EmployeeController controller) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: PopupMenuButton<String>(
          tooltip: '',
          elevation: 8,
          offset: const Offset(0, 52),
          constraints: const BoxConstraints(maxHeight: 300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: AppColors.whiteColor,
          onSelected: (String value) {
            controller.editEmpSelectedRole.value = value;
          },
          itemBuilder: (BuildContext context) => roleList.map((role) {
            return PopupMenuItem<String>(
              value: role,
              child: Text(
                role,
                style: TTextTheme.FieldWriteTheText(context).copyWith(fontSize: 13),
              ),
            );
          }).toList(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                      () => Text(
                    controller.editEmpSelectedRole.value.isEmpty
                        ? TextString.selectRole
                        : controller.editEmpSelectedRole.value,
                    style: controller.editEmpSelectedRole.value.isEmpty
                        ? TTextTheme.selectProjectText(context)
                        : TTextTheme.FieldWriteTheText(context),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: AppColors.tertiaryTextColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Phone Field
  Widget _buildPhoneField(BuildContext context, EmployeeController controller) {
    return Obx(() {
      if (controller.isLoadingCountries.value) {
        return const SizedBox(
          height: 44,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
          ),
        );
      }

      final List<Country> countryList = controller.countryList;

      return TextFormField(
        controller: controller.editEmpPhoneCtrl,
        keyboardType: TextInputType.phone,
        style: TTextTheme.FieldWriteTheText(context).copyWith(
          fontSize: 14,
          color: AppColors.textColor,
        ),
        cursorColor: AppColors.textColor,
        decoration: InputDecoration(
          hintText: "",
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2<Country>(
                    isExpanded: false,
                    value: countryList.firstWhere(
                          (c) => c.name == controller.editSelectedCountryName.value,
                      orElse: () => countryList.firstWhere(
                            (c) => c.countryCode.toUpperCase() == 'AU' || c.name == "Australia",
                        orElse: () => countryList.first,
                      ),
                    ),
                    selectedItemBuilder: (context) {
                      return countryList.map((Country country) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 4),
                            _buildCircleFlag(controller, country.countryCode),
                            const SizedBox(width: 6),
                            Text(
                              "+${country.phoneCode}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.tertiaryTextColor,
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    },
                    items: countryList.map((Country country) {
                      return DropdownMenuItem<Country>(
                        value: country,
                        child: Row(
                          children: [
                            _buildCircleFlag(controller, country.countryCode),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                country.name,
                                style: const TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "+${country.phoneCode}",
                              style: TTextTheme.countryCodeText(context),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (Country? value) {
                      if (value != null) {
                        controller.editSelectedCountryName.value = value.name;
                        controller.editSelectedCode.value = "+${value.phoneCode}";
                      }
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 2),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: AppColors.tertiaryTextColor,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 280,
                      width: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.whiteColor,
                      ),
                      offset: const Offset(0, -5),
                    ),
                    dropdownSearchData: DropdownSearchData(
                      searchController: controller.editPhoneSearchController,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: _buildSearchField(context, controller.editPhoneSearchController),
                      searchMatchFn: (item, searchValue) {
                        return item.value!.name.toLowerCase().contains(searchValue.toLowerCase()) ||
                            item.value!.phoneCode.contains(searchValue);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.rejectedColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.rejectedColor, width: 1.5),
          ),
        ),
      );
    });
  }

   // Circle Flag
  Widget _buildCircleFlag(EmployeeController controller, String countryCode) {
    return Text(
      controller.countryCodeToEmoji(countryCode),
      style: const TextStyle(fontSize: 16),
    );
  }

   // Search Field
  Widget _buildSearchField(BuildContext context, TextEditingController searchCtrl) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        cursorColor: AppColors.textColor,
        controller: searchCtrl,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          isDense: true,
          hintText: TextString.searchCountry,
          hintStyle: const TextStyle(fontSize: 12),
          prefixIcon: const Icon(Icons.search, size: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

   // Responsive Fields
  Widget _buildResponsiveField({
    required BuildContext context,
    required double width,
    required int columns,
    required String label,
    required Widget child,
  }) {
    double itemWidth = columns == 1 ? width : (width - ((columns - 1) * 16)) / columns;
    return SizedBox(
      width: itemWidth < 220 ? width : itemWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.textFieldAboveText(context)),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      filled: true,
      fillColor: AppColors.whiteColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),
    );
  }

  /// Dialogs
  void _showEditEmployeeDialog(
      BuildContext context,
      EmployeeController controller,
      dynamic employee,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Container(
            width: 440,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Text("🤨", style: TextStyle(fontSize: 22)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextString.editEmployeeTitleOne,
                            style: TTextTheme.h3Style(context),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            TextString.editEmployeeTitleTwo,
                            style: TTextTheme.selectProjectText(context),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.crossBackground,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 14,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: TTextTheme.CancelBtn(context),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showEditSuccessDialog(context);
                        },
                        child: Text(
                          "Save",
                          style: TTextTheme.btnTextOne(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _showEditSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Container(
            width: 440,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.emojiBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Text("👍", style: TextStyle(fontSize: 22)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextString.editEmployeeTitleThree,
                        style: TTextTheme.h3Style(context),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        TextString.editEmployeeTitleFour,
                        style: TTextTheme.selectProjectText(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.borderColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

