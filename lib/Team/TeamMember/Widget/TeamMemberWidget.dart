import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:employee_monitoring_system/Team/TeamController.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TeamMembersWidget extends StatelessWidget {
  const TeamMembersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TeamController controller = Get.put(TeamController());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: Icon(Icons.arrow_back_ios_new,
                    size: 20, color: AppColors.textColor),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 12),
              Text(
                'Team',
                style: TTextTheme.h1Style(context),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Text(
              'You can see your team members here',
              style: TTextTheme.InsideAlreadyWrittenText(context),
            ),
          ),
          const SizedBox(height: 24),

          // Main Card View Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textColor.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All member',
                  style: TTextTheme.h2Style(context),
                ),
                const SizedBox(height: 16),
                _buildTabBar(context, controller),
                const SizedBox(height: 24),
                Obx(() {
                  final list = controller.filteredMembers;
                  if (list.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Center(
                        child: Text(
                          'No members found',
                          style: TTextTheme.InsideAlreadyWrittenText(context),
                        ),
                      ),
                    );
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 3;
                      if (constraints.maxWidth < 650) {
                        crossAxisCount = 1;
                      } else if (constraints.maxWidth < 1050) {
                        crossAxisCount = 2;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 180,
                        ),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final member = list[index];
                          return _buildMemberCard(context, member);
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

   /// ------------ Extra Widget --------- ///

  // Capsule Tabs
  Widget _buildTabBar(BuildContext context, TeamController controller) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfScreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(
            () => Wrap(
          spacing: 4,
          children: controller.memberTabs.map((tab) {
            final isSelected = controller.selectedTab.value == tab;
            return InkWell(
              onTap: () => controller.changeTab(tab),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tab,
                  style: isSelected ? TTextTheme.TabsSelectedText(context): TTextTheme.titleThree(context),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Individual Member Card Item
  Widget _buildMemberCard(BuildContext context, TeamMemberModel member) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(member.avatarUrl),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      member.name,
                      style: TTextTheme.titleEight(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      member.email,
                      style: TTextTheme.titleFour(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              _buildStatusBadge(context,member.status),
            ],
          ),

          Row(
            children: [
              SvgPicture.asset(
                IconString.roleIcon,
                width: 15,
                height: 15,
              ),
              const SizedBox(width: 6),
              Text(
                'Role',
                style: TTextTheme.titleSeven(context),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  member.role,
                  style: TTextTheme.titleEight(context),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          // Department Row
          Row(
            children: [
              SvgPicture.asset(
                IconString.DepartmentIcon,
                width: 15,
                height: 15,
              ),
              const SizedBox(width: 6),
              Text(
                'Department',
                style: TTextTheme.titleSeven(context),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  member.department,
                  style: TTextTheme.titleEight(context),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Status Badge Helper
  Widget _buildStatusBadge(BuildContext context,String status) {
    Color bg;

    switch (status.toLowerCase()) {
      case 'active':
        bg = AppColors.approvedColor;
        break;
      case 'offline':
        bg = AppColors.rejectedColor;
        break;
      case 'idle':
      default:
        bg = AppColors.tertiaryTextColor;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style:TTextTheme.TabsSelectedText(context)
      ),
    );
  }
}