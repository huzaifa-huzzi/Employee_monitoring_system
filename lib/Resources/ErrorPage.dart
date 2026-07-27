import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/ImageString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 280,
                width: 380,
                child: Image.asset(
                  ImageString.errorImage,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.security_rounded,
                          size: 100,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),
              Text(
                "Unauthorized",
                textAlign: TextAlign.center,
                style: TTextTheme.h3Style(context).copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),

              const SizedBox(height: 8),
              Text(
                "Something went wrong on website server",
                textAlign: TextAlign.center,
                style: TTextTheme.titleTwo(context).copyWith(
                  fontSize: 14,
                  color: AppColors.tertiaryTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/dashboard');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Go back to the dashboard",
                    style: TTextTheme.btnTextOne(context).copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}