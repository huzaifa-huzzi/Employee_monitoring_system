import 'package:employee_monitoring_system/Panel/Admin/Companies/CompaniesController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/ImageString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AddCompanyUI extends StatelessWidget {
  const AddCompanyUI({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CompaniesController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    context.go('/Admin/companies');
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.borderColor.withValues(alpha: 0.5),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 18,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Company",
                        style: TTextTheme.h3Style(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "You can see all companies here",
                        style: TTextTheme.titleFour(context).copyWith(
                          color: AppColors.tertiaryTextColor,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              context: context,
              title: "General Information",
              subtitle: "Enter basic detail here",
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  int crossAxisCount = width > 900 ? 3 : (width > 600 ? 2 : 1);
                  double cardWidth = _getCardWidth(width, crossAxisCount);

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      _buildInfoContainer(
                        context: context,
                        width: cardWidth,
                        label: "Company Logo",
                        child: Obx(() {
                          final bool hasUploadedImage =
                              controller.selectedFileName.value != null &&
                                  controller.selectedFileName.value!.isNotEmpty;

                          if (hasUploadedImage) {
                            return InkWell(
                              onTap: controller.pickLogo,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: 48,
                                alignment: Alignment.centerLeft,
                                child: controller.selectedImageBytes.value != null
                                    ? Image.memory(
                                  controller.selectedImageBytes.value!,
                                  height: 42,
                                  fit: BoxFit.contain,
                                )
                                    : Image.asset(
                                  ImageString.companyLogo,
                                  height: 42,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return SvgPicture.asset(
                                      IconString.companyTable,
                                      height: 36,
                                    );
                                  },
                                ),
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: controller.pickLogo,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: 48,
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.borderColor.withValues(alpha: 0.6),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.image_outlined,
                                      color: AppColors.rejectedColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "Upload Image",
                                        style: TTextTheme.titleFour(context).copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.tertiaryTextColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                      _buildInputField(
                        context: context,
                        width: cardWidth,
                        label: "Company Name",
                        hint: "Enter company name",
                        controller: controller.nameController,
                      ),
                      _buildInfoContainer(
                        context: context,
                        width: cardWidth,
                        label: "Account Status",
                        child: _buildCustomPopupMenu(
                          context: context,
                          currentValue: controller.accountStatus,
                          isOpen: controller.isAccountStatusOpen,
                          options: ['Active', 'Pending', 'Inactive'],
                          onSelected: (val) => controller.accountStatus.value = val,
                          minWidthWeb: cardWidth,
                        ),
                      ),
                      _buildInputField(
                        context: context,
                        width: cardWidth,
                        label: "Phone Number",
                        hint: "Enter Phone Number",
                        controller: controller.phoneController,
                      ),
                      _buildInputField(
                        context: context,
                        width: cardWidth,
                        label: "Email Address",
                        hint: "Enter Email",
                        controller: controller.emailController,
                      ),

                      _buildInputField(
                        context: context,
                        width: cardWidth,
                        label: "Email Status",
                        hint: "Enter Email Status",
                        controller: controller.emailController,
                      ),

                      _buildInputField(
                        context: context,
                        width: cardWidth,
                        label: "Address",
                        hint: "Enter Address",
                        controller: controller.addressController,
                      ),
                      _buildInputField(
                        context: context,
                        width: cardWidth,
                        label: "Number of Employees",
                        hint: "Enter No of Employee",
                        controller: controller.noOfEmployee,
                      ),
                      _buildInputField(
                        context: context,
                        width: cardWidth,
                        label: "Joining Date",
                        hint: "Enter Joining Date",
                        controller: controller.joiningDate,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            _buildSectionCard(
              context: context,
              title: "Social Links",
              subtitle: "Basic detail about the social links",
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  int crossAxisCount = width > 900 ? 3 : (width > 600 ? 2 : 1);
                  double cardWidth = _getCardWidth(width, crossAxisCount);

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildSocialInputField(
                        context: context,
                        width: cardWidth,
                        label: "Face Book",
                        hint: "Add link",
                        svgPath: IconString.facebookIcon,
                        controller: controller.facebookController,
                      ),
                      _buildSocialInputField(
                        context: context,
                        width: cardWidth,
                        label: "Twitter",
                        hint: "Add link",
                        svgPath: IconString.xIcon,
                        controller: controller.twitterController,
                      ),
                      _buildSocialInputField(
                        context: context,
                        width: cardWidth,
                        label: "Instagram",
                        hint: "Add link",
                        svgPath: IconString.InstaIcon,
                        controller: controller.instagramController,
                      ),
                      _buildSocialInputField(
                        context: context,
                        width: cardWidth,
                        label: "LinkedIn",
                        hint: "Add link",
                        svgPath: IconString.linkedinIcon,
                        controller: controller.linkedinController,
                      ),
                      _buildSocialInputField(
                        context: context,
                        width: cardWidth,
                        label: "Youtube",
                        hint: "Add link",
                        svgPath: IconString.youtubeIcon,
                        controller: controller.youtubeController,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),


            _buildSectionCard(
              context: context,
              title: "Subscription Information",
              subtitle: "Enter company subscription here",
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  int crossAxisCount = width > 900 ? 3 : (width > 600 ? 2 : 1);
                  double cardWidth = _getCardWidth(width, crossAxisCount);

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildInfoContainer(
                        context: context,
                        width: cardWidth,
                        label: "Plan",
                        child: _buildCustomPopupMenu(
                          context: context,
                          currentValue: controller.plan,
                          isOpen: controller.isPlanOpen,
                          options: ['Monthly', 'Yearly'],
                          onSelected: (val) => controller.plan.value = val,
                          minWidthWeb: cardWidth,
                        ),
                      ),
                      _buildInfoContainer(
                        context: context,
                        width: cardWidth,
                        label: "Plan status",
                        child: _buildCustomPopupMenu(
                          context: context,
                          currentValue: controller.planStatus,
                          isOpen: controller.isPlanStatusOpen,
                          options: ['Subscribed', 'Demo', 'Overdue', 'Cancelled'],
                          onSelected: (val) => controller.planStatus.value = val,
                          minWidthWeb: cardWidth,
                        ),
                      ),
                      _buildInputField(
                        context: context,
                        width: cardWidth,
                        label: "Start date",
                        hint: "Select start date",
                        suffixSvgPath: IconString.calendarIcon,
                        controller: controller.startDateController,
                        readOnly: true,
                        onTap: () {
                          controller.selectCompanyDate(
                            context: context,
                            targetController: controller.startDateController,
                          );
                        },
                      ),
                      _buildInputField(
                        context: context,
                        width: cardWidth,
                        label: "End date",
                        hint: "4/03/2027",
                        suffixSvgPath: IconString.calendarIcon,
                        controller: controller.endDateController,
                        readOnly: true,
                        onTap: () {
                          controller.selectCompanyDate(
                            context: context,
                            targetController: controller.endDateController,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: controller.submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: TTextTheme.btnTextOne(context).copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   /// ----------- Extra Widget ----------- ////

   // Pop Menu Item
  Widget _buildCustomPopupMenu({
    required BuildContext context,
    required RxString currentValue,
    required RxBool isOpen,
    required List<String> options,
    required Function(String) onSelected,
    required double minWidthWeb,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return PopupMenuButton<String>(
      constraints: BoxConstraints(
        minWidth: isMobile ? screenWidth - 60 : minWidthWeb,
        maxWidth: isMobile ? screenWidth - 60 : minWidthWeb,
        maxHeight: 300,
      ),
      offset: const Offset(0, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppColors.whiteColor,
      elevation: 3,
      onOpened: () => isOpen.value = true,
      onCanceled: () => isOpen.value = false,
      onSelected: (String val) {
        currentValue.value = val;
        onSelected(val);
        isOpen.value = false;
      },
      child: Obx(() => Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.borderColor.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currentValue.value,
              style: TTextTheme.titleFour(context).copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
            Icon(
              isOpen.value
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: AppColors.tertiaryTextColor,
              size: 20,
            ),
          ],
        ),
      )),
      itemBuilder: (BuildContext context) {
        return options.map((String opt) {
          final bool isSelected = opt == currentValue.value;

          return PopupMenuItem<String>(
            value: opt,
            height: 38,
            child: Text(
              opt,
              style: TTextTheme.titleFour(context).copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w400,
                fontSize: 13.5,
              ),
            ),
          );
        }).toList();
      },
    );
  }

   // Section Card
  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TTextTheme.h3Style(context).copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TTextTheme.titleFour(context).copyWith(
              fontSize: 12,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

   // Input Field
  Widget _buildInputField({
    required BuildContext context,
    required double width,
    required String label,
    required String hint,
    required TextEditingController controller,
    IconData? suffixIcon,
    String? suffixSvgPath,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return _buildInfoContainer(
      context: context,
      width: width,
      label: label,
      child: SizedBox(
        height: 48,
        child: TextField(
          cursorColor: AppColors.textColor,
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          style: TTextTheme.titleFour(context).copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TTextTheme.titleFour(context).copyWith(
              fontSize: 14,
              color: AppColors.tertiaryTextColor,
            ),
            suffixIcon: suffixSvgPath != null
                ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                suffixSvgPath,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  AppColors.tertiaryTextColor,
                  BlendMode.srcIn,
                ),
              ),
            )
                : (suffixIcon != null
                ? Icon(suffixIcon, size: 18, color: AppColors.tertiaryTextColor)
                : null),
            filled: true,
            fillColor: AppColors.whiteColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.6)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.6)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialInputField({
    required BuildContext context,
    required double width,
    required String label,
    required String hint,
    required String svgPath,
    required TextEditingController controller,
  }) {
    return _buildInfoContainer(
      context: context,
      width: width,
      label: label,
      child: SizedBox(
        height: 48,
        child: TextField(
          cursorColor: AppColors.textColor,
          controller: controller,
          style: TTextTheme.titleFour(context).copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TTextTheme.titleFour(context).copyWith(
              fontSize: 14,
              color: AppColors.tertiaryTextColor,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SvgPicture.asset(
                svgPath,
                width: 18,
                height: 18,
              ),
            ),
            filled: true,
            fillColor: AppColors.whiteColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.6)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:  BorderSide(color: AppColors.borderColor.withValues(alpha: 0.6)),
            ),
          ),
        ),
      ),
    );
  }

   // Info Container
  Widget _buildInfoContainer({
    required BuildContext context,
    required double width,
    required String label,
    required Widget child,
  }) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TTextTheme.titleTwo(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  double _getCardWidth(double totalWidth, int crossAxisCount) {
    if (crossAxisCount == 1) return totalWidth;
    double spacing = 16.0 * (crossAxisCount - 1);
    return (totalWidth - spacing) / crossAxisCount;
  }
}

