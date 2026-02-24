import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_monitoring_system/SidebarScreen/SidebarController.dart';

class TabletAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onMenuTap;

  const TabletAppBar({super.key, required this.onMenuTap});

  @override
  State<TabletAppBar> createState() => _TabletAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _TabletAppBarState extends State<TabletAppBar> {
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
          children: [
            InkWell(
              onTap:widget.onMenuTap,
              child: Image.asset(
                IconString.menuIcon,
              ),
            ),

            const SizedBox(width: 10),

            /// Timer Box
            CompositedTransformTarget(
              link: _timerLink,
              child: OverlayPortal(
                controller: _timerController,
                overlayChildBuilder: (context) => CompositedTransformFollower(
                  link: _timerLink,
                  targetAnchor: Alignment.bottomLeft,
                  followerAnchor: Alignment.topLeft,
                  offset: const Offset(0, 8),
                  child: Align(alignment: Alignment.topLeft, child: _buildTimerPopup(SideBarController())),
                ),
                child: InkWell(
                  onTap: _timerController.toggle,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(IconString.timerIcon),
                        const SizedBox(width: 8),
                        Obx(() => Text(
                          controller.formattedTime,
                          style: TTextTheme.timerText(context),
                        )),
                        const SizedBox(width: 8),
                        Image.asset(IconString.forwardIcon),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),


            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.backgroundContainerOfNotification,
                shape: BoxShape.circle,
              ),
              child:Image.asset(IconString.notificationIcon,height: 18,width: 18,),
            ),

            const SizedBox(width: 15),

            ///  PROFILE SECTION
            CompositedTransformTarget(
              link: _profileLink,
              child: OverlayPortal(
                controller: _profileController,
                overlayChildBuilder: (context) => _buildSignOutPopup(controller),
                child: InkWell(
                  onTap: _profileController.toggle,
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Text(
                            "Alina Thompson",
                            style:TTextTheme.titleOne(context),
                          ),
                          Text(
                            "User",
                            style: TTextTheme.titleTwo(context),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Image.asset(IconString.arrowDownIcon),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- Extra Widget -------///

   // Timer popup
  Widget _buildTimerPopup(SideBarController controller) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 350,
        constraints: const BoxConstraints(
          maxHeight: 500,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// TIMER ROW
              Row(
                children: [

                  InkWell(
                    onTap: () {
                      if (!controller.isRunning.value) {
                        controller.toggleTimer();
                      }
                    },
                    child: Obx(() => Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:  AppColors.backgroundContainerOfNotification,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        controller.isRunning.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 28,
                        color:AppColors.primaryColor,
                      ),
                    )),
                  ),

                  const SizedBox(width: 12),

                  Text(
                    "-----",
                    style: TTextTheme.titleThree(context),
                  ),

                  const Spacer(),

                  ///  TIME DISPLAY
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(() => Text(
                        controller.formattedTime,
                        style: TTextTheme.InsidetimerText(context),
                      )),
                      const SizedBox(height: 2),
                      Text(
                          "Today: 00:00:00",
                          style: TTextTheme.titleFour(context)
                      ),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  color: AppColors.textGrey,
                  thickness: 0.8,
                ),
              ),

              ///  PROJECT NAME
              Text(
                "Project Name",
                style: TTextTheme.titleFive(context),
              ),

              const SizedBox(height: 10),

              /// PROJECT DROPDOWN
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Project",
                      style: TTextTheme.selectProjectText(context),
                    ),
                    Image.asset(IconString.arrowDownIcon),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              ///  STOP BUTTON
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

  // SIGN OUT POPUP
  Widget _buildSignOutPopup(SideBarController controller) {
    return Stack(
      children: [
        GestureDetector(onTap: _profileController.hide, child: Container(color: Colors.transparent)),
        CompositedTransformFollower(
          link: _profileLink,
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          offset: const Offset(0, 10),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 150,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: () {
                  controller.signOut();
                  _profileController.hide();
                },
                child: Row(
                  children:  [
                    Image.asset(IconString.logoutIcon),
                    SizedBox(width: 10),
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