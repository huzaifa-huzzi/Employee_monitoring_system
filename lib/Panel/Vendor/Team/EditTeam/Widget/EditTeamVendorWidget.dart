import 'package:employee_monitoring_system/Panel/Vendor/Team/TeamController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';



class EditTeamVendorWidget extends StatelessWidget {
  const EditTeamVendorWidget({super.key});

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
            onTap: () {
              context.go('/vendor/Team');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textColor),
                const SizedBox(width: 8),
                Text(TextString.editTeamVendorTitle, style: TTextTheme.h1Style(context)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 26.0),
            child: Text(
              TextString.editTeamVendorSubtitle,
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
                  controller: controller.editTeamNameCtrl,
                  style: TTextTheme.FieldWriteTheText(context),
                  decoration: InputDecoration(
                    hintText:TextString.teamtextFieldText ,
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
                            onChanged: (val) => controller.searchQuery.value = val,
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
                                  Obx(() => SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: Checkbox(
                                      value: controller.isMemberAllSelected.value,
                                      onChanged: controller.toggleSelectAllMembers,
                                      activeColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      side: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.8)),
                                    ),
                                  )),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    flex: 3,
                                    child: Text(TextString.employeeName, style: TTextTheme.textFieldAboveText(context)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(TextString.employeeRole, style: TTextTheme.textFieldAboveText(context)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(TextString.employeeDept, style: TTextTheme.textFieldAboveText(context)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(TextString.employeeJoining, style: TTextTheme.textFieldAboveText(context)),
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
                                controller.teamMembersList.length,
                                    (index) {
                                  final member = controller.teamMembersList[index];
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
                                            onChanged: (val) => controller.toggleMemberSelection(index, val),
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
                                              CircleAvatar(
                                                radius: 16,
                                                backgroundColor: AppColors.crossBackground,
                                                child: const Icon(
                                                  Icons.person_outline,
                                                  size: 18,
                                                  color: AppColors.primaryColor,
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
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: SvgPicture.asset(
                                                  IconString.teamAdded,
                                                  width: 20,
                                                  height: 20,
                                                  colorFilter: const ColorFilter.mode(
                                                    AppColors.approvedColor,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              InkWell(
                                                onTap: () => controller.removeMember(index),
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
              ],
            ),
          ),

          const SizedBox(height: 32),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: width < 400 ? double.infinity : 140,
              child: ElevatedButton(
                onPressed: () {
                  _showEditTemVendorDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(TextString.editTeamVendorTitle, style: TTextTheme.TabsSelectedText(context)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ------------ Extra Widget------------///

  // filter Pop Menu
  Widget _buildFilterPopupMenu(BuildContext context, TeamVendorController controller) {
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

  PopupMenuItem<String> _buildPopupItem(BuildContext context, String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 40,
      child: Text(
        value,
        style: TTextTheme.titleOne(context).copyWith(
          fontSize: 13,
          color: AppColors.tertiaryTextColor,
        ),
      ),
    );
  }

   /// Dialog
  void _showEditTemVendorDialog(
      BuildContext context,
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
                            TextString.editTeamVendorDialogOne,
                            style: TTextTheme.h3Style(context),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            TextString.editTeamVendorDialogTwo ,
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
                          _showEditSuccessTeamDialog(context);
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
  void _showEditSuccessTeamDialog(BuildContext context) {
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
                       TextString.editTeamVendorSuccessDialogOne,
                        style: TTextTheme.h3Style(context),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        TextString.editTeamVendorSuccessDialogTwo,
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
