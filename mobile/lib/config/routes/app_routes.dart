import 'package:flutter/material.dart';
import 'package:mobile/features/onBoarding/on_boarding_screen.dart';
import 'package:mobile/features/splash/splash_screen.dart';

class Routes {
  static const String initialRoutes = "/";
  static const String onBoardingRoutes = "/OnBoardingScreen";
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoutes:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.onBoardingRoutes:
        return MaterialPageRoute(builder: (context)=>const  OnBoardingScreen());
    }
  }
}
