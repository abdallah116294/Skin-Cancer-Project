import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/text_styles.dart';

class InfoWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final String supTitle;
  final String? supTitle2;

  const InfoWidget(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.supTitle,
      this.supTitle2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpacing(20),
                Text(
                  title,
                  style: TextStyles.font22MoveW700,
                ),
                verticalSpacing(30),
                Image.asset(imagePath),
                verticalSpacing(20),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColor.buttonChoseuser,
                  ),
                  child: Text(
                      style: TextStyles.font17BlackW500.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    supTitle)
                          ),
                verticalSpacing(20),
                supTitle2 != null?
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColor.buttonChoseuser,
                  ),
                  child: Text(
                      style: TextStyles.font17BlackW500.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    supTitle2!
                  ),
                ):const SizedBox(),
                verticalSpacing(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
