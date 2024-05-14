import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_styles.dart';

class DocClinicWidget extends StatelessWidget {
  final String  title ;
  final String  subtitle ;
  final IconData  icon;
  const DocClinicWidget({
    super.key, required this.title, required this.subtitle, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
                color: const Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(10.r)),
            child: Icon(
              icon,
              color: AppColor.singInContainerColor,
            )),
        horizontalSpacing(15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.font14BlackW600,
            ),
            verticalSpacing(5),
            Text(
              subtitle,
              style: TextStyles.font12BlackW400.copyWith(
                color: const Color(0xFF9EA5F0),
              ),
            )
          ],
        )
      ],
    );
  }
}
