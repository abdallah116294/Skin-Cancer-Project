import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helper/exetentions.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/utils/text_styles.dart';
import '../../../core/widgets/app_button.dart';

class SkinCancerSection extends StatelessWidget {
  const SkinCancerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 365.w,
        height: 160.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: const Color(0xFFC5CAFB),
        ),
        child: Padding(
            padding: EdgeInsets.only(top: 5.h, left: 0.w),
            child: Row(
              children: [
                ClipOval(
                  child: SizedBox(
                      width: 150.w,
                      height: 160.h,
                      child: Image.network(
                          fit: BoxFit.cover,
                          "https://firebasestorage.googleapis.com/v0/b/skinyapp.appspot.com/o/ezgif-6-a16d81c0c0.gif?alt=media&token=970b3848-f0c1-4ba5-9f45-3e5ed33d4dac")),
                ),
                horizontalSpacing(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        maxLines: 2,
                        style: TextStyles.font16BlackW500,
                        "What is Skin Caner?"),
                    verticalSpacing(10),
                    Text(
                        style: TextStyles.font14BlackW300,
                        "All you need to know about the basics of skin cancer"),
                    verticalSpacing(10),
                    AppButton(
                        borderRadius: 8.r,
                        buttonColor: Colors.white,
                        width: 120,
                        height: 40,
                        textOfButtonStyle: TextStyles.font14BlackW600,
                        buttonName: "Learn More",
                        onTap: () {
                          context.pushNamed(
                              Routes.whatSkinCanerScreenRoutes);
                        },
                        textColor: Colors.black,
                        white: false)
                  ],
                ),
              ],
            )));
  }
}
