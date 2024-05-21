import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/features/explore/widgets/rating_widget.dart';

class DailogAlertFun {
  static Future<void> showMyDialog(
      {required String daliogContent,
      required String actionName,
      required BuildContext context,
      required VoidCallback onTap}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(children: [
                  CircleAvatar(
                    maxRadius: 50,
                    backgroundColor: const Color(0xffEAEAEA),
                    child: SvgPicture.asset(
                      AssetsManager.done,
                      width: 30.w,
                      height: 30.h,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    daliogContent,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButton(
                    buttonName: actionName,
                    buttoncolor: AppColor.primaryColor,
                    height: 52.h,
                    width: 166,
                    white: false,
                    onTap: onTap,
                    textColor: Colors.white,
                  )
                ]),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showRationgDialog(
      {required double initialRating,
      required Function(double) onRatingChanged,
      required String actionName,
      required BuildContext context,
      required VoidCallback onTap}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(children: [
                  CircleAvatar(
                    maxRadius: 50,
                    backgroundColor: const Color(0xffEAEAEA),
                    child: SvgPicture.asset(
                      AssetsManager.done,
                      width: 30.w,
                      height: 30.h,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  RatingStarsWidget(
                    initialRating: initialRating / 2,
                    onRatingChanged: onRatingChanged,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButton(
                    buttonName: actionName,
                    buttoncolor: AppColor.primaryColor,
                    height: 52.h,
                    width: 166,
                    white: false,
                    onTap: onTap,
                    textColor: Colors.white,
                  )
                ]),
              ],
            ),
          ),
        );
      },
    );
  }
}
