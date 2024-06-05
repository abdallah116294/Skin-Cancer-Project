import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/features/AI_scan/scressns/ai_history_by_doctor.dart';
import 'package:mobile/features/AI_scan/scressns/ai_history_screen.dart';
import 'package:mobile/features/AI_scan/scressns/ai_item_history_details.dart';
import 'package:mobile/features/AI_scan/scressns/ai_scan_screen.dart';
import 'package:mobile/features/Auth/screens/forget_password_screen.dart';
import 'package:mobile/features/Auth/screens/otp_code_screen.dart';
import 'package:mobile/features/Auth/screens/rest_password_screen.dart';
import 'package:mobile/features/Auth/screens/sign_in_screen.dart';
import 'package:mobile/features/Auth/screens/sign_up_screen.dart';
import 'package:mobile/features/clinic/cubit/clinic_cubit.dart';
import 'package:mobile/features/clinic/screens/add_clinic_screen.dart';
import 'package:mobile/features/clinic/screens/doc_clinic_details.dart';
import 'package:mobile/features/clinic/screens/patient_selected_clinic.dart';
import 'package:mobile/features/disease_info/screens/early_detection.dart';
import 'package:mobile/features/explore/cubit/patient_cubit_cubit.dart';
import 'package:mobile/features/explore/explore_screen.dart';
import 'package:mobile/features/explore/top_doc_screen.dart';
import 'package:mobile/features/explore/doc_details.dart';
import 'package:mobile/features/home/home_screen.dart';
import 'package:mobile/features/onBoarding/screens/chose_auth_fun_screen.dart';
import 'package:mobile/features/onBoarding/screens/chose_user.dart';
import 'package:mobile/features/onBoarding/screens/developer_screen.dart';
import 'package:mobile/features/onBoarding/screens/on_boarding_screen.dart';
import 'package:mobile/features/profile/screens/profile_screen.dart';
import 'package:mobile/features/splash/splash_screen.dart';

import '../../features/Auth/cubit/auth_cubit.dart';
import '../../features/bottom_nav/bottom_nav.dart';
import '../../features/disease_info/screens/facts_statistics.dart';
import '../../features/disease_info/screens/prevention.dart';
import '../../features/disease_info/screens/risk_factors.dart';
import '../../features/disease_info/screens/what_is_cancer.dart';
import 'package:mobile/injection_container.dart' as di;

class Routes {
  static const String splashScreenRoutes = "/SplashScreen";
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
  static const String addClinicScreenRoutes = "/AddClinicScreen";
  static const String docClinicDetailsScreenRoutes =
      "/DocClinicDetailsScreenRoutes";
  static const String aIScanScreen = "/AIScanScreen";
  static const String aIHistoryScreen = "/AIHistoryScreen";
  static const String patientSelectedClinic = "/PatientSelectedClinic";
  static const String aIItemHistoryDetailsScreen =
      "/AIItemHistoryDetailsScreen";
  static const String aiHistoryByDoctor = "/AiHistoryByDoctor";
  static const String developerScreen = "/DeveloperScreen";
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreenRoutes:
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
          builder: (context) => BlocProvider(
            create: (context) => di.sl<AuthCubit>(),
            child: RestPasswordScreen(
              routeSettings.arguments as String,
            ),
          ),
        );
      case Routes.signUpScreenRoutes:
        return MaterialPageRoute(
            builder: (context) => SignupScreen(
                  role: routeSettings.arguments as Map<String, String>,
                ));
      case Routes.homeScreenRoutes:
        var token = CacheHelper.getData(key: 'token');
        Map<String, dynamic> data = Jwt.parseJwt(token);
        String docId = data[
            "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          di.sl<ClinicCubit>()..getDocHasClinic(docId: docId),
                    ),
                    // BlocProvider(
                    //   create: (context) =>
                    //       di.sl<AuthCubit>()..getDoctorDetials(docId),
                    // ),
                  ],
                  child: const HomeScreen(),
                ));
      case Routes.bottomNavScreenRoutes:
        return MaterialPageRoute(builder: (context) => const BottomGNav());
      case Routes.exploreScreenRoutes:
        return MaterialPageRoute(
          builder: (context) => const ExploreScreen(),
        );
      case Routes.profileScreenRoutes:
        var token = CacheHelper.getData(key: 'token');
        Map<String, dynamic> data = Jwt.parseJwt(token);
        String docId = data[
            "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          di.sl<AuthCubit>()..getDoctorDetials(docId),
                    ),
                    BlocProvider(
                      create: (context) =>
                          di.sl<AuthCubit>()..getPatientDetails(docId),
                    ),
                  ],
                  child: const ProfileScreen(),
                ));
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
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      di.sl<PatientClinicCubit>()..getAllClinics(),
                  child: TopDocScreen(),
                ));
      case Routes.docDetailsScreen:
        final arg = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => DocDetailsScreen(
                  id: arg,
                ));
      case Routes.addClinicScreenRoutes:
        return MaterialPageRoute(
            builder: (context) => AddClinicScreen(
                  values: routeSettings.arguments as Map<String, int?>,
                ));
      case Routes.docClinicDetailsScreenRoutes:
        return MaterialPageRoute(
            builder: (context) => const DocClinicDetailsScreen());
      case Routes.aIScanScreen:
        return MaterialPageRoute(builder: (context) => const AIScanScreen());
      case Routes.aIHistoryScreen:
        return MaterialPageRoute(builder: (context) => AiHistoryScreen());
      case Routes.patientSelectedClinic:
        return MaterialPageRoute(
            builder: (context) => const PatientSelectedClinic());
      case Routes.aIItemHistoryDetailsScreen:
        return MaterialPageRoute(
            builder: (context) => AIItemHistoryDetailsScreen(
                  outpus: routeSettings.arguments as Map<String, dynamic>,
                ));
      case Routes.aiHistoryByDoctor:
        return MaterialPageRoute(
            builder: (context) => AiHistoryByDoctor(
                  userId: routeSettings.arguments as String,
                ));
      case Routes.developerScreen:
        return MaterialPageRoute(builder: (context) => DeveloperScreen());

      default:
        return null;
    }
  }
}
