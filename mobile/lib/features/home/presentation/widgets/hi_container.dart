import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/text_styels.dart';



class HiContainer extends StatelessWidget {
  const HiContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return             Container(
      height: 192.h,
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      color: const Color(0xFFD6D9F4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "hi Ahmed",
            style: TextStyles.font20GreyW700,
          ),
          Image.asset("assets/image/home_1.png")
        ],
      ),
    );
  }
}
