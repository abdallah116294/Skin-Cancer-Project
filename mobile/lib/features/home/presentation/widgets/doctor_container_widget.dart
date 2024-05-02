import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/assets_path.dart';

class DoctorContainerWidget  extends StatelessWidget {
  const DoctorContainerWidget ({Key? key,required this.image,required this.isnetwork,required this.name,required this.email,required this.ontap}) : super(key: key);
 final String name;
 final String email;
 final VoidCallback ontap;
 final bool isnetwork;
 final String image;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 310.w,
        height: 90,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5.0,
                  spreadRadius: 0.0
              )
            ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          isnetwork?  CircleAvatar(radius:60,backgroundImage: NetworkImage(image),): const CircleAvatar(radius:60,backgroundImage: AssetImage(AssetsManager.doctor),),
            Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dr.$name",style: TextStyle(color:AppColor.doctorTextColor,fontSize: 14.sp ,fontWeight: FontWeight.bold),),
                Text(email.toString(),style: TextStyle(color:AppColor.doctorTextColor,fontSize: 13.sp ,)),
                Row(
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("⭐⭐⭐⭐",style: TextStyle(color: AppColor.starColor),),
                    SizedBox(width: 80.w,),
                    IconButton(onPressed: ontap,icon: Icon(Icons.arrow_forward,color:AppColor.starColor,),),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
