import 'package:employee_monitoring_system/Panel/Employee/Screenshot/ReusableWidget/CustomDatePickerScreenshotDialog.dart';
import 'package:employee_monitoring_system/Panel/Employee/Screenshot/ReusableWidget/PrimaryButtonOfScreenshot.dart';
import 'package:employee_monitoring_system/Panel/Employee/Screenshot/ScreenshotController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScreenshotWidget extends StatelessWidget {
  const ScreenshotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ScreenshotController controller = Get.put(ScreenshotController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth > 800;
    final bool isSmallMobile = screenWidth < 360;

    return Container(
      padding: EdgeInsets.all(isSmallMobile ? 12 : 24),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isSmallMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               TextString.snapShotTitle,
                style: TTextTheme.titleEight(context).copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildDatePickerTrigger(context, controller),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TextString.snapShotTitle,
                style: TTextTheme.titleEight(context).copyWith(fontWeight: FontWeight.bold),
              ),
              Flexible(child: _buildDatePickerTrigger(context, controller)),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(builder: (context, constraints) {
            final cardWidth = isWeb ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth;
            final content = [
              _buildTopStatCard(context,TextString.workedTime , controller.workedTime.value, AppColors.textColor),
              _buildTopStatCard(context, IconString.averageActivity, controller.averageActivity.value, AppColors.approvedColor),
            ];
            return isWeb
                ? Row(children: content.map((e) => SizedBox(width: cardWidth, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: e))).toList())
                : Column(children: content.map((e) => Padding(padding: const EdgeInsets.only(bottom: 12), child: e)).toList());
          }),
          const SizedBox(height: 24),
          isSmallMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBlueTimeBadge(context, controller),
            ],
          )
              : Row(
            children: [
              Expanded(child: Align(alignment: Alignment.centerLeft, child: _buildBlueTimeBadge(context, controller))),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.screenshotsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWeb ? 3 : (screenWidth > 550 ? 2 : 1),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.88,
              ),
              itemBuilder: (context, index) {
                final item = controller.screenshotsList[index];
                return _buildScreenshotCard(context, item, index, controller.screenshotsList);
              },
            );
          }),
        ],
      ),
    );
  }
   /// ------------ Extra Widget -------------///

  //  Date Picker Widget
  Widget _buildDatePickerTrigger(BuildContext context, ScreenshotController controller) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: CustomDatePickerScreenshotDialog(
                initialDate: DateTime.now(),
                isWeekMode: false,
                onCancel: () => Navigator.pop(context),
                onDateSelected: (DateTime selectedDate, DateTimeRange? weekRange) {
                  final DateFormat formatter = DateFormat('d MMMM yyyy');
                  controller.selectedDate.value = formatter.format(selectedDate);
                  Navigator.pop(context);
                },
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              IconString.calendarIcon,
              height: 14,
              width: 14,
              colorFilter: const ColorFilter.mode(
                AppColors.textColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Obx(() => Text(
                controller.selectedDate.value,
                overflow: TextOverflow.ellipsis,
                style: TTextTheme.titleSix(context).copyWith(fontSize: 12),
              )),
            ),
          ],
        ),
      ),
    );
  }

  // Time Badge
  Widget _buildBlueTimeBadge(BuildContext context, ScreenshotController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.borderColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 6,
        children: [
          Obx(() => Text(controller.currentSlotRange.value, style: TTextTheme.titleEight(context).copyWith(fontSize: 15))),
          Obx(() => RichText(
            text: TextSpan(
              style: TTextTheme.titleThree(context),
              children: [
                TextSpan(
                  text: controller.totalTimeWorkedInSlot.value,
                  style: TTextTheme.h4Style(context)
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  //  Top Info Card
  Widget _buildTopStatCard(BuildContext context, String label, String value, Color valueColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.titleSix(context).copyWith(color: AppColors.tertiaryTextColor)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TTextTheme.h2Style(context).copyWith(color: valueColor, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }

  // Screenshot Grid
  Widget _buildScreenshotCard(BuildContext context, ScreenshotModel item, int index, List<ScreenshotModel> allScreenshots) {
    final ValueNotifier<bool> isHovered = ValueNotifier<bool>(false);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: MouseRegion(
              onEnter: (_) => isHovered.value = true,
              onExit: (_) => isHovered.value = false,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      image: DecorationImage(
                        image: AssetImage(item.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: isHovered,
                    builder: (context, hovered, child) {
                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 180),
                        opacity: hovered ? 1.0 : 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.textColor.withValues(alpha: 0.45),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          ),
                          child: Center(
                            child: PrimarybtnOfScreenshot(
                              text: "View Screen Shot",
                              width: 170,
                              height: 60,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierColor: AppColors.textColor.withValues(alpha: 0.85),
                                  builder: (_) => ScreenshotGalleryDialog(
                                    initialIndex: index,
                                    screenshots: allScreenshots,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  item.timeSlot,
                  style: TTextTheme.titleSeven(context).copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: item.progress,
                    minHeight: 6,
                    backgroundColor: AppColors.borderColor,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.approvedColor),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.description,
                        overflow: TextOverflow.ellipsis,
                        style: TTextTheme.titleSix(context).copyWith(fontSize: 11, color: AppColors.tertiaryTextColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

  /// Screenshot Gallery Dialog
class ScreenshotGalleryDialog extends StatefulWidget {
  final int initialIndex;
  final List<ScreenshotModel> screenshots;

  const ScreenshotGalleryDialog({
    super.key,
    required this.initialIndex,
    required this.screenshots,
  });

  @override
  State<ScreenshotGalleryDialog> createState() => _ScreenshotGalleryDialogState();
}

class _ScreenshotGalleryDialogState extends State<ScreenshotGalleryDialog> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool showArrows = screenWidth > 650;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.screenshots.length,
            onPageChanged: (idx) => setState(() => _currentIndex = idx),
            itemBuilder: (context, idx) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: showArrows ? 80.0 : 16.0),
                  child: InteractiveViewer(
                    maxScale: 3.5,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.8,
                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          widget.screenshots[idx].imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: AppColors.textColor,
              child: IconButton(
                icon: const Icon(Icons.close, color: AppColors.whiteColor, size: 22),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          if (showArrows && _currentIndex > 0)
            Positioned(
              left: 20,
              child: CircleAvatar(
                backgroundColor:AppColors.textColor,
                radius: 22,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.whiteColor, size: 20),
                  onPressed: () => _pageController.previousPage(
                      duration: const Duration(milliseconds: 250), curve: Curves.easeInOut),
                ),
              ),
            ),
          if (showArrows && _currentIndex < widget.screenshots.length - 1)
            Positioned(
              right: 20,
              child: CircleAvatar(
                backgroundColor: AppColors.textColor,
                radius: 22,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.whiteColor, size: 20),
                  onPressed: () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 250), curve: Curves.easeInOut),
                ),
              ),
            ),
        ],
      ),
    );
  }
}