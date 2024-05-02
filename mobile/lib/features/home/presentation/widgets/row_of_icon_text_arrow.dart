import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/spacer.dart';
import '../../../../core/utils/text_styels.dart';


class RowOfIconTextArrow extends StatelessWidget {
  final String? iconPath;
  final String text;
  final void Function()? onTap;

  const RowOfIconTextArrow({
    super.key,
    this.iconPath,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          children: [
            Image.asset(iconPath ?? "assets/image/roshita.png"),
            horizontalSpacing(20),
            Text(
              text,
              style: TextStyles.font12BlackW400,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Color(0xFFDA80D7),
            )
          ],
        ),
      ),
    );
  }
}
