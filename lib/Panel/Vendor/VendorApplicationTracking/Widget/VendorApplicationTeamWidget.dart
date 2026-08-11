import 'package:employee_monitoring_system/Panel/Vendor/VendorApplicationTracking/ReusableWidget/PrimaryBtnofVendorApplication.dart';
import 'package:employee_monitoring_system/Panel/Vendor/VendorApplicationTracking/VendorApplicationTrackingController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class VendorApplicationTeamWidget extends StatelessWidget {
  const VendorApplicationTeamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VendorApplicationTrackingController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.crossBackground),
      ),
      child: Obx(() {
        if (controller.isTeamEmployeeView.value) {
          return _buildTeamEmployeesTable(context, controller);
        }
        return _buildTeamTable(context, controller);
      }),
    );
  }

    /// ------------ Extra Widget ------------///

   // Team Table
  Widget _buildTeamTable(BuildContext context, VendorApplicationTrackingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TextString.vendorApplicationTeamActivityTitle,
          style: TTextTheme.titleThree(context).copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          TextString.vendorApplicationTeamActivitySubtitle,
          style: TTextTheme.titleTwo(context).copyWith(
            color: AppColors.subtextColor,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            double calculatedWidth = constraints.maxWidth;
            double minTableWidth = calculatedWidth > 800 ? calculatedWidth : 800;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: minTableWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundOfScreenColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Obx(
                                () => SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: controller.isAllTeamSelected.value,
                                onChanged: (val) => controller.toggleAllTeamSelection(val),
                                activeColor: AppColors.primaryColor,
                                side: const BorderSide(
                                  color: AppColors.borderColor,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              )
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(flex: 3, child: Text(TextString.vendorApplicationTeamName, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                          Expanded(flex: 2, child: Text(TextString.vendorApplicationTeamMembers, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                          Expanded(flex: 3, child: Text(TextString.vendorApplicationEmployeeTableOne, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                          Expanded(flex: 2, child: Text(TextString.vendorApplicationEmployeeTableTwo, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                          Expanded(flex: 2, child: Text(TextString.vendorApplicationEmployeeTableThree, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                          Expanded(flex: 2, child: Text(TextString.vendorApplicationEmployeeTableFour, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                          Expanded(flex: 2, child: Text(TextString.vendorApplicationEmployeeTableFive, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                          () => Column(
                        children: List.generate(
                          controller.teamsList.length,
                              (index) {
                            final team = controller.teamsList[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  border: Border.all(color: AppColors.crossBackground),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Obx(
                                          () => SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Checkbox(
                                          value: team.isSelected.value,
                                          onChanged: (val) => controller.toggleTeamSelection(index, val),
                                          activeColor: AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                          side: const BorderSide(
                                            color: AppColors.borderColor,
                                            width: 1.5,
                                          ),

                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        team.name,
                                        style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 13),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${team.membersCount}',
                                        style: TTextTheme.titleTwo(context).copyWith(fontSize: 12),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        team.topApp,
                                        style: TTextTheme.titleTwo(context).copyWith(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        team.usageTime,
                                        style: TTextTheme.titleTwo(context).copyWith(fontSize: 12),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        team.usage,
                                        style: TTextTheme.titleTwo(context).copyWith(fontSize: 12),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${team.appUsed}',
                                        style: TTextTheme.titleTwo(context).copyWith(fontSize: 12),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: PrimaryBtnOfVendorApplication(
                                        text: 'View Emp',
                                        height: 40,
                                        borderRadius: BorderRadius.circular(6),
                                        onTap: () => controller.openTeamEmployeesView(team),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 16),
        _buildPaginationControls(context, controller),
      ],
    );
  }

   // Team Employee Table
  Widget _buildTeamEmployeesTable(BuildContext context, VendorApplicationTrackingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;

            Widget titleWidget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextString.vendorApplicationTeamEmployeeActivity,
                  style: TTextTheme.titleThree(context).copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  TextString.vendorApplicationTeamEmployeeActivitySubtitle,
                  style: TTextTheme.titleTwo(context).copyWith(
                    color: AppColors.subtextColor,
                    fontSize: 12,
                  ),
                ),
              ],
            );

            Widget searchWidget = SizedBox(
              width: isMobile ? double.infinity : 240,
              height: 38,
              child: TextField(
                cursorColor: AppColors.textColor,
                onChanged: (val) => controller.searchTeamEmployeeQuery.value = val,
                style: TTextTheme.titleTwo(context).copyWith(fontSize: 12),
                decoration: InputDecoration(
                  hintText: TextString.vendorApplicationEmployeeSearchField,
                  hintStyle: TTextTheme.titleTwo(context).copyWith(
                    color: AppColors.subtextColor,
                    fontSize: 12,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 18,
                    color: AppColors.textColor,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColors.crossBackground),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColors.crossBackground),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                  ),
                ),
              ),
            );

            if (isMobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleWidget,
                  const SizedBox(height: 12),
                  searchWidget,
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: titleWidget),
                searchWidget,
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            double calculatedWidth = constraints.maxWidth;
            double minTableWidth = calculatedWidth > 800 ? calculatedWidth : 800;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: minTableWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundOfScreenColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Obx(
                                () => SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: controller.isAllTeamSelected.value,
                                onChanged: (val) => controller.toggleAllTeamSelection(val),
                                activeColor: AppColors.primaryColor,
                                side: const BorderSide(
                                  color: AppColors.borderColor,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              )
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(flex: 3, child: Text(TextString.vendorApplicationTabOne, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                          Expanded(flex: 3, child: Text(TextString.vendorApplicationEmployeeTableOne, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                          Expanded(flex: 2, child: Text(TextString.vendorApplicationEmployeeTableTwo, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                          Expanded(flex: 2, child: Text(TextString.vendorApplicationEmployeeTableThree, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                          Expanded(flex: 2, child: Text(TextString.vendorApplicationEmployeeTableFour, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                          Expanded(flex: 1, child: Text(TextString.vendorApplicationEmployeeTableFive, style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                          () => Column(
                        children: List.generate(
                          controller.teamEmployeesList.length,
                              (index) {
                            final emp = controller.teamEmployeesList[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  border: Border.all(color: AppColors.crossBackground),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Obx(
                                          () => SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Checkbox(
                                          value: emp.isSelected.value,
                                          onChanged: (val) => controller.toggleTeamEmpSelection(index, val),
                                          activeColor: AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),),
                                          side: const BorderSide(
                                            color: AppColors.borderColor,
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            IconString.employeePerson,
                                            width: 16,
                                            height: 16,
                                            colorFilter: const ColorFilter.mode(
                                              AppColors.primaryColor,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  emp.name,
                                                  style: TTextTheme.titleTwo(context).copyWith(fontWeight: FontWeight.w600, fontSize: 13),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  emp.email,
                                                  style: TTextTheme.titleTwo(context).copyWith(color: AppColors.subtextColor, fontSize: 11),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        emp.topApp,
                                        style: TTextTheme.titleTwo(context).copyWith(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        emp.usageTime,
                                        style: TTextTheme.titleTwo(context).copyWith(fontSize: 12),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        emp.usage,
                                        style: TTextTheme.titleTwo(context).copyWith(fontSize: 12),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${emp.appUsed}',
                                        style: TTextTheme.titleTwo(context).copyWith(fontSize: 12),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: const Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 18,
                                          color: AppColors.tertiaryTextColor,
                                        ),
                                        onPressed: () => controller.openEmployeeDetailFromTeam(emp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 16),
        _buildPaginationControls(context, controller),
      ],
    );
  }

   // Pagination Controls
  Widget _buildPaginationControls(BuildContext context, VendorApplicationTrackingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => controller.previousPage(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.crossBackground),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: AppColors.textColor),
          ),
        ),
        Obx(
              () => Text(
            'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
            style: TTextTheme.titleTwo(context).copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
        ),
        InkWell(
          onTap: () => controller.nextPage(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.crossBackground),
              borderRadius: BorderRadius.circular(8),
            ),
            child:  Icon(Icons.arrow_forward, size: 16, color: AppColors.textColor),
          ),
        ),
      ],
    );
  }
}