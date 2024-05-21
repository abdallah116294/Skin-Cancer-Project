import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/text_styles.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(
       child: Column(
         children: [
           verticalSpacing(20),
           Row(
             children: [
               const CircleAvatar(
                 radius: 36,
                 backgroundImage: AssetImage(
                   "assets/image/doc.jpg"
                 ),
               ),
               horizontalSpacing(10),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Ahmed Khaled ",
                   style: TextStyles.font20BlackW700,),
                   Text("5:55 am ",
                   style: TextStyles.font15BlackW500,),
                 ],
               )
             ],
           )
         ],
       ),
     ),
   );
  }
}