import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_button.dart';

import '../../config/routes/app_routes.dart';
import '../../core/utils/app_color.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Colors.white,
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(colors: AppColor.exploreBg)),
        ),
        Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/image/doc3.png")),
            Align(
                alignment: Alignment.centerRight,
                child: Image.asset("assets/image/doc1.png")),
            Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/image/doc4.png")),
            Align(
                alignment: Alignment.topRight,
                child: Image.asset("assets/image/doc2.png")),
            Text(
              "Find a Doctor !",
              style: TextStyles.font24PrimaryW700,
            ),
            Text(
              textAlign: TextAlign.center,
              "We Can Help You To find\n"
              "Your Doctor Easliy.",
              style: TextStyles.font18PrimaryW500.copyWith(
                  fontWeight: FontWeight.w400, color: const Color(0xFF7A84ED)),
            ),
            verticalSpacing(0),
            AppButton(
                buttonColor: AppColor.primaryColor,
                width: 200,
                height: 50,
                buttonName: "Get Started",
                onTap: () =>context.pushNamed(Routes.topDocScreen),
                textColor: Colors.white,
                white: true)
          ],
        ),
      ],
    ));
  }
}
