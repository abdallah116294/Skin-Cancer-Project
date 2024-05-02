import 'package:flutter/material.dart';
import 'package:mobile/features/Auth/screens/forget_password_screen.dart';
import 'package:mobile/features/Auth/screens/otp_code_screen.dart';
import 'package:mobile/features/Auth/screens/rest_password_screen.dart';
import 'package:mobile/features/Auth/screens/sign_in_screen.dart';
import 'package:mobile/features/Auth/screens/sign_up_screen.dart';
import 'package:mobile/features/onBoarding/screens/chose_auth_fun_screen.dart';
import 'package:mobile/features/onBoarding/screens/chose_user.dart';
import 'package:mobile/features/onBoarding/screens/on_boarding_screen.dart';
import 'package:mobile/features/splash/splash_screen.dart';

class Routes {
  static const String initialRoutes = "/";
  static const String onBoardingRoutes = "/OnBoardingScreen";
  static const String choseUserRoutes = "/ChoseUser";
  static const String choseAuthFunScreenRoutes = "/ChoseAuthFunScreen";
  static const String singInScreenRoutes = "/SingInScreen";
  static const String forgetPasswordScreenRoutes = "/ForgetPasswordScreen";
  static const String oTPCodeScreenRoutes = "/OTPCodeScreen";
  static const String restPasswordScreenRoutes = "/RestPasswordScreen";
  static const String signUpScreenRoutes = "/SignupScreen";
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoutes:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.onBoardingRoutes:
        return MaterialPageRoute(
            builder: (context) => const OnBoardingScreen());
      case Routes.choseUserRoutes:
        return MaterialPageRoute(builder: (context) => const ChoseUser());
      case Routes.choseAuthFunScreenRoutes:
        return MaterialPageRoute(
            builder: (context) =>  ChoseAuthFunScreen(roles: routeSettings.arguments as Map<String,String> ,));
      case Routes.singInScreenRoutes:
        return MaterialPageRoute(builder: (context) => const SingInScreen());
      case Routes.forgetPasswordScreenRoutes:
        return MaterialPageRoute(builder: (context) => ForgetPasswordScreen());
      case Routes.oTPCodeScreenRoutes:
        return MaterialPageRoute(builder: (context) => OTPCodeScreen());
      case Routes.restPasswordScreenRoutes:
        return MaterialPageRoute(builder: (context) => RestPasswordScreen());
      case Routes.signUpScreenRoutes:
        return MaterialPageRoute(builder: (context)=>SignupScreen(roles: routeSettings.arguments as Map<String,String>,));
    }
  }
}
