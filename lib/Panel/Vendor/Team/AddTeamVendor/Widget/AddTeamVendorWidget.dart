import 'package:employee_monitoring_system/Panel/Vendor/Team/ReusableWidget/PrimaryBtnOfTeam.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Team/TeamController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class AddTeamVendorWidget extends StatelessWidget {
  const AddTeamVendorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeamVendorController());
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: EdgeInsets.all(width < 400 ? 12 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => context.go('/vendor/Team'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textColor),
                const SizedBox(width: 8),
                Text(TextString.addVendorTeamTitle, style: TTextTheme.h1Style(context)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 26.0),
            child: Text(
              TextString.addVendorTeamSubtitle,
              style: TTextTheme.titleFour(context),
            ),
          ),

          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(width < 400 ? 16 : 24),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TextString.teamVendorDetail, style: TTextTheme.h2Style(context)),
                const SizedBox(height: 20),
                Text(TextString.teamNameDetail, style: TTextTheme.textFieldAboveText(context)),
                const SizedBox(height: 8),
                TextFormField(
                  cursorColor: AppColors.textColor,
                  controller: controller.addTeamNameCtrl,
                  style: TTextTheme.FieldWriteTheText(context),
                  decoration: InputDecoration(
                    hintText: TextString.teamtextFieldText,
                    hintStyle: TTextTheme.selectProjectText(context),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width < 400 ? 16 : 24),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        bool isMobile = constraints.maxWidth < 600;

                        Widget searchAndFilter = Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              width: isMobile ? double.infinity : 260,
                              height: 42,
                              child: TextField(
                                cursorColor: AppColors.textColor,
                                onChanged: (val) => controller.addSearchQuery.value = val,
                                style: TTextTheme.FieldWriteTheText(context),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.tertiaryTextColor),
                                  hintText: TextString.searchFieldText,
                                  hintStyle: TTextTheme.selectProjectText(context).copyWith(fontSize: 13),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  filled: true,
                                  fillColor: AppColors.whiteColor,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.6)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: AppColors.primaryColor),
                                  ),
                                ),
                              ),
                            ),
                            _buildFilterPopupMenu(context, controller),
                          ],
                        );

                        if (isMobile) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(TextString.vendorCreateTeam, style: TTextTheme.h2Style(context)),
                              const SizedBox(height: 16),
                              searchAndFilter,
                            ],
                          );
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(TextString.vendorCreateTeam, style: TTextTheme.h2Style(context)),
                            searchAndFilter,
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        const double minTableWidth = 750.0;
                        double tableWidth = constraints.maxWidth < minTableWidth
                            ? minTableWidth
                            : constraints.maxWidth;

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: tableWidth,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundOfScreenColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 32,
                                        height: 32,
                                        child: Obx(
                                              () => Checkbox(
                                            value: controller.isAddMemberAllSelected.value,
                                            onChanged: (val) => controller.toggleSelectAllAddMembers(val),
                                            activeColor: AppColors.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            side: BorderSide(
                                              color: AppColors.borderColor.withValues(alpha: 0.8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          TextString.employeeName,
                                          style: TTextTheme.textFieldAboveText(context),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          TextString.employeeRole,
                                          style: TTextTheme.textFieldAboveText(context),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          TextString.employeeDept,
                                          style: TTextTheme.textFieldAboveText(context),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          TextString.employeeJoining,
                                          style: TTextTheme.textFieldAboveText(context),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 90,
                                        child: Text(TextString.employeeAction),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 12),
                                Obx(() => Column(
                                  children: List.generate(
                                    controller.addTeamMembersList.length,
                                        (index) {
                                      final member = controller.addTeamMembersList[index];
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 12),
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 32,
                                              height: 32,
                                              child: Checkbox(
                                                value: member.isSelected,
                                                onChanged: (val) => controller.toggleAddMemberSelection(index, val),
                                                activeColor: AppColors.primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                side: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.8)),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              flex: 3,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SvgPicture.asset(
                                                    IconString.employeePerson,
                                                    width: 18,
                                                    height: 18,
                                                    colorFilter: const ColorFilter.mode(
                                                      AppColors.primaryColor,
                                                      BlendMode.srcIn,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          member.name,
                                                          style: TTextTheme.h2Style(context).copyWith(fontSize: 14),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Text(
                                                          member.email,
                                                          style: TTextTheme.titleSix(context).copyWith(fontSize: 12),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                member.role,
                                                style: TTextTheme.titleSix(context),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                member.department,
                                                style: TTextTheme.titleSix(context),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                member.joiningDate,
                                                style: TTextTheme.titleSix(context),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 90,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      controller.toggleAddMemberSelection(
                                                        index,
                                                        !member.isSelected,
                                                      );
                                                    },
                                                    child: member.isSelected
                                                        ? (IconString.teamAdded.isNotEmpty
                                                        ? SvgPicture.asset(
                                                      IconString.teamAdded,
                                                      width: 20,
                                                      height: 20,
                                                      colorFilter: const ColorFilter.mode(
                                                        AppColors.approvedColor,
                                                        BlendMode.srcIn,
                                                      ),
                                                    )
                                                        : const Icon(
                                                      Icons.person_add_disabled,
                                                      size: 20,
                                                      color: AppColors.approvedColor,
                                                    ))
                                                        : const Icon(
                                                      Icons.person_add_alt_1_outlined,
                                                      size: 20,
                                                      color: AppColors.primaryColor,
                                                    ),
                                                  ),
                                                  if (member.isSelected) ...[
                                                    const SizedBox(width: 16),
                                                    InkWell(
                                                      onTap: () {
                                                        controller.toggleAddMemberSelection(index, false);
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.all(2),
                                                        decoration: const BoxDecoration(
                                                          color: AppColors.rejectedColor,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: const Icon(
                                                          Icons.close,
                                                          size: 14,
                                                          color: AppColors.whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        bool isMobile = constraints.maxWidth < 550;
                        Widget resultsPerPageWidget = Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              TextString.resultsPerPage,
                              style: TTextTheme.titleSix(context).copyWith(fontSize: 12),
                            ),
                            const SizedBox(width: 8),
                            Obx(() {
                              final List<int> allowedValues = [8, 10, 20, 50];
                              final int currentValue = allowedValues.contains(controller.addItemsPerPage.value)
                                  ? controller.addItemsPerPage.value
                                  : allowedValues.first;

                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    value: currentValue,
                                    isDense: true,
                                    icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                                    items: allowedValues.map<DropdownMenuItem<int>>((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(
                                          "$value",
                                          style: TTextTheme.titleSix(context).copyWith(fontSize: 12),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        controller.addItemsPerPage.value = val;
                                      }
                                    },
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                        Widget paginationButtonsWidget = SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: controller.addPreviousPage,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundOfScreenColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.chevron_left, size: 16, color: AppColors.tertiaryTextColor),
                                      Text(TextString.Prev, style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              _buildPageNumber(context, controller, 1),
                              _buildPageNumber(context, controller, 2),
                              _buildPageNumber(context, controller, 3),
                              _buildPageNumber(context, controller, 4),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: controller.addNextPage,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundOfScreenColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(TextString.Next, style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
                                      const Icon(Icons.chevron_right, size: 16, color: AppColors.tertiaryTextColor),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        if (isMobile) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              resultsPerPageWidget,
                              const SizedBox(height: 16),
                              Center(child: paginationButtonsWidget),
                            ],
                          );
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            resultsPerPageWidget,
                            paginationButtonsWidget,
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
              Positioned(
                top: -22,
                left: 16,
                right: 16,
                child: Obx(() {
                  final selectedCount = controller.addTeamMembersList.where((m) => m.isSelected).length;
                  if (selectedCount == 0) return const SizedBox.shrink();

                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 420,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textColor.withValues(alpha: 0.10),
                            blurRadius: 16,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              "$selectedCount Employees Selected",
                              style: TTextTheme.h2Style(context).copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 24),
                          InkWell(
                            onTap: () => controller.toggleSelectAllAddMembers(true),
                            child: Text(
                              TextString.teamSelectAll,
                              style: TTextTheme.titleSix(context).copyWith(
                                fontSize: 12,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          InkWell(
                            onTap: () => controller.toggleSelectAllAddMembers(false),
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.close,
                                size: 16,
                                color: AppColors.textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 32),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryBtnOfTeam(
              text: "Save Team",
              width: width < 400 ? double.infinity : 140,
              onTap: () {
                _showSuccessTeamDialog(context);
                controller.createTeam();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// -------- Extra Widgets ----------///

   // Page Number
  Widget _buildPageNumber(BuildContext context, TeamVendorController controller, int page) {
    return Obx(() {
      bool isSelected = controller.addCurrentPage.value == page;
      return InkWell(
        onTap: () => controller.addCurrentPage.value = page,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : AppColors.backgroundOfScreenColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            "$page",
            style: TTextTheme.titleSix(context).copyWith(
              fontSize: 12,
              color: isSelected ? AppColors.whiteColor : AppColors.textColor,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFilterPopupMenu(
      BuildContext context,
      TeamVendorController controller,
      ) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: PopupMenuButton<String>(
          tooltip: '',
          elevation: 8,
          offset: const Offset(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: AppColors.whiteColor,
          onSelected: (String value) {
            controller.selectedFilter.value = value;
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            _buildPopupItem(context, TextString.employeeName),
            _buildPopupItem(context, TextString.employeeRole),
            _buildPopupItem(context, TextString.employeeDept),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                      () => Text(
                    controller.selectedFilter.value,
                    style: TTextTheme.titleTwo(context).copyWith(fontSize: 13),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: AppColors.textColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(BuildContext context, String text) {
    return PopupMenuItem<String>(
      value: text,
      child: Text(
        text,
        style: TTextTheme.titleSix(context).copyWith(fontSize: 13),
      ),
    );
  }

   /// Dialog
  void _showSuccessTeamDialog(BuildContext context) {
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
                        TextString.teamVendorTitleOne,
                        style: TTextTheme.h3Style(context),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        TextString.teamVendorTitleTwo,
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