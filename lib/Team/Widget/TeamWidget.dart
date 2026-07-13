import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:employee_monitoring_system/Team/TeamController.dart';
import 'package:employee_monitoring_system/Team/TeamMember/TeamMember.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TeamWidget extends StatelessWidget {
  const TeamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TeamController controller = Get.put(TeamController());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Team',
            style: TTextTheme.h1Style(context),
          ),
          const SizedBox(height: 4),
           Text(
            'You can see your team members here',
            style: TTextTheme.InsideAlreadyWrittenText(context),
          ),
          const SizedBox(height: 24),

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
                  'Team Members',
                  style: TTextTheme.h2Style(context),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width < 900
                        ? 800
                        : MediaQuery.of(context).size.width - 120,
                    child: Column(
                      children: [
                        Obx(() => _buildTableHeaderRow(context,controller)),
                        const SizedBox(height: 12),
                        Obx(
                              () => ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.projects.length,
                            separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final item = controller.projects[index];
                              return _buildTableRow(context,controller, item, index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),
                Obx(() => _buildPaginationRow(context,controller)),
              ],
            ),
          ),
        ],
      ),
    );
  }

   /// ----------- Extra Widgets ---------- ///

  // Header Column
  Widget _buildTableHeaderRow(BuildContext context,TeamController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfScreenColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor)
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child:Checkbox(
              value: controller.selectAll.value,
              onChanged: controller.toggleSelectAll,
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.primaryColor;
                }
                return Colors.transparent;
              }),
              checkColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(
                color: AppColors.borderColor,
              ),
            )
          ),
          const SizedBox(width: 8),
           Expanded(
            flex: 3,
            child: Text(
              'Project Name',
              style: TTextTheme.titleSeven(context),
            ),
          ),
           Expanded(
            flex: 2,
            child: Text(
              'Start Date',
              style:TTextTheme.titleSeven(context),
            ),
          ),
           Expanded(
            flex: 2,
            child: Text(
              'End Date',
              style: TTextTheme.titleSeven(context)
            ),
          ),
           Expanded(
            flex: 2,
            child: Text(
              'Team Members',
              style: TTextTheme.titleSeven(context)
            ),
          ),
        ],
      ),
    );
  }

  // Individual Table Row
  Widget _buildTableRow(
      BuildContext context,TeamController controller, TeamProjectModel item, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: Checkbox(
              value: controller.selectAll.value,
              onChanged: controller.toggleSelectAll,
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.primaryColor;
                }
                return Colors.transparent;
              }),
              checkColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(
                color: AppColors.borderColor,
              ),
            )
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              item.projectName,
              style: TTextTheme.titleEight(context),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              item.startDate,
              style:TTextTheme.titleFour(context),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              item.endDate,
              style: TTextTheme.timerText(context)
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    // Get.to() ki jagah Navigator.push use karein taake GoRouter se crash na ho
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TeamMembersScreen()),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 32,
                    width: (item.avatars.length * 20.0) + 32,
                    child: Stack(
                      children: [
                        for (int i = 0; i < item.avatars.length; i++)
                          Positioned(
                            left: i * 18.0,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: AppColors.whiteColor,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(item.avatars[i]),
                              ),
                            ),
                          ),
                        Positioned(
                          left: item.avatars.length * 18.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '+${item.remainingCount}',
                              style: TTextTheme.Numbers(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //  Pagination
  Widget _buildPaginationRow(BuildContext context,TeamController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: controller.previousPage,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child:  Icon(Icons.arrow_back, size: 18, color: AppColors.textColor),
          ),
        ),
        Text(
          'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
          style: TTextTheme.FieldWriteTheText(context),
        ),
        InkWell(
          onTap: controller.nextPage,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_forward, size: 18, color: AppColors.textColor),
          ),
        ),
      ],
    );
  }
}