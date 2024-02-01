import 'package:flutter/material.dart';
import 'package:mobile/core/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/utils/string_manager.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: AppColor.onBoardingColor,
                begin: Alignment.centerRight,
                end: Alignment.centerLeft)),
        child: const Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Image(
                image: AssetImage(AssetsManager.onBoarding),
                width: 373,
                height: 415,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                StringManager.onboarding1,
                style: TextStyle(
                    color: AppColor.textonBoardingColo,
                    fontWeight: FontWeight.w800,
                    fontSize: 20),
              )
            ],
          ),
        ));
  }
}
