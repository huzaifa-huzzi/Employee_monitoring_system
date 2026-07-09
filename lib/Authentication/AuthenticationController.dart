


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthenticationController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var keepMeLoggedIn = false.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleKeepMeLoggedIn(bool? value) {
    keepMeLoggedIn.value = value ?? false;
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
  }

  Future<void> login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.onClose();
  }


    /// Forgot password
  void sendResetPasswordCode(BuildContext context) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    context.go('/otpVerification');
  }

   /// Otp Verification
  final otpController = TextEditingController();

  void verifyOtp(BuildContext context) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    context.go('/resetPassword');

  }

   /// New password
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isNewPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  void resetPassword() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;

  }

   /// Invitation Based
  final nameController = TextEditingController();

  void signup() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;

  }


}