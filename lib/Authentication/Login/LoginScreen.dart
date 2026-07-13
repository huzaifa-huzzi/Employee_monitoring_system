import 'package:employee_monitoring_system/Authentication/AuthenticationController.dart';
import 'package:employee_monitoring_system/Authentication/ReusableWidgetOfLogin/PrimaryBtnOfLogin.dart';
import 'package:employee_monitoring_system/Resources/AppSizes.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/ImageString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationController());
    final bool isDesktop = AppSizes.isWeb(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.backgroundOfScreenColor,
            child: isDesktop
                ? Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    color: AppColors.backgroundOfScreenColor,
                    child: _buildLoginForm(context, controller),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, right: 16.0, bottom: 16.0, left: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        ImageString.loginPic,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ],
            )
                : _buildLoginForm(context, controller),
          ),
        ),
      ),
    );
  }

  /// ------ Extra Widget ------- ///
  // Login Form
  Widget _buildLoginForm(
      BuildContext context, AuthenticationController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.isWeb(context) ? 56.0 : 24.0,
                vertical: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(IconString.logoIcon),
                      const SizedBox(width: 10),
                      Text(
                      TextString.logoText,
                        style: TTextTheme.hLogoName(context),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                          color: AppColors.crossBackground,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.textColor.withValues(alpha: 0.04),
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            IconString.loginUser,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        TextString.loginTitle,
                        style: TTextTheme.h3Style(context),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        TextString.loginSubtitle,
                        style: TTextTheme.selectProjectText(context),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        TextString.emailText,
                        style: TTextTheme.titleSix(context),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        cursorColor: AppColors.textColor,
                        style: TTextTheme.FieldWriteTheText(context),
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          hintText: TextString.emailField,
                          hintStyle: TTextTheme.InsideAlreadyWrittenText(context),
                          filled: true,
                          fillColor: AppColors.whiteColor,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.borderColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.borderColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        TextString.passwordText,
                        style: TTextTheme.titleSix(context),
                      ),
                      const SizedBox(height: 6),
                      Obx(
                            () => TextFormField(
                          cursorColor: AppColors.textColor,
                          style: TTextTheme.FieldWriteTheText(context),
                          controller: controller.passwordController,
                          obscureText: controller.isPasswordHidden.value,
                          decoration: InputDecoration(
                            hintText:TextString.passwordField ,
                            hintStyle: TTextTheme.InsideAlreadyWrittenText(context),
                            filled: true,
                            fillColor: AppColors.whiteColor,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.borderColor),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.tertiaryTextColor,
                                size: 18,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: Obx(
                                        () => Checkbox(
                                      value: controller.keepMeLoggedIn.value,
                                      onChanged: controller.toggleKeepMeLoggedIn,
                                      activeColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    TextString.loggedInText,
                                    style: TTextTheme.titleFive(context),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              context.go('/forgotPassword');
                            },
                            child: Text(
                             TextString.forgotPasswordText,
                              style: TTextTheme.ForgotPasswordText(context),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Obx(
                            () => controller.isLoading.value
                            ? Container(
                          height: 42,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                color: AppColors.whiteColor,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        )
                            : PrimaryBtnOfLogin(
                          text: 'Sign In',
                          height: 42,
                          width: double.infinity,
                          onTap: () => controller.login(context),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            context.go('/signup');
                          },
                          child: RichText(
                            text: TextSpan(
                              style: TTextTheme.titleFive(context).copyWith(
                                color: AppColors.tertiaryTextColor,
                              ),
                              children: [
                                const TextSpan(
                                  text:TextString.dontAccount ,
                                ),
                                TextSpan(
                                  text: 'Sign up',
                                  style: TTextTheme.loginTexts(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 8,
                    spacing: 12,
                    children: [
                      Text(
                       TextString.footerOne,
                        style: TTextTheme.titleSix(context),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _footerLink(context, IconString.privacyIcon,TextString.footerTwo ),
                          const SizedBox(width: 12),
                          _footerLink(context, IconString.termIcon,TextString.footerThree ),
                          const SizedBox(width: 12),
                          _footerLink(context, IconString.helpLoginIcon,TextString.footerFour ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Footer Link Widget
  Widget _footerLink(BuildContext context, String icon, String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 14,
          height: 14,
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(
              AppColors.tertiaryTextColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: TTextTheme.titleSix(context),
        ),
      ],
    );
  }
}
