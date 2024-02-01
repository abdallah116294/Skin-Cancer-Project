import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/utils/assets_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Column(
        children: [
          const  SizedBox(height: 150,),
          Lottie.asset(AssetsManager.cancerSplash),
        ],
      ) ,
    );
  }
}