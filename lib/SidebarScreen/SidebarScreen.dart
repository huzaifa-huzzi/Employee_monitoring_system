import 'package:employee_monitoring_system/Resources/AppSizes.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/SidebarScreen/SidebarController.dart';
import 'package:employee_monitoring_system/SidebarScreen/Widget/MobileAppBar.dart';
import 'package:employee_monitoring_system/SidebarScreen/Widget/SidebarComponentWidget.dart';
import 'package:employee_monitoring_system/SidebarScreen/Widget/WebAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SidebarScreen extends StatelessWidget {
  final Function(String) onTap;
  final Widget? child;
  final bool hideMobileAppBar;

  SidebarScreen({
    super.key,
    required this.onTap,
    this.child,
    this.hideMobileAppBar = false
  }) {
    Get.lazyPut<SideBarController>(() => SideBarController(), fenix: true);
  }

  final SideBarController controller = Get.put(SideBarController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizes.isMobile(context);
    final bool isTab = AppSizes.isTablet(context);
    final bool isWeb = AppSizes.isWeb(context);

    final String currentRoute = GoRouterState.of(context).uri.toString();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.syncWithRoute(currentRoute);
    });

    /// 1. Sidebar Content Function

    Widget sidebarContent() {
      return Obx(() {
        final isCollapsed = controller.isCollapsed.value;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.all(isCollapsed ? 12 : 0),
          width: isWeb ? (isCollapsed ? 101 : 260) : 260,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isCollapsed ? 20 : 0),
            boxShadow: isCollapsed
                ? const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              )
            ]
                : [],
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SidebarComponents.buildLogo(context, isCollapsed),
                ),

                Expanded(
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    thickness: 6,
                    radius: const Radius.circular(8),
                    child: ListView(
                      controller: _scrollController,
                      padding: EdgeInsets.zero,
                      children: [
                        SidebarComponents.menuItem(
                          context,
                          controller,
                          iconPath: IconString.dashboardIcon,
                          title: "Dashboard",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/dashboard'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        SidebarComponents.menuItem(
                          context,
                          controller,
                          iconPath: IconString.teamIcon,
                          title: "Team",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/team'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        SidebarComponents.dropdownMenuItem(
                          context,
                          controller,
                          iconPath: IconString.timeSheetIcon,
                          title: "Time Sheet",
                          isCollapsed: isCollapsed,
                          isExpanded: controller.isTimeSheetExpanded,
                          onTap: (val) => context.go('/time-sheet'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        SidebarComponents.menuItem(
                          context,
                          controller,
                          iconPath: IconString.screenShotIcon,
                          title: "Screen Shots",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/screenshots'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        SidebarComponents.menuItem(
                          context,
                          controller,
                          iconPath: IconString.activityTrackingIcon,
                          title: "Activity Tracking",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/activity'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        SidebarComponents.menuItem(
                          context,
                          controller,
                          iconPath: IconString.applicationTrackingIcon,
                          title: "Application Tracking",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/app-tracking'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        SidebarComponents.menuItem(
                          context,
                          controller,
                          iconPath: IconString.urlTrackingIcon,
                          title: "URL Tracking",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/url-tracking'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        SidebarComponents.menuItem(
                          context,
                          controller,
                          iconPath: IconString.meetingIcon,
                          title: "Meeting",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/meeting'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        SidebarComponents.menuItem(
                          context,
                          controller,
                          iconPath: IconString.projectManagementIcon,
                          title: "Project Management",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/projects'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        SidebarComponents.dropdownMenuItem(
                          context,
                          controller,
                          iconPath: IconString.reportIcon,
                          title: "Report",
                          isCollapsed: isCollapsed,
                          isExpanded: controller.isReportExpanded,
                          onTap: (val) => context.go('/report'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        SidebarComponents.menuItem(
                          context,
                          controller,
                          iconPath: IconString.settingIcon,
                          title: "Setting",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/settings'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        SidebarComponents.menuItem(
                          context,
                          controller,
                          iconPath: IconString.helpIcon,
                          title: "Help & Support",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/help'),
                          scaffoldKey: _scaffoldKey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }

    /// RETURN Statement
    if (isMobile || isTab) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(child: sidebarContent()),
        appBar: hideMobileAppBar
            ? null
            : MobileAppBar(
          onMenuTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        body: child,
      );
    } else {
      return Scaffold(
        body: Row(
          children: [
            sidebarContent(),
            SizedBox(width:1,),
            Expanded(
              child: Column(
                children: [
                  WebAppBAr(onMenuClick: () => controller.toggleSidebar()),
                  Expanded(child: child ?? const SizedBox.shrink()),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}