import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/spacer.dart';
import '../../../../core/utils/text_styels.dart';


class LearningCenter extends StatelessWidget {
  const LearningCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: Color(0xFFDA80D7),
            size: 35,
          ),
          horizontalSpacing(10),
          Text(
            "Learning Center",
            style: TextStyles.font15BlackW500,
          )
        ],
      ),
    );
  }
}
