import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/utils/app_color.dart';

class CustomButton extends StatelessWidget {
   CustomButton(
      {super.key,
      required this.buttoncolor,
      required this.width,
      required this.height,
      required this.buttonName,
      required this.onTap,
      required this.textColor,
      required this.white
      });
  final Color buttoncolor;
  final Color textColor;
  final String buttonName;
  final double width, height;
  VoidCallback onTap;
  bool white;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: white?AppColor.primaryColor:Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
          color: buttoncolor,
        ),
        child: Center(
          child: Text(buttonName,
              style: TextStyle(
                  color:textColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
