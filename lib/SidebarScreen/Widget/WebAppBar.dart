import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/ImageString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:employee_monitoring_system/SidebarScreen/SidebarController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebAppBAr extends StatelessWidget {
  final VoidCallback onMenuClick;
  WebAppBAr({super.key, required this.onMenuClick});


  final SideBarController controller = Get.put(SideBarController());

  final OverlayPortalController _timerController = OverlayPortalController();
  final _timerLink = LayerLink();
  final OverlayPortalController _profileController = OverlayPortalController();
  final _profileLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          InkWell(
            onTap:onMenuClick,
            child: Image.asset(
              IconString.menuIcon,
            ),
          ),
          const SizedBox(width: 10),

          //  TIMER SECTION
          CompositedTransformTarget(
            link: _timerLink,
            child: OverlayPortal(
              controller: _timerController,
              overlayChildBuilder: (context) => CompositedTransformFollower(
                link: _timerLink,
                targetAnchor: Alignment.bottomLeft,
                followerAnchor: Alignment.topLeft,
                offset: const Offset(0, 8),
                child: Align(alignment: Alignment.topLeft, child: _buildTimerPopup(context)),
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
          InkWell(
            onTap: () {
            },
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: AppColors.backgroundContainerOfNotification,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                IconString.notificationIcon,
                height: 18,
                width: 18,
              ),
            ),
          ),
          const SizedBox(width: 15),

          //  PROFILE SECTION
          CompositedTransformTarget(
            link: _profileLink,
            child: OverlayPortal(
              controller: _profileController,
              overlayChildBuilder: (context) => CompositedTransformFollower(
                link: _profileLink,
                targetAnchor: Alignment.bottomRight,
                followerAnchor: Alignment.topRight,
                offset: const Offset(0, 8),
                child: Align(alignment: Alignment.topRight, child: _buildSignOutPopup(context)),
              ),
              child: InkWell(
                onTap: _profileController.toggle,
                child: Row(
                  children: [
                    CircleAvatar(radius: 18,backgroundImage: AssetImage(ImageString.profilePic),),
                    const SizedBox(width: 10),
                     Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Alina Thompson", style: TTextTheme.titleOne(context)),
                        Text("User", style: TTextTheme.titleTwo(context)),
                      ],
                    ),
                    const SizedBox(width: 5),
                    Image.asset(IconString.arrowDownIcon,height: 18,width: 18,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

   /// -------- Extra Widgets -------- ///
  // Timer Popup
  Widget _buildTimerPopup(BuildContext context) {
    return Material(
      elevation: 8,
      shadowColor: Colors.black26,
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

  // Signout Popup
  Widget _buildSignOutPopup(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 160,
        decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Image.asset(IconString.logoutIcon),
          title:  Text("Sign Out", style: TTextTheme.signoutIconText(context)),
          onTap: () {
            _profileController.hide();
            controller.signOut();
          },
        ),
      ),
    );
  }
}
