import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/home/widget/add_clinic_widget.dart';
import 'package:mobile/features/home/widget/row_of_icon_text_arrow.dart';
import 'package:mobile/features/home/widget/skin_cancer_section.dart';

import '../../config/routes/app_routes.dart';
import '../../core/utils/app_color.dart';
import 'widget/ai_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var doctor_role = CacheHelper.getData(key: 'doctor_role');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: 390.w,
                height: 130.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFD6D9F4),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 40.h, left: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          style: TextStyles.font24PrimaryW700
                              .copyWith(fontWeight: FontWeight.w600),
                          "welcome"),
                      Text(style: TextStyles.font20BlackW700, "Ahmed Khaled"),
                    ],
                  ),
                ),
              ),
              doctor_role!=null?verticalSpacing(20):const SizedBox(height: 0.0,),
              doctor_role!=null?const AddClinicWidget():const  SizedBox(height: 0,),
              verticalSpacing(20),
              const AISection(),
              verticalSpacing(20),
              const SkinCancerSection(),
              verticalSpacing(20),
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                            size: 44,
                            Icons.info_outline_rounded,
                            color: AppColor.primaryColor),
                        horizontalSpacing(10),
                        Text(
                          "Learning Center",
                          style: TextStyles.font15BlackW500,
                        )
                      ],
                    ),
                    RowOfIconTextArrow(
                      text: "Skin Cancer Facts and Statistics",
                      onTap: () {
                        context.pushNamed(Routes.factsAndStatisticScreen);
                      },
                    ),
                    RowOfIconTextArrow(
                      text: "Risk Factors",
                      onTap: () {
                        context.pushNamed(Routes.riskFactorsScreen);
                      },
                    ),
                    RowOfIconTextArrow(
                      text: "Prevention",
                      onTap: () {
                        context.pushNamed(Routes.preventionScreen);
                      },
                    ),
                    RowOfIconTextArrow(
                        text: "Early Detection",
                        iconPath: "assets/image/alarm.png",
                        onTap: () {
                          context.pushNamed(Routes.earlyDetectionScreen);
                        }),
                  ],
                ),
              ),
              verticalSpacing(20),
            ],
          ),
        ),
      ),
    );
  }
}
