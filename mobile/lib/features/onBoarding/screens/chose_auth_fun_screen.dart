import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/features/Auth/presentation/screens/signup_screen.dart';

import '../../Auth/presentation/screens/sign_in_screen.dart';

class ChoseAuthFunScreen extends StatefulWidget {
  ChoseAuthFunScreen({super.key, required this.num});
  var num;
  @override
  State<ChoseAuthFunScreen> createState() => _ChoseAuthFunScreenState();
}

class _ChoseAuthFunScreenState extends State<ChoseAuthFunScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text("Wlecome,",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp))),
              SizedBox(
                height: 25.h,
              ),
              Center(
                child: Image(
                    image: const AssetImage(AssetsManager.chose_auth_fun),
                    width: 330.w,
                    height: 230.h),
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                StringManager.authfuntext,
                style: TextStyle(
                    color: AppColor.authfuntext,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomButton(
                  buttoncolor: AppColor.buttonColor,
                  width: 317.w,
                  height: 61.h,
                  buttonName: StringManager.signIn,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.singInScreenRoutes,arguments:widget.num );
                  },
                  textColor: Colors.white,
                  white: false),
              SizedBox(
                height: 25.h,
              ),
              CustomButton(
                buttoncolor: Colors.white,
                width: 317.w,
                height: 61.h,
                buttonName: StringManager.signUp,
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.signUpScreenRoutes,arguments:widget.num );
                },
                textColor: AppColor.buttonColor,
                white: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
