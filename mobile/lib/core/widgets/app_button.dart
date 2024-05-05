import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/utils/app_color.dart';

import '../utils/text_styles.dart';

class AppButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String buttonName;
  final double width, height;
  final double? borderRadius;
  final TextStyle? textOfButtonStyle;
  VoidCallback onTap;
  bool white;
  final Gradient? gradient;

  AppButton({
    super.key,
    required this.buttonColor,
    required this.width,
    required this.height,
    required this.buttonName,
    required this.onTap,
    required this.textColor,
    required this.white,
    this.borderRadius,
    this.textOfButtonStyle, this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          gradient: gradient,
          border: Border.all(
            color: white ? AppColor.primaryColor : Colors.white,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            buttonName,
            style: textOfButtonStyle ?? TextStyles.font20whiteW700,
          ),
        ),
      ),
    );
  }
}