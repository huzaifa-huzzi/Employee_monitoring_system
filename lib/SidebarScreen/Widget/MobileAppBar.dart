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

  @override
  Widget build(BuildContext context) {
    final SideBarController controller = Get.find<SideBarController>();

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8), // Padding kam ki taake space bache
        child: Row(
          children: [
            /// ☰ HAMBURGER MENU
            IconButton(
              onPressed: widget.onMenuTap,
              icon: const Icon(Icons.menu, color: Colors.black87, size: 22),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),

            const SizedBox(width: 8),

            /// ⏱ FULLY RESPONSIVE TIMER BOX
            // Flexible use kiya hai taake screen choti hone par ye box compress ho sake
            Flexible(
              child: CompositedTransformTarget(
                link: _timerLink,
                child: OverlayPortal(
                  controller: _timerController,
                  overlayChildBuilder: (context) => _buildTimerPopup(controller),
                  child: InkWell(
                    onTap: _timerController.toggle,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 38,
                      // Max width set ki hai lekin ye flexible hai
                      constraints: const BoxConstraints(maxWidth: 180, minWidth: 100),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE0E4EC), width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.access_time, color: Colors.grey, size: 16),

                          const SizedBox(width: 4),

                          // FittedBox text ko resize kar dega agar jagah bohot kam ho jaye
                          Expanded(
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown, // Text overflow nahi hone dega
                                child: Obx(() => Text(
                                  controller.seconds.value == 0 ? "--:--:--" : controller.formattedTime,
                                  style: const TextStyle(
                                    color: Color(0xFF4B84FB),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                )),
                              ),
                            ),
                          ),

                          const SizedBox(width: 4),

                          const Icon(Icons.north_east, color: Colors.black54, size: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            /// 👤 PROFILE DROPDOWN
            const Icon(Icons.keyboard_arrow_down, color: Colors.black87, size: 22),
          ],
        ),
      ),
    );
  }

  /// 🛠 TIMER POPUP UI (Wahi logic jo hamesha popup niche dikhaye)
  Widget _buildTimerPopup(SideBarController controller) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _timerController.hide,
          child: Container(color: Colors.transparent),
        ),
        CompositedTransformFollower(
          link: _timerLink,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          offset: const Offset(0, 8),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              constraints: const BoxConstraints(maxWidth: 320),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: _timerController.hide,
                      child: const Icon(Icons.close, size: 16, color: Colors.grey),
                    ),
                  ),
                  Row(
                    children: [
                      Obx(() => IconButton(
                        icon: Icon(controller.isRunning.value ? Icons.pause_circle_filled : Icons.play_circle_fill),
                        color: const Color(0xFF4B84FB),
                        iconSize: 35,
                        onPressed: controller.toggleTimer,
                      )),
                      const Spacer(),
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
                  const Divider(),
                  const Text("Project Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Select Project", style: TextStyle(fontSize: 12)),
                        Icon(Icons.keyboard_arrow_down, size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.toggleTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B84FB),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Obx(() => Text(
                        controller.isRunning.value ? "Stop" : "Start",
                        style: const TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
