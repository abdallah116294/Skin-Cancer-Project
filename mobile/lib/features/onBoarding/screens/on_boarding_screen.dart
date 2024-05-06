import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            Container(
               //width: 373.w,
              height: 415.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), 
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CustomPaint(child: Image.network("https://media.discordapp.net/attachments/1068427454131228793/1237127907634057287/D17E30AF-1939-4BA0-963E-3093397613F9.jpg?ex=663a84a5&is=66393325&hm=4afb837cd34e38b329097884d3cf5c92fe66171db6a6bcf11f4a134fc1c7e16c&=&format=webp&width=893&height=670")),
            ),
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
                buttonColor: AppColor.primaryColor,
                width: 358,
                height: 60,
                //gradient: LinearGradient(colors: AppColor.btnGradient),
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
