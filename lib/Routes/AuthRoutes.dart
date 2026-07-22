import 'package:employee_monitoring_system/Authentication/ForgotPasswrod/ForgotPassword.dart';
import 'package:employee_monitoring_system/Authentication/Invitation/InvitationScreen.dart';
import 'package:employee_monitoring_system/Authentication/Login/LoginScreen.dart';
import 'package:employee_monitoring_system/Authentication/OtpVerification/OtpVerificationScreen.dart';
import 'package:employee_monitoring_system/Authentication/ResetPassword/ResetPassword.dart';
import 'package:employee_monitoring_system/Authentication/Signup/SignUpScreen.dart';
import 'package:go_router/go_router.dart';


class AuthRoutes {
  static final List<RouteBase> routes = [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/forgotPassword',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/otpVerification',
      builder: (context, state) => const OtpVerificationScreen(),
    ),
    GoRoute(
      path: '/resetPassword',
      builder: (context, state) => const ResetPassword(),
    ),
    GoRoute(
      path: '/invitation',
      builder: (context, state) => const InvitationScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
  ];
}