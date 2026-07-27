import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Employee/EmployeeController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class EmployeeInvitationWidget extends StatelessWidget {
  const EmployeeInvitationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeController controller = Get.find<EmployeeController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => context.go('/vendor/employee'),
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                TextString.InviteEmployee,
                style: TTextTheme.titleOne(context).copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Text(
              TextString.InviteEmployeeSubtitle,
              style: TTextTheme.titleTwo(context).copyWith(
                color: AppColors.tertiaryTextColor,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// 2. MAIN FORM CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TextString.InviteEmployee,
                    style: TTextTheme.h3Style(context).copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      bool isMobile = constraints.maxWidth < 700;

                      return Column(
                        children: [
                          _buildResponsiveRow(
                            isMobile,
                            _buildTextField(
                              context,
                              label:TextString.employeeFirstName ,
                              hint:TextString.employeeFirstSubtitle ,
                              controller: controller.firstNameController,
                              validator: (v) => controller.validateRequired(
                                  v, TextString.employeeFirstSubtitle),
                            ),
                            _buildTextField(
                              context,
                              label:TextString.employeeLastName ,
                              hint:TextString.employeeFirstSubtitle ,
                              controller: controller.lastNameController,
                              validator: (v) => controller.validateRequired(
                                  v,TextString.employeeLastSubtitle ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildResponsiveRow(
                            isMobile,
                            _buildTextField(
                              context,
                              label:TextString.employeeEmail ,
                              hint:TextString.employeeEmailSubtitle ,
                              controller: controller.emailController,
                              validator: (v) => controller.validateEmail(v),
                            ),
                            _buildPhoneField(context, controller),
                          ),
                          const SizedBox(height: 16),
                          _buildResponsiveRow(
                            isMobile,
                            _buildTextField(
                              context,
                              label:TextString.employeeRoleTwo ,
                              hint:TextString.employeeRoleTwoSubtitle ,
                              controller: controller.roleController,
                              validator: (v) =>
                                  controller.validateRequired(v, "Role"),
                            ),
                            _buildTextField(
                              context,
                              label:TextString.employeeDeptTwo ,
                              hint:TextString.employeeDeptTwoSubtitle ,
                              controller: controller.departmentController,
                              isOptional: true,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  /// SUBMIT BUTTON
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 150,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () => {
                          _showInvitationSuccessDialog(context),
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Sent Invitation",
                          style: TTextTheme.btnTextOne(context).copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

   /// --------------- Extra Widgets -------------- ///

  // Responsive Row
  Widget _buildResponsiveRow(bool isMobile, Widget field1, Widget field2) {
    if (isMobile) {
      return Column(
        children: [
          field1,
          const SizedBox(height: 16),
          field2,
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: field1),
        const SizedBox(width: 20),
        Expanded(child: field2),
      ],
    );
  }

  // TextField component
  Widget _buildTextField(
      BuildContext context, {
        required String label,
        required String hint,
        required TextEditingController controller,
        String? Function(String?)? validator,
        bool isOptional = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label.replaceAll('*', ''),
            style: TTextTheme.titleFive(context).copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
            children: [
              if (label.contains('*'))
                const TextSpan(
                  text: '*',
                  style: TextStyle(color: AppColors.rejectedColor),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          cursorColor: AppColors.textColor,
          controller: controller,
          validator: validator,
          style: TTextTheme.FieldWriteTheText(context).copyWith(
            fontSize: 14,
            color: AppColors.textColor,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TTextTheme.InsideAlreadyWrittenText(context).copyWith(
              fontSize: 13,
              color: AppColors.textGrey,
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:  BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.rejectedColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  color: AppColors.rejectedColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  // Phone Field
  Widget _buildPhoneField(
      BuildContext context, EmployeeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: TextString.employeePhone,
            style: TTextTheme.titleFive(context).copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
            children:  [
              TextSpan(
                text: "(Optional)",
                style: TTextTheme.loginTexts(context),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Obx(() {
          if (controller.isLoadingCountries.value) {
            return SizedBox(
              height: 44,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor),
                ),
              ),
            );
          }

          final List<Country> countryList = controller.countryList;

          return TextFormField(
            controller: controller.phoneController,
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
                              (c) => c.name == controller.selectedCountryName.value,
                          orElse: () => countryList.firstWhere(
                                (c) =>
                            c.countryCode.toUpperCase() == 'AU' ||
                                c.name == "Australia",
                            orElse: () => countryList.first,
                          ),
                        ),
                        selectedItemBuilder: (context) {
                          return countryList.map((Country country) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 4),
                                _buildCircleFlag(
                                    controller, country.countryCode),
                                const SizedBox(width: 6),
                                Text(
                                  "+${country.phoneCode}",
                                  style:  TextStyle(
                                    fontSize: 12,
                                    color:AppColors.tertiaryTextColor ,
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
                                _buildCircleFlag(
                                    controller, country.countryCode),
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
                                  style: TTextTheme.countryCodeText(context)
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (Country? value) {
                          if (value != null) {
                            controller.selectedCountryName.value = value.name;
                            controller.selectedCode.value =
                            "+${value.phoneCode}";
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
                          searchController: controller.searchController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: _buildSearchField(
                              context, controller.searchController),
                          searchMatchFn: (item, searchValue) {
                            return item.value!.name
                                .toLowerCase()
                                .contains(searchValue.toLowerCase()) ||
                                item.value!.phoneCode.contains(searchValue);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                const BorderSide(color: AppColors.primaryColor, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.rejectedColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                    color: AppColors.rejectedColor, width: 1.5),
              ),
            ),
          );
        }),
      ],
    );
  }

  // Circular Flag
  Widget _buildCircleFlag(EmployeeController controller, String code) {
    final cleanCode = code.toLowerCase();

    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: Image.network(
          'https://hatscripts.github.io/circle-flags/flags/$cleanCode.svg',
          width: 20,
          height: 20,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.network(
              'https://flagcdn.com/w40/$cleanCode.png',
              width: 20,
              height: 20,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Text(
                controller.countryCodeToEmoji(code),
                style: const TextStyle(fontSize: 14),
              ),
            );
          },
        ),
      ),
    );
  }

  // Search Field
  Widget _buildSearchField(
      BuildContext context, TextEditingController searchCtrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
         cursorColor: AppColors.textColor,
        controller: searchCtrl,
        style: TTextTheme.FieldWriteTheText(context).copyWith(fontSize: 13),
        decoration: InputDecoration(
          isDense: true,
          hintText: TextString.searchCountry,
          hintStyle: TTextTheme.InsideAlreadyWrittenText(context)
              .copyWith(fontSize: 12),
          prefixIcon: const Icon(
            Icons.search,
            size: 16,
            color: AppColors.textColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:  BorderSide(color: AppColors.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

   /// Dialogs
  void _showInvitationSuccessDialog(BuildContext context) {
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
                        TextString.InvitationDialogOne,
                        style: TTextTheme.h3Style(context),
                      ),
                      SizedBox(height: 4),
                      Text(
                        TextString.InvitationDialogTwo,
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

