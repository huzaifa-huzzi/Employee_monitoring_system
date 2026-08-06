import 'package:employee_monitoring_system/Panel/Employee/SidebarScreen/SidebarController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SidebarComponents {
  /// Logo Section
  static Widget buildLogo(BuildContext context, bool isCollapsed) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCollapsed ? 0 : 24,
        vertical: 20,
      ),
      child: SizedBox(
        height: 30,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(IconString.logoIcon),
              if (!isCollapsed) ...[
                const SizedBox(width: 12),
                Text(
                  "SoftSnip",
                  style: TTextTheme.hLogoName(context),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  /// Menu Item
  static Widget menuItem(
      BuildContext context,
      SideBarController controller, {
        required String iconPath,
        required String title,
        required bool isCollapsed,
        Widget? trailing,
        bool? isSelected,
        required Function(String) onTap,
        required GlobalKey<ScaffoldState> scaffoldKey,
      }) {
    return Obx(() {
      final selectedValue = controller.selected.value;
      final bool active = isSelected ?? (selectedValue == title);

      return InkWell(
        onTap: () {
          controller.selected.value = title;
          onTap(title);

          if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          height: 48,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: active ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const SizedBox(width: 14),

              /// ICON
              Image.asset(
                iconPath,
                width: 20,
                height: 20,
                color: active ? AppColors.whiteColor : AppColors.subtextColor,
                colorBlendMode: BlendMode.srcIn,
              ),

              if (!isCollapsed) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: active
                        ? TTextTheme.pSelectedSidebar(context)
                        : TTextTheme.pSidebar(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (trailing != null) trailing,
                const SizedBox(width: 10),
              ],
            ],
          ),
        ),
      );
    });
  }

  /// Dropdown Tree Item with Sub-Items
  static Widget dropdownMenuItem(
      BuildContext context,
      SideBarController controller, {
        required String iconPath,
        required String title,
        required bool isCollapsed,
        required RxBool isExpanded,
        required List<Map<String, dynamic>> subItems,
        required Function(String) onTap,
        required GlobalKey<ScaffoldState> scaffoldKey,
      }) {
    return Obx(() {
      final isActive = controller.selected.value == title;

      return Column(
        children: [
          menuItem(
            context,
            controller,
            iconPath: iconPath,
            title: title,
            isCollapsed: isCollapsed,
            isSelected: isActive,
            trailing: Icon(
              isExpanded.value
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: isActive ? AppColors.whiteColor : AppColors.subtextColor,
              size: 20,
            ),
            onTap: (val) {
              controller.selectMenu(title);
              isExpanded.toggle();
            },
            scaffoldKey: scaffoldKey,
          ),
          if (isExpanded.value && !isCollapsed)
            Padding(
              padding: const EdgeInsets.only(left: 28, top: 4, bottom: 8),
              child: Stack(
                children: [
                  Positioned(
                    left: 6,
                    top: 0,
                    bottom: 12,
                    child: Container(
                      width: 1.5,
                      color: AppColors.borderColor,
                    ),
                  ),

                  Column(
                    children: subItems.map((sub) {
                      final bool isSubSelected =
                          controller.selectedSubItem.value == sub['title'];

                      return InkWell(
                        onTap: () {
                          controller.selectMenu(title, subItem: sub['title']);
                          if (sub['onTap'] != null) sub['onTap']();
                          if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 13,
                                height: 13,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSubSelected
                                      ? AppColors.primaryColor
                                      : AppColors.backgroundOfScreenColor,
                                  border: Border.all(
                                    color: AppColors.borderColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSubSelected
                                          ? AppColors.primaryColor
                                          : Colors.transparent,
                                      width: 1.2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      if (sub['icon'] != null) ...[
                                        Image.asset(
                                          sub['icon'],
                                          width: 18,
                                          height: 18,
                                          color: isSubSelected
                                              ? AppColors.primaryColor
                                              : AppColors.subtextColor,
                                          colorBlendMode: BlendMode.srcIn,
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                      Expanded(
                                        child: Text(
                                          sub['title'],
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: isSubSelected
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            color: isSubSelected
                                                ? AppColors.primaryColor
                                                : AppColors.textColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }
}