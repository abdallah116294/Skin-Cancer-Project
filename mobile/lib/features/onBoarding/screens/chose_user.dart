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
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: AppColor.choseColor,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text(
                  StringManager.welcomeMessage,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 26.sp),
                ),
              ),
              Text(
                StringManager.choseUser,
                style: TextStyle(
                    color: Colors.black,
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
          ),
        ),
      ),
    );
  }
}
