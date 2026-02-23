import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:employee_monitoring_system/SidebarScreen/SidebarController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SidebarComponents {
  ///  Logo Section
  static Widget buildLogo(BuildContext context, bool isCollapsed) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isCollapsed ? 0 : 24,
          vertical: 30
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

  ///  Regular Menu Item
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
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: active ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const SizedBox(width: 14),

              /// ICON
              Image.asset(
                iconPath,
                width: 22,
                height: 22,
                color: active
                    ? AppColors.whiteColor
                    : AppColors.subtextColor,
                colorBlendMode: BlendMode.srcIn,
              ),

              if (!isCollapsed) ...[
                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    title,
                    style:active ? TTextTheme.pSelectedSidebar(context) : TTextTheme.pSidebar(context),
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

  ///  Dropdown Menu Item
  static Widget dropdownMenuItem(
      BuildContext context,
      SideBarController controller, {
        required String iconPath,
        required String title,
        required bool isCollapsed,
        required RxBool isExpanded,
        required Function(String) onTap,
        required GlobalKey<ScaffoldState> scaffoldKey,
      }) {
    return Obx(() {
      final isActive = controller.selected.value == title;

      return menuItem(
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
          color: isActive
              ? AppColors.whiteColor
              : AppColors.subtextColor,
          size: 20,
        ),
        onTap: (val) {
          controller.selectMenu(title);
          isExpanded.toggle();
        },
        scaffoldKey: scaffoldKey,
      );
    });
  }
}