import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helper/exetentions.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/cach_helper/cach_helper.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/widgets/app_button.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({
    super.key,
  });

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();

  int currentIndex = 0;
  bool isLast = true;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      OnBoardingWidget(
          currentIndex: currentIndex,
          onTap: () {
            controller.nextPage(
                duration: const Duration(milliseconds: 100),
                curve: Curves.bounceIn);
            setState(() {
              currentIndex = 0;
            });
          },
          imagePath: "assets/image/start_screen.png"),
      OnBoardingWidget(
          currentIndex: currentIndex,
          onTap: () {
            controller.nextPage(
                duration: const Duration(milliseconds: 100),
                curve: Curves.bounceIn);
            setState(() {
              currentIndex = 1;
            });
          },
          imagePath: "assets/image/start_screen_2.png"),
      OnBoardingWidget(
          currentIndex: currentIndex,
          onTap: () {
            setState(() {
              currentIndex = 2;
            });
            CacheHelper.saveData(key: 'onBoarding', value: true);
            context.pushNamedAndRemoveUntil(Routes.choseUserRoutes,
                predicate: (Route<dynamic> route) => false);
          },
          imagePath: "assets/image/start_screen_3.png"),
    ];
    return Scaffold(
      body: PageView.builder(
          onPageChanged: (index) {
            if (index == pages.length - 1) {
              setState(() {
                currentIndex = index;
              });
            }
          },
          itemCount: pages.length,
          controller: controller,
          itemBuilder: (context, index) {
            return pages[index];
          }),
    );
  }
}

class OnBoardingWidget extends StatelessWidget {
  final String imagePath;
  final int currentIndex;
  final void Function() onTap;

  const OnBoardingWidget({
    super.key,
    required this.imagePath,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
            imagePath),
        Positioned(
          bottom: 40,
          right: 10,
          child: AppButton(
              borderRadius: 16,
              buttonColor: AppColor.primaryColor,
              width: 200.w,
              height: 50.h,
              buttonName: currentIndex == 2 ? "Get Started" : "Next",
              onTap: onTap,
              textColor: Colors.white,
              white: true),
        ),
      ],
    );
  }
}
