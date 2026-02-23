import 'package:employee_monitoring_system/Resources/Colors.dart';
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
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.grey.shade600, size: 20),
            onPressed: onMenuClick,
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
                child: Align(alignment: Alignment.topLeft, child: _buildTimerPopup()),
              ),
              child: InkWell(
                onTap: _timerController.toggle,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time, color: Colors.grey.shade600, size: 18),
                      const SizedBox(width: 8),
                      // Real-time Timer update
                      Obx(() => Text(
                        controller.formattedTime,
                        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13),
                      )),
                      const SizedBox(width: 8),
                      Icon(Icons.call_made, color: Colors.grey.shade400, size: 14),
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.backgroundContainerOfNotification,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_outlined,
                color: Colors.grey.shade700,
                size: 22,
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
                child: Align(alignment: Alignment.topRight, child: _buildSignOutPopup()),
              ),
              child: InkWell(
                onTap: _profileController.toggle,
                child: Row(
                  children: [
                    const CircleAvatar(radius: 18, backgroundColor: Colors.black),
                    const SizedBox(width: 10),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Alina Thompson", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        Text("User", style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(width: 5),
                    Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600, size: 18),
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
  Widget _buildTimerPopup() {
    return Material(
      elevation: 8,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 350,
        constraints: const BoxConstraints(
          maxHeight: 500, // 🔥 prevents overflow on small height
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100),
        ),

        // 🔥 SCROLL FIX
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ❌ CLOSE BUTTON
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: _timerController.hide,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// ⏱ TIMER ROW
              Row(
                children: [

                  /// ▶️ PLAY / PAUSE
                  InkWell(
                    onTap: () {
                      if (!controller.isRunning.value) {
                        controller.toggleTimer();
                      }
                    },
                    child: Obx(() => Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: controller.isRunning.value
                            ? Colors.blue.shade100
                            : Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        controller.isRunning.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 28,
                        color: Colors.blueAccent,
                      ),
                    )),
                  ),

                  const SizedBox(width: 12),

                  const Text(
                    "-----",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2,
                      color: Colors.black87,
                    ),
                  ),

                  const Spacer(),

                  /// ⏰ TIME DISPLAY
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(() => Text(
                        controller.formattedTime,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      const SizedBox(height: 2),
                      const Text(
                        "Today: 00:00:00",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  color: Colors.black12,
                  thickness: 0.8,
                ),
              ),

              /// 📁 PROJECT NAME
              const Text(
                "Project Name",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF344767),
                ),
              ),

              const SizedBox(height: 10),

              /// ⬇ PROJECT DROPDOWN
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Project",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 🔴 STOP BUTTON
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: controller.toggleTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B84FB),
                    foregroundColor: Colors.white,
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
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
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
  Widget _buildSignOutPopup() {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 160,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: const Icon(Icons.power_settings_new, color: Colors.red),
          title: const Text("Sign Out", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          onTap: () {
            _profileController.hide();
            controller.signOut();
          },
        ),
      ),
    );
  }
}
