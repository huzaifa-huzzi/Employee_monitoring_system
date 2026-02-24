import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_monitoring_system/SidebarScreen/SidebarController.dart';

class MobileAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onMenuTap;

  const MobileAppBar({super.key, required this.onMenuTap});

  @override
  State<MobileAppBar> createState() => _MobileAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _MobileAppBarState extends State<MobileAppBar> {
  final OverlayPortalController _timerController = OverlayPortalController();
  final _timerLink = LayerLink();

  final OverlayPortalController _profileController = OverlayPortalController();
  final _profileLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    final SideBarController controller = Get.find<SideBarController>();

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: widget.onMenuTap,
                  child: Image.asset(IconString.menuIcon),
                ),

                const SizedBox(width: 12),

                /// TIMER BOX
                CompositedTransformTarget(
                  link: _timerLink,
                  child: OverlayPortal(
                    controller: _timerController,
                    overlayChildBuilder: (context) => CompositedTransformFollower(
                      link: _timerLink,
                      targetAnchor: Alignment.bottomLeft,
                      followerAnchor: Alignment.topLeft,
                      offset: const Offset(0, 8),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: _buildTimerPopup(controller)
                      ),
                    ),
                    child: InkWell(
                      onTap: _timerController.toggle,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width < 400 ? 130 : 165,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.borderColor, width: 1.2),
                        ),
                        child: Row(
                          children: [
                            Image.asset(IconString.timerIcon),
                            Expanded(
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Obx(() => Text(
                                    controller.seconds.value == 0 ? "--:--:--" : controller.formattedTime,
                                    style: TTextTheme.timerText(context),
                                  )),
                                ),
                              ),
                            ),
                            Image.asset(IconString.forwardIcon),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// PROFILE SECTION
            CompositedTransformTarget(
              link: _profileLink,
              child: OverlayPortal(
                controller: _profileController,
                overlayChildBuilder: (context) => _buildSignOutPopup(controller),
                child: IconButton(
                  onPressed: _profileController.toggle,
                  icon: Image.asset(IconString.arrowDownIcon),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ------- Extra Widget -------- ///

  //  TIMER POPUP
  Widget _buildTimerPopup(SideBarController controller) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: screenWidth < 400 ? screenWidth * 0.85 : 350,
        constraints: const BoxConstraints(
          maxHeight: 500,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// CLOSE BUTTON
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: _timerController.hide,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.crossBackground,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 16, color: AppColors.textColor),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// TIMER ROW
              Row(
                children: [
                  InkWell(
                    onTap: controller.toggleTimer,
                    child: Obx(() => Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundContainerOfNotification,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        controller.isRunning.value ? Icons.pause : Icons.play_arrow,
                        size: 24,
                        color: AppColors.primaryColor,
                      ),
                    )),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      "-----",
                      style: TTextTheme.titleThree(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  /// TIME DISPLAY
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(() => FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          controller.formattedTime,
                          style: TTextTheme.InsidetimerText(context),
                        ),
                      )),
                      const SizedBox(height: 2),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Today: 00:00",
                          style: TTextTheme.titleFour(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: AppColors.textGrey, thickness: 0.8),
              ),

              /// PROJECT SECTION
              Text("Project Name", style: TTextTheme.titleFive(context)),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Select Project",
                        style: TTextTheme.selectProjectText(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Image.asset(IconString.arrowDownIcon, height: 12),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: controller.toggleTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  child: Obx(() => Text(
                    controller.isRunning.value ? "Stop" : "Start",
                    style: TTextTheme.btnTextOne(context),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //SIGN OUT POPUP
  Widget _buildSignOutPopup(SideBarController controller) {
    return Stack(
      children: [
        GestureDetector(onTap: _profileController.hide, child: Container(color: Colors.transparent)),
        CompositedTransformFollower(
          link: _profileLink,
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          offset: const Offset(0, 8),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {
                controller.signOut();
                _profileController.hide();
              },
              child: Container(
                width: 140,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children:  [
                    Image.asset(IconString.logoutIcon),
                    const SizedBox(width: 10),
                    Text("Sign Out", style: TTextTheme.signoutIconText(context)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}