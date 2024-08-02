import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/text_styles.dart';

class ProfileWidget extends StatelessWidget {
  //final void Function()? onTap;
  final String title;
  final String iconPath;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const ProfileWidget(
      {super.key,
      this.onTap,
      required this.iconPath,
      required this.title,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: backgroundColor,
              ),
              child: Center(
                child: SvgPicture.asset(iconPath),
              ),
            ),
            horizontalSpacing(10),
            Text(
              title,
              style: TextStyles.font14BlackW600,
            )
          ],
        ),
      ),
    );
  }
}
