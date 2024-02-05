import 'package:flutter/material.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/features/onBoarding/widgets/clipper.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            bottom: 1,
            child: ClipPath(
              clipper: CustomClipPath3(),
              child: Container(
                width: 468.43,
                height: 419.26,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: AppColor.onBoardingColor)),
              ),
            )),
        Positioned(
            top: 1,
            right: 1,
            child: ClipPath(
              clipper: CustomClipPath2(),
              child: Container(
                width: 338,
                height: 180,
                decoration: const BoxDecoration(color: AppColor.onBoarding2),
              ),
            )),
        CustomPaint(
          painter: RPSCustomPainter(),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: AppColor.onBoardingColor,)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(AssetsManager.onBoarding),
                  width: 373,
                  height: 415,
                ),
                const Text(
                  StringManager.onboarding1,
                  style: TextStyle(
                      color: AppColor.textonBoardingColo,
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.w800,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  StringManager.onBoarding2,
                  style: TextStyle(
                      color: AppColor.textonBoardingColo,
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.choseUserRoutes);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 358,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: AppColor.btnGradient)),
                      child: const Center(
                        child: Text(
                          StringManager.getStarted,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
