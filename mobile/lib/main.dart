import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mobile/app/my_app.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await di.init();
  var token = CacheHelper.getData(key: 'token');
  var role = CacheHelper.getData(key: 'doctor_role');

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  var email = CacheHelper.getData(key: 'email');
  log(onBoarding.toString());

  log(email.toString());
  log(token.toString());
  log(role.toString());
  String? startWidget;
  if (onBoarding != null) {
    if (token != null) {
      startWidget = Routes.bottomNavScreenRoutes;
    } else {
      startWidget = Routes.choseUserRoutes;
    }
  } else {
    startWidget = Routes.SplashScreenRoutes;
  }
  runApp(MyApp(
    startWidget: startWidget,
  ));
}
