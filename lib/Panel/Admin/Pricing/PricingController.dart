import 'package:get/get.dart';


import 'package:flutter/material.dart';

class PricingPlanModel {
  final String title;
  final String price;
  final String duration;
  final String description;
  final List<String> features;
  RxBool isActive;

  PricingPlanModel({
    required this.title,
    required this.price,
    this.duration = "/per month",
    required this.description,
    required this.features,
    bool isActive = true,
  }) : isActive = isActive.obs;
}

class PricingController extends GetxController {
  // Existing Plans List
  var plans = <PricingPlanModel>[
    PricingPlanModel(
      title: "Starter",
      price: "\$9",
      description: "For small teams getting started with time tracking",
      features: [
        "Up to 25 employees",
        "Time Sheet",
        "Screen Shot",
        "Activity Tracking",
        "Apps Tracking",
        "Url Tracking",
      ],
      isActive: true,
    ),
    PricingPlanModel(
      title: "Growth",
      price: "\$18",
      description: "Scaling companies that need monitoring and analytics",
      features: [
        "Up to 50 employees",
        "Time Sheet",
        "Screen Shot",
        "Activity Tracking",
        "Apps Tracking",
        "Url Tracking",
      ],
      isActive: true,
    ),
    PricingPlanModel(
      title: "Enterprise",
      price: "\$27",
      description: "Full platform with SSO, audit trail and dedicated support",
      features: [
        "Up to 100 employees",
        "Time Sheet",
        "Screen Shot",
        "Activity Tracking",
        "Apps Tracking",
        "Url Tracking",
      ],
      isActive: true,
    ),
  ].obs;

  // ------------ CREATE PLAN FORM CONTROLLERS & STATES ------------
  final planNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final monthlyPriceController = TextEditingController();
  final yearlyPriceController = TextEditingController();
  final employeeLimitController = TextEditingController();
  final trialDurationController = TextEditingController();
  final featuresController = TextEditingController();

  RxBool isTrialAvailable = false.obs;

  // Toggle active status for existing plan
  void togglePlanStatus(int index) {
    plans[index].isActive.value = !plans[index].isActive.value;
  }

  // Toggle trial availability switch in Create Plan form
  void toggleTrial(bool value) {
    isTrialAvailable.value = value;
  }

  // Function to save new plan
  void savePlan() {
    if (planNameController.text
        .trim()
        .isEmpty || monthlyPriceController.text
        .trim()
        .isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all required fields",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Convert features text area lines into list
    List<String> featuresList = featuresController.text
        .split('\n')
        .where((line) =>
    line
        .trim()
        .isNotEmpty)
        .toList();

    // Add new plan to list
    plans.add(
      PricingPlanModel(
        title: planNameController.text.trim(),
        price: "\$${monthlyPriceController.text.trim()}",
        description: descriptionController.text.trim(),
        features: featuresList.isNotEmpty ? featuresList : ["Basic Access"],
        isActive: isTrialAvailable.value,
      ),
    );

    clearFormFields();
    Get.back();
  }

  // Clear fields after adding
  void clearFormFields() {
    planNameController.clear();
    descriptionController.clear();
    monthlyPriceController.clear();
    yearlyPriceController.clear();
    employeeLimitController.clear();
    trialDurationController.clear();
    featuresController.clear();
    isTrialAvailable.value = false;
  }

  int? editingIndex;

// Populates form fields with selected plan data
  void populateEditData(PricingPlanModel plan, int index) {
    editingIndex = index;
    planNameController.text = plan.title;
    descriptionController.text = plan.description;
    monthlyPriceController.text = plan.price.replaceAll('\$', '');
    yearlyPriceController.text =
    ""; // Pass existing yearly price if available in model
    employeeLimitController.text = ""; // Pass limit if available in model
    trialDurationController.text = "";
    featuresController.text = plan.features.join('\n');
    isTrialAvailable.value = plan.isActive.value;
  }

// Update Existing Plan
  void updatePlan() {
    if (editingIndex != null && editingIndex! < plans.length) {
      List<String> updatedFeatures = featuresController.text
          .split('\n')
          .where((line) =>
      line
          .trim()
          .isNotEmpty)
          .toList();

      plans[editingIndex!] = PricingPlanModel(
        title: planNameController.text.trim(),
        price: "\$${monthlyPriceController.text.trim()}",
        description: descriptionController.text.trim(),
        features: updatedFeatures.isNotEmpty ? updatedFeatures : [
          "Basic Access"
        ],
        isActive: isTrialAvailable.value,
      );

      clearFormFields();
      editingIndex = null;
    }

    @override
    void onClose() {
      planNameController.dispose();
      descriptionController.dispose();
      monthlyPriceController.dispose();
      yearlyPriceController.dispose();
      employeeLimitController.dispose();
      trialDurationController.dispose();
      featuresController.dispose();
      super.onClose();
    }
  }
}