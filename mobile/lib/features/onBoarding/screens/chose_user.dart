import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/features/onBoarding/widgets/chose_user_button.dart';

class ChoseUser extends StatefulWidget {
  const ChoseUser({super.key});

  @override
  State<ChoseUser> createState() => _ChoseUserState();
}

class _ChoseUserState extends State<ChoseUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: AppColor.choseColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
              ),
        ),
          Positioned(
              top: 22,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent, 
                   leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),color: const Color(0xff6069C0),),
                elevation: 0, // remove app bar shadow
              ),
            ),
        Positioned(
          top: 90,
          left: 0,
              right: 0,
          child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Text(
              StringManager.welcomeMessage,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 26.sp),
            ),
          ),
          Text(
            StringManager.choseUser,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: ChoseUserButton(
              imagePathe: AssetsManager.patient_user,
              user: StringManager.patient,
              onTap: () {
                Navigator.pushNamed(
                    context, Routes.choseAuthFunScreenRoutes);
              },
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ChoseUserButton(
              imagePathe: AssetsManager.doctor_user,
              user: StringManager.doctor,
              onTap: () {
                Navigator.pushNamed(
                    context, Routes.choseAuthFunScreenRoutes);
              },
            ),
          ),
        ],
      ),)
      ],),
    );
  }
}
