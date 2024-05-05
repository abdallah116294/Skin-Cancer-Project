import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/onBoarding/widgets/custom_paint.dart';

import '../../../core/utils/text_styles.dart';

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
              style: TextStyles.font20BlackW700,
            ),
            verticalSpacing(20),
            Text(
              StringManager.onBoarding2,
              style: TextStyles.font14BlackW600,
            ),
            verticalSpacing(30),
            AppButton(
                buttonColor: Colors.white,
                width: 358,
                height: 60,
                gradient: LinearGradient(colors: AppColor.btnGradient),
                buttonName: StringManager.getStarted,
                onTap: () => context.pushNamed(Routes.choseUserRoutes),
                textColor: Colors.white,
                white: false),

          ],
        ),
      )),
    );
  }
}
