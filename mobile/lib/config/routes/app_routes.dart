import 'package:flutter/material.dart';
import 'package:mobile/features/Auth/domain/entities/doctor_entity.dart';
import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';
import 'package:mobile/features/home/presentation/screen/clinic_detailsScren.dart';
import 'package:mobile/features/home/presentation/screen/doctors_details_screen.dart';
import 'package:mobile/features/home/presentation/screen/doctors_screen.dart';
import 'package:mobile/features/home/presentation/screen/get_start_clinic_screen.dart';
import 'package:mobile/features/onBoarding/screens/chose_auth_fun_screen.dart';
import 'package:mobile/features/onBoarding/screens/chose_user.dart';
import 'package:mobile/features/onBoarding/screens/on_boarding_screen.dart';
import 'package:mobile/features/splash/splash_screen.dart';

import '../../features/Auth/presentation/screens/forget_password_screen.dart';
import '../../features/Auth/presentation/screens/otp_code_screen.dart';
import '../../features/Auth/presentation/screens/rest_password_screen.dart';
import '../../features/Auth/presentation/screens/sign_in_screen.dart';
import '../../features/Auth/presentation/screens/signup_screen.dart';

class Routes {
  static const String initialRoutes = "/";
  static const String onBoardingRoutes = "/OnBoardingScreen";
  static const String choseUserRoutes = "/ChoseUser";
  static const String choseAuthFunScreenRoutes = "/ChoseAuthFunScreen";
  static const String singInScreenRoutes = "/SingInScreen";
  static const String forgetPasswordScreenRoutes = "/ForgetPasswordScreen";
  static const String oTPCodeScreenRoutes = "/OTPCodeScreen";
  static const String restPasswordScreenRoutes = "/RestPasswordScreen";
  static const String signUpScreenRoutes = "/SignUpScreen";
  static const String getStartClinicScreenRoutes = "/GetStartClinicScreen";
  static const String doctorsScreenRoutes = "/DoctorsScreen";
  static const String doctorsDetailsScreenRoutes = "/DoctorsDetailsScreen";
  static const String clinicDetailsScreenRoutes = "/ClinicDetailsScreen";
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
        return MaterialPageRoute(builder: (context) => ChoseUser());
      case Routes.choseAuthFunScreenRoutes:
        return MaterialPageRoute(
          builder: (context) =>
              ChoseAuthFunScreen(num: routeSettings.arguments as int),
        );
      case Routes.singInScreenRoutes:
        return MaterialPageRoute(
            builder: (context) => SingInScreen(
                  num: routeSettings.arguments as int,
                ));
      case Routes.forgetPasswordScreenRoutes:
        return MaterialPageRoute(builder: (context) => ForgetPasswordScreen());
      case Routes.oTPCodeScreenRoutes:
        return MaterialPageRoute(builder: (context) => OTPCodeScreen());
      case Routes.restPasswordScreenRoutes:
        return MaterialPageRoute(builder: (context) => RestPasswordScreen());
      case Routes.signUpScreenRoutes:
        return MaterialPageRoute(
          builder: (context) =>
              SignUpScreen(num: routeSettings.arguments as int),
        );
      case Routes.getStartClinicScreenRoutes:
        return MaterialPageRoute(
            builder: (context) => GetStartClinicScreen(
                  patientUid: routeSettings.arguments as String,
                ));
      case Routes.doctorsScreenRoutes:
        return MaterialPageRoute(
            builder: (context) => DoctorsScreen(
                  patientUid: routeSettings.arguments as String,
                ));
      case Routes.doctorsDetailsScreenRoutes:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => DoctorsDetailsScreen(
                  description: args["about"] as String,
                  email: args['email'] as String,
                  imageurl: args["imageUrl"] as String,
                  name: args["name"] as String,
                  patientUid: args['patientUid'] as String,
                  uid: args['uid'] as String,
                ));
      case Routes.clinicDetailsScreenRoutes:
        final args = routeSettings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
            builder: (context) => ClinicDetailsScreen(
                  uid: args['uid'] as String,
                  patientUid: args['patientUid'] as String,
                  patientEntity: args['patientEntity'] as PatientEntity,
                  doctorName: args['doctorname'] as String,
                ));
    }
  }
}
