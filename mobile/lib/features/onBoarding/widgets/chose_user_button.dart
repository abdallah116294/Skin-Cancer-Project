import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/utils/app_color.dart';

class ChoseUserButton extends StatelessWidget {
  ChoseUserButton({
    super.key,
    required this.imagePathe,
    required this.user,
    required this.onTap,
    required this.isnetwork
  });
  final String imagePathe;
  final String user;
  VoidCallback onTap;
  bool isnetwork;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
     isnetwork?  Container(
          width: 200.w,
          height: 140.h,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:  DecorationImage(image:NetworkImage(imagePathe),)),
        ):Container(
          width: 140.w,
          height: 140.h,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:  DecorationImage(image:AssetImage(imagePathe))),
        ),
        InkWell(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: isnetwork? Container(
              width: 200.w,
              height: 50.h,
              decoration: BoxDecoration(
                  color: AppColor.buttonChoseuser,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  user,
                  style:TextStyle(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ):Container(
              width: 140.w,
              height: 50.h,
              decoration: BoxDecoration(
                  color: AppColor.buttonChoseuser,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  user,
                  style:TextStyle(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
