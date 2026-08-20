import 'package:employee_monitoring_system/Panel/Admin/SidebarAdmin/SidebarAdminController.dart';
import 'package:employee_monitoring_system/Panel/Admin/SidebarAdmin/Widget/MobileAppbar.dart';
import 'package:employee_monitoring_system/Panel/Admin/SidebarAdmin/Widget/SidebarAdminComponent.dart';
import 'package:employee_monitoring_system/Panel/Admin/SidebarAdmin/Widget/TabletAdminAppbar.dart';
import 'package:employee_monitoring_system/Panel/Admin/SidebarAdmin/Widget/WebAdminBar.dart';
import 'package:employee_monitoring_system/Resources/AppSizes.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class SidebarAdminScreen extends StatelessWidget {
  final Function(String) onTap;
  final Widget? child;
  final bool hideMobileAppBar;
  SidebarAdminScreen({
    super.key,
    required this.onTap,
    this.child,
    this.hideMobileAppBar = false
  }) {
    Get.lazyPut<SidebarAdminController>(() => SidebarAdminController(), fenix: true);
  }

  final SidebarAdminController controller = Get.put(SidebarAdminController());
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

    ///  Sidebar Content

    Widget sidebarContent() {
      return Obx(() {
        final isCollapsed = controller.isCollapsed.value;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.all(isCollapsed ? 12 : 0),
          width: isWeb ? (isCollapsed ? 111 : 260) : 260,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
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
                  child: SidebarAdminComponent.buildLogo(context, isCollapsed),
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
                        // 1. Dashboard
                        SidebarAdminComponent.menuItem(
                          context,
                          controller,
                          iconPath: IconString.dashboardAdminIcon,
                          title: "Dashboard",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/Admin/dashboard'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        // 2. Companies
                        SidebarAdminComponent.menuItem(
                          context,
                          controller,
                          iconPath: IconString.companiesAdminIcon,
                          title: "Companies",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/Admin/companies'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        // 3. Reports
                        SidebarAdminComponent.menuItem(
                          context,
                          controller,
                          iconPath: IconString.reportsAdminIcon,
                          title: "Reports",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/Admin/reports'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        // 4. Subscription
                        SidebarAdminComponent.menuItem(
                          context,
                          controller,
                          iconPath: IconString.subscriptionAdminIcon,
                          title: "Subscription",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/Admin/subscription'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        // 5. Pricing Plans
                        SidebarAdminComponent.menuItem(
                          context,
                          controller,
                          iconPath: IconString.pricingPlanAdminIcon,
                          title: "Pricing Plans",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/Admin/pricing-plans'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        // 6. Demo Requests
                        SidebarAdminComponent.menuItem(
                          context,
                          controller,
                          iconPath: IconString.demoRequestAdminIcon,
                          title: "Demo Requests",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/Admin/demo-requests'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        // 7. Payment
                        SidebarAdminComponent.menuItem(
                          context,
                          controller,
                          iconPath: IconString.paymentAdminIcon,
                          title: "Payment",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/Admin/payment'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        // 8. User and Role
                        SidebarAdminComponent.menuItem(
                          context,
                          controller,
                          iconPath: IconString.userAdminIcon,
                          title: "User and Role",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/Admin/user-and-role'),
                          scaffoldKey: _scaffoldKey,
                        ),

                        // 9. Help Center
                        SidebarAdminComponent.menuItem(
                          context,
                          controller,
                          iconPath: IconString.helpCenterAdminIcon,
                          title: "Help Center",
                          isCollapsed: isCollapsed,
                          onTap: (val) => context.go('/Admin/help-center'),
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

    /// AppBars
    if (isMobile) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(child: sidebarContent()),
        appBar: MobileAdminAppbar(onMenuTap: () => _scaffoldKey.currentState?.openDrawer()),
        body: child,
      );
    }else if (isTab){
      return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(child: sidebarContent()),
        appBar: TabletAdminAppbar(onMenuTap: () => _scaffoldKey.currentState?.openDrawer()),
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
                  WebAdminBar(onMenuClick: () => controller.toggleSidebar()),
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