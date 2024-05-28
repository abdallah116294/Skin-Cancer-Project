import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helper/exetentions.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/utils/text_styles.dart';
import '../../../core/widgets/app_button.dart';

class AISection extends StatelessWidget {
  const AISection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 365.w,
      height: 190.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: const Color(0xFFC5CAFB),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 5.h, left: 22.w),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    maxLines: 2,
                    style: TextStyles.font16BlackW500,
                    "Test Your skin lesion \nwith AI"),
                verticalSpacing(5),
                Text(
                    style: TextStyles.font14BlackW300,
                    "Get a first look with our machine Learning model"),
                verticalSpacing(5),
                AppButton(
                    borderRadius: 8.r,
                    buttonColor: Colors.white,
                    width: 120,
                    height: 40,
                    textOfButtonStyle: TextStyles.font14BlackW600,
                    buttonName: "Start Now",
                    onTap: () {
                      context.pushNamed(Routes.aIScanScreen);
                    },
                    textColor: Colors.black,
                    white: false)
              ],
            ),
            horizontalSpacing(10),
            ClipOval(
              child: SizedBox(
                  width: 150.w,
                  height: 160.h,
                  child: Image.network(
                      fit: BoxFit.cover,
                      "https://i.pinimg.com/564x/09/4f/16/094f164882a08da22b56b246a2f4c2ec.jpg")),
            ),
          ],
        ),
      ),
    );
  }
}
