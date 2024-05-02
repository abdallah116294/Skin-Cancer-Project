import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/features/onBoarding/screens/chose_user.dart';
import 'package:mobile/features/onBoarding/widgets/custom_paint.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                  children: [
            Image(
              image: const AssetImage(AssetsManager.onBoarding),
              width: 373.w,
              height: 415.h,
            ),
            Text(
              StringManager.onboarding1,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              StringManager.onBoarding2,
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
            ),
            SizedBox(
              height: 30.h,
            ),
            InkWell(
              onTap: () {
             //   Navigator.pushNamed(context, Routes.choseUserRoutes);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChoseUser()));
              },
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
            )
                  ],
                ),
          )),
    );
  }
}
