import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:video_player/video_player.dart';

class DailogAlertFun{
  static Future<void> showMyDialog({required  String daliogContent ,required  String  actionName,required BuildContext context,required VoidCallback onTap}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Column(
              children: [
                  CircleAvatar(
                    maxRadius: 50,
                    backgroundColor:const   Color(0xffEAEAEA),
                    child: SvgPicture.asset(AssetsManager.done,width: 30.w,height: 30.h,),
                  ),
                   SizedBox(height: 16.h,),
                   Text(daliogContent,style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
                 SizedBox(height: 30.h,),
                 CustomButton(buttonName: actionName,buttoncolor: AppColor.buttonColor,height: 52.h,width: 166,white: false,onTap:onTap,textColor: Colors.white,)  
            
            ]
            ),
            ],
          ),
        ),
      );
    },
  );
}
}
class DailogAlertFun2{
  static Future<void> showMyDialog({required BuildContext context,required VideoPlayerController controller }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Scaffold(
            body: Center(
            child: controller.value.isInitialized
            ? AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
                  )
            : Container(),
                  ),
          )
        );
      },
    );
  }
}