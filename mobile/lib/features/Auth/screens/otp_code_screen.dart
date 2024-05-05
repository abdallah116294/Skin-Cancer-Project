import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/features/onBoarding/widgets/clipper.dart';
import 'package:pinput/pinput.dart';

class OTPCodeScreen extends StatelessWidget {
  OTPCodeScreen({super.key});

  final otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringManager.checkemail,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                StringManager.testmail,
                style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                  fontSize: 15.sp,
                ),
              ),
              verticalSpacing(20),
              Pinput(
                length: 6,
                errorPinTheme: PinTheme(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(7)),
                    width: 50.w,
                    height: 50.h,
                    textStyle: TextStyle(color: Colors.red, fontSize: 18.sp)),
                submittedPinTheme: PinTheme(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(7)),
                  width: 50.w,
                  height: 50.h,
                  textStyle: TextStyle(
                      color: const Color(0xff5863CB), fontSize: 18.sp),
                ),
                defaultPinTheme: PinTheme(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(7)),
                    width: 50.w,
                    height: 50.h,
                    textStyle: TextStyle(
                        color: const Color(0xff5863CB), fontSize: 18.sp)),
                controller: otpController,
                validator: (value) {
                  if (value != otpController.text) {
                    return "pleas check otp again";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              verticalSpacing(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn’t receive a code ? ",
                    style: TextStyle(
                      color: Colors.black.withOpacity(.5),
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    "Resend",
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomButton(
                  buttoncolor: AppColor.primaryColor,
                  width: 358.w,
                  height: 61.h,
                  buttonName: StringManager.verify,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.pushNamed(Routes.restPasswordScreenRoutes,
                          arguments: otpController.text);
                    }
                  },
                  textColor: Colors.white,
                  white: false)
            ],
          ),
        ),
      ),
    );
  }
}
