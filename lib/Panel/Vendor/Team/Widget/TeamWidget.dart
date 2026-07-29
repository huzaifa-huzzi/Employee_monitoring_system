import 'package:employee_monitoring_system/Panel/Vendor/Team/ReusableWidget/PrimaryBtnOfTeam.dart';
import 'package:employee_monitoring_system/Panel/Vendor/Team/TeamController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TeamVendorWidget extends StatelessWidget {
  const TeamVendorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeamVendorController());
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: EdgeInsets.all(width < 400 ? 12 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextString.teamVendorTitle, style: TTextTheme.h1Style(context)),
                    const SizedBox(height: 4),
                    Text(
                      TextString.teamVendorSubtitle,
                      style: TTextTheme.titleFour(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              PrimaryBtnOfTeam(
                text: "Add Team",
                icon: const Icon(Icons.add, color: AppColors.whiteColor, size: 18),
                onTap: () {
                  context.go('/vendor/addTeam');
                },
              ),
            ],
          ),

          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(width < 400 ? 12 : 20),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TextString.teamVendorMembers, style: TTextTheme.h2Style(context)),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    const double minTableWidth = 650.0;
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
                                      value: controller.isAllSelected.value,
                                      onChanged: controller.toggleSelectAll,
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
                                    child: Text(TextString.teamVendorName, style: TTextTheme.textFieldAboveText(context)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(TextString.teamCreationDate, style: TTextTheme.textFieldAboveText(context)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(TextString.teamVendorMembers, style: TTextTheme.textFieldAboveText(context)),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(TextString.teamAction, style: TTextTheme.textFieldAboveText(context)),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),
                            Obx(() => Column(
                              children: List.generate(
                                controller.teamsList.length,
                                    (index) {
                                  final team = controller.teamsList[index];
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
                                            value: team.isSelected,
                                            onChanged: (val) => controller.toggleTeamSelection(index, val),
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
                                          child: Text(
                                            team.name,
                                            style: TTextTheme.h2Style(context).copyWith(fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            team.creationDate,
                                            style: TTextTheme.titleSix(context),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${team.memberCount} people",
                                            style: TTextTheme.titleSix(context),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  context.go('/vendor/TeamMembers');
                                                },
                                                child: SvgPicture.asset(
                                                  IconString.eyeIcon,
                                                  width: 20,
                                                  height: 20,
                                                  colorFilter: const ColorFilter.mode(
                                                    AppColors.tertiaryTextColor,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              InkWell(
                                                onTap: () {
                                                  context.go('/vendor/EditTeam');
                                                },
                                                child: SvgPicture.asset(
                                                  IconString.editIcon,
                                                  width: 20,
                                                  height: 20,
                                                  colorFilter: const ColorFilter.mode(
                                                    AppColors.primaryColor,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              InkWell(
                                                onTap: () {
                                                  _showDeleteTeamVendorDialog(context);
                                                },
                                                child: SvgPicture.asset(
                                                  IconString.deleteIcon,
                                                  width: 20,
                                                  height: 20,
                                                  colorFilter: const ColorFilter.mode(
                                                    AppColors.rejectedColor,
                                                    BlendMode.srcIn,
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

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: controller.previousPage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                        ),
                        child: const Icon(Icons.arrow_back, size: 18, color: AppColors.textColor),
                      ),
                    ),
                    Obx(() => Text(
                      "Page ${controller.currentPage.value} of ${controller.totalPages.value}",
                      style: TTextTheme.titleFive(context),
                    )),
                    InkWell(
                      onTap: controller.nextPage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
                        ),
                        child: const Icon(Icons.arrow_forward, size: 18, color: AppColors.textColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }




    /// Delete Dialogs
  void _showDeleteTeamVendorDialog(
      BuildContext context,
            ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding:  EdgeInsets.symmetric(
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
                            TextString.teamVendorDialogOne,
                            style: TTextTheme.h3Style(context),
                          ),
                          SizedBox(height: 4),
                          Text(
                            TextString.teamVendorDialogTwo,
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
                          backgroundColor: AppColors.rejectedColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showDeleteSuccessTeamVendorDialog(context);
                        },
                        child: Text(
                          "Delete",
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
  void _showDeleteSuccessTeamVendorDialog(BuildContext context) {
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
                        TextString.teamVendorSuccessDialogOne,
                        style: TTextTheme.h3Style(context),
                      ),
                      SizedBox(height: 4),
                      Text(
                        TextString.teamVendorSuccessDialogTwo,
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
