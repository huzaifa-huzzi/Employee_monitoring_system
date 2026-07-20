import 'package:employee_monitoring_system/Resources/ImageString.dart';
import 'package:get/get.dart';

class ScreenshotModel {
  final String timeSlot;
  final String description;
  final double progress;
  final String imageUrl;

  ScreenshotModel({
    required this.timeSlot,
    required this.description,
    required this.progress,
    required this.imageUrl,
  });
}

class ScreenshotController extends GetxController {

  var workedTime = "4hrs".obs;
  var averageActivity = "65% of the time".obs;
  var selectedDate = "15 July 2026".obs;
  var currentSlotRange = "2:00 pm - 3:00 pm".obs;
  var totalTimeWorkedInSlot = "Total time worked: 0:54:43".obs;

  var screenshotsList = <ScreenshotModel>[
    ScreenshotModel(timeSlot: "2:00 pm - 2:10 pm", description: "53% of 10 minutes", progress: 0.53, imageUrl: ImageString.screenShotImage),
    ScreenshotModel(timeSlot: "2:10 pm - 2:20 pm", description: "53% of 10 minutes", progress: 0.53,  imageUrl: ImageString.screenShotImage),
    ScreenshotModel(timeSlot: "2:20 pm - 2:30 pm", description: "53% of 10 minutes", progress: 0.53 , imageUrl: ImageString.screenShotImage),
    ScreenshotModel(timeSlot: "2:30 pm - 2:40 pm", description: "53% of 10 minutes", progress: 0.53,  imageUrl: ImageString.screenShotImage),
    ScreenshotModel(timeSlot: "2:40 pm - 2:50 pm", description: "53% of 10 minutes", progress: 0.53,  imageUrl: ImageString.screenShotImage),
    ScreenshotModel(timeSlot: "2:50 pm - 3:00 pm", description: "53% of 10 minutes", progress: 0.53,  imageUrl: ImageString.screenShotImage),
  ].obs;
}