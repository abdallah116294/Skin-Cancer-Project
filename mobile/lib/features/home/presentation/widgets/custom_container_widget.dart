import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../onBoarding/widgets/clipper.dart';

class CustomContainerWidget extends StatelessWidget {
  CustomContainerWidget(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.imagePathe,
      required this.actionButtonName,
      required this.ontap,
      required this.isnetwork})
      : super(key: key);
  final String text1;
  final String text2;
  final String imagePathe;

  // final Image image;
  final String actionButtonName;
  final VoidCallback ontap;
  final bool isnetwork;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 3369.w,
        height: 209.h,
        padding: EdgeInsets.only(top: 20, left: 20, bottom: 10),
        decoration: BoxDecoration(
          color: AppColor.containerColor2,
          borderRadius: BorderRadius.circular(20),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            children: [
              Text(text1,
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10.h,
              ),
              Text(
                text2,
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
              ),
              const Spacer(),
              CustomButton(
                  buttoncolor: Colors.white,
                  width: 120.w,
                  height: 40.h,
                  buttonName: actionButtonName,
                  onTap: ontap,
                  textColor: Colors.black,
                  white: true),
            ],
          ),
          isnetwork
              ? Image.asset(
                  imagePathe,
                  width: 149.w,
                  height: 156.h,
                )
              : CircleAvatar(
                radius: 80,
                backgroundImage:NetworkImage(imagePathe) ,
                // child: Image.network(imagePathe,
                //     width: 180.w, height: 180.h),
              ),

          //  Image(image:image );
        ]),
      ),
    );
  }
}
