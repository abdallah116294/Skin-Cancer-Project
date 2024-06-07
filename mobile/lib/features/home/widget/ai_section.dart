import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helper/exetentions.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/text_styles.dart';
import '../../../core/widgets/app_button.dart';

class AISection extends StatelessWidget {
  const AISection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 365.w,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColor.primaryColor,
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
                    style: TextStyles.font16BlackW500.copyWith(
                      color: Colors.white,
                    ),
                    "Test Your skin lesion \nwith AI"),
                verticalSpacing(5),
                Text(
                    style: TextStyles.font14BlackW300.copyWith(
                      color: Colors.white,
                    ),
                    "Get a first look with our machine Learning model"),
                verticalSpacing(5),
                AppButton(
                    borderRadius: 48.r,
                    buttonColor: Colors.white,
                    width: 110,
                    height: 40,
                    textOfButtonStyle: TextStyles.font14BlackW600.copyWith(
                      color: AppColor.primaryColor,
                    ),
                    buttonName: "Start Now",
                    onTap: () {
                      context.pushNamed(Routes.aIScanScreen);
                    },
                    textColor: AppColor.primaryColor,
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
                      "https://img.freepik.com/free-photo/doctor-from-future-concept_23-2151111130.jpg?t=st=1717706012~exp=1717709612~hmac=9d62f2b9e7a19b9d183a4325ffbd2bce9fc5c5667919c44df29216dac0b4f28a&w=360"
                      // "https://i.pinimg.com/564x/09/4f/16/094f164882a08da22b56b246a2f4c2ec.jpg"
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
