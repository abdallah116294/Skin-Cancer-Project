import 'package:flutter/material.dart';
import 'package:mobile/features/Auth/screens/forget_password_screen.dart';
import 'package:mobile/features/Auth/screens/otp_code_screen.dart';
import 'package:mobile/features/Auth/screens/rest_password_screen.dart';
import 'package:mobile/features/Auth/screens/sign_in_screen.dart';
import 'package:mobile/features/Auth/screens/sign_up_screen.dart';
import 'package:mobile/features/disease_info/screens/early_detection.dart';
import 'package:mobile/features/explore/explore_screen.dart';
import 'package:mobile/features/explore/top_doc_screen.dart';
import 'package:mobile/features/explore/doc_details.dart';
import 'package:mobile/features/home/home_screen.dart';
import 'package:mobile/features/onBoarding/screens/chose_auth_fun_screen.dart';
import 'package:mobile/features/onBoarding/screens/chose_user.dart';
import 'package:mobile/features/onBoarding/screens/on_boarding_screen.dart';
import 'package:mobile/features/profile/profile_screen.dart';
import 'package:mobile/features/splash/splash_screen.dart';

import '../../features/bottom_nav/bottom_nav.dart';
import '../../features/disease_info/screens/facts_statistics.dart';
import '../../features/disease_info/screens/prevention.dart';
import '../../features/disease_info/screens/risk_factors.dart';
import '../../features/disease_info/screens/what_is_cancer.dart';

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
  static const String homeScreenRoutes = "/HomeScreen";
  static const String bottomNavScreenRoutes = "/BottomNavScreen";
  static const String exploreScreenRoutes = "/ExploreScreen";
  static const String profileScreenRoutes = "/ProfileScreen";
  static const String whatSkinCanerScreenRoutes = "/WhatSkinCanerScreen";
  static const String factsAndStatisticScreen = "/FactsAndStatisticScreen";
  static const String riskFactorsScreen = "/RiskFactorScreen";
  static const String preventionScreen = "/PreventionScreen";
  static const String earlyDetectionScreen = "/EarlyDetectionScreen";
  static const String topDocScreen = "/TopDocScreen";
  static const String docDetailsScreen = "/DocDetailsScreen";
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
            builder: (context) => ChoseAuthFunScreen(
                  roles: routeSettings.arguments as Map<String, String>,
                ));
      case Routes.singInScreenRoutes:
        return MaterialPageRoute(
            builder: (context) => SingInScreen(
                  roles: routeSettings.arguments as Map<String, String>,
                ));
      case Routes.forgetPasswordScreenRoutes:
        return MaterialPageRoute(builder: (context) => ForgetPasswordScreen());
      case Routes.oTPCodeScreenRoutes:
        return MaterialPageRoute(builder: (context) => OTPCodeScreen());
      case Routes.restPasswordScreenRoutes:
        return MaterialPageRoute(
            builder: (context) =>
                RestPasswordScreen(routeSettings.arguments as String));
      case Routes.signUpScreenRoutes:
        return MaterialPageRoute(
            builder: (context) => SignupScreen(
                  role: routeSettings.arguments as Map<String, String>,
                ));
      case Routes.homeScreenRoutes:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routes.bottomNavScreenRoutes:
        return MaterialPageRoute(builder: (context) => const BottomGNav());
      case Routes.exploreScreenRoutes:
        return MaterialPageRoute(
          builder: (context) => const ExploreScreen(),
        );
      case Routes.profileScreenRoutes:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case Routes.whatSkinCanerScreenRoutes:
        return MaterialPageRoute(builder: (context) => const WhatSkinCaner());
      case Routes.factsAndStatisticScreen:
        return MaterialPageRoute(
            builder: (context) => const FactsAndStatistics());
      case Routes.riskFactorsScreen:
        return MaterialPageRoute(builder: (context) => const RiskFactors());

      case Routes.preventionScreen:
        return MaterialPageRoute(
            builder: (context) => const PreventionScreen());

      case Routes.earlyDetectionScreen:
        return MaterialPageRoute(
            builder: (context) => const EarlyDetectionScreen());

      case Routes.topDocScreen:
        return MaterialPageRoute(builder: (context) => const TopDocScreen());
        case Routes.docDetailsScreen:
        return MaterialPageRoute(builder: (context) => const DocDetailsScreen());
    }
  }
}
