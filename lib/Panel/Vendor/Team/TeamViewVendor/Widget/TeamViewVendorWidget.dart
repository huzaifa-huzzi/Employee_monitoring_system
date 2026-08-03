import 'package:employee_monitoring_system/Panel/Vendor/Team/TeamController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TeamViewVendorWidget extends StatelessWidget {
  const TeamViewVendorWidget({super.key});

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
                Text(TextString.teamVendorMembers, style: TTextTheme.h1Style(context)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 26.0),
            child: Text(
             TextString.teamMemberVendorSubtitle,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(TextString.allMemberVendor, style: TTextTheme.h2Style(context)),
                  ],
                ),

                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundOfScreenColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(
                        () => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildTabItem(context, controller, "All", 0),
                        _buildTabItem(context, controller, "Active", 1),
                        _buildTabItem(context, controller, "Offline", 2),
                        _buildTabItem(context, controller, "Idle", 3),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Obx(() {
                  final members = controller.filteredMembers;

                  if (members.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Text(
                          TextString.errorVendorTeamText,
                          style: TTextTheme.titleFour(context),
                        ),
                      ),
                    );
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 3;
                      if (constraints.maxWidth < 650) {
                        crossAxisCount = 1;
                      } else if (constraints.maxWidth < 1000) {
                        crossAxisCount = 2;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: members.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 265,
                        ),
                        itemBuilder: (context, index) {
                          final member = members[index];
                          return _buildMemberCard(context, controller, member);
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ------------ Extra Widget ----------///

  // Filter Tab
  Widget _buildTabItem(
      BuildContext context,
      TeamVendorController controller,
      String title,
      int index,
      ) {
    bool isSelected = TeamViewExtension.selectedTabIndex.value == index;

    return InkWell(
      onTap: () {
        TeamViewExtension.selectedTabIndex.value = index;
      },
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: isSelected
              ? TTextTheme.TabsSelectedText(context)
              : TTextTheme.DateBreakDown(context),
        ),
      ),
    );
  }

  // Member Card
  Widget _buildMemberCard(
      BuildContext context,
      TeamVendorController controller,
      EmployeeMemberModel member,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.borderColor.withValues(alpha: 0.3),
                child: const Icon(Icons.person, color: AppColors.textColor, size: 24),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: TTextTheme.h2Style(context).copyWith(fontSize: 15),
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
              const SizedBox(width: 6),
              _buildStatusBadge(context,member.status),
            ],
          ),

          const SizedBox(height: 16),

          _buildInfoRow(context, IconString.roleIcon,TextString.teamRole, member.role),
          const SizedBox(height: 10),
          _buildInfoRow(context, IconString.DepartmentIcon, TextString.teamDepartment, member.department),
          const SizedBox(height: 10),
          _buildInfoRow(context, IconString.calendarIcon, TextString.employeeDetailJoining, member.joiningDate),

          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: () => controller.deleteMember(member.id),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.rejectedColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Delete",
                style: TTextTheme.TabsSelectedText(context).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Info Row
  Widget _buildInfoRow(BuildContext context, String iconPath, String title, String value) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 16,
          height: 16,
          colorFilter: const ColorFilter.mode(
            AppColors.primaryColor,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TTextTheme.titleSix(context).copyWith(
            color: AppColors.tertiaryTextColor,
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TTextTheme.h2Style(context).copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Status Badge
  Widget _buildStatusBadge(BuildContext context,MemberStatus status) {
    Color bgColor;
    String label;

    switch (status) {
      case MemberStatus.active:
        bgColor = AppColors.approvedColor;
        label = "Active";
        break;
      case MemberStatus.offline:
        bgColor = AppColors.rejectedColor;
        label = "Offline";
        break;
      case MemberStatus.idle:
        bgColor = AppColors.tertiaryTextColor;
        label = "Idle";
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TTextTheme.titleRegular12White(context),
      ),
    );
  }
}