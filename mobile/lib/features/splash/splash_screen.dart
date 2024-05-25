import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/assets_path.dart';

import '../../core/cach_helper/cach_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer? _timer;

  goNext() {
    var onBoarding = CacheHelper.getData(key: 'onBoarding');
    var token = CacheHelper.getData(key: 'token');
    if (onBoarding != null && token != null) {
      context.pushReplacementNamed(Routes.bottomNavScreenRoutes);
    } else if (onBoarding == null && token == null) {
      context.pushReplacementNamed(Routes.onBoardingRoutes);
    }
    else if (onBoarding != null && token == null) {
      context.pushReplacementNamed(Routes.choseUserRoutes);
    }
  }

  startDely() {
    _timer = Timer(const Duration(seconds: 6), () {
      goNext();
    });
  }

  @override
  void initState() {
    super.initState();
    startDely();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5863CB),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/image/splash.png",
          ),
        ],
      ),
    );
  }
}
