import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/features/onBoarding/widgets/clipper.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:pinput/pinput.dart';

class OTPCodeScreen extends StatelessWidget {
  OTPCodeScreen({super.key});
  final otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              child: ClipPath(
                clipper: Ellips7(),
                child: Container(
                  width: 170.h,
                  height: 170.h,
                  color: const Color(0xffC5CAFB),
                ),
              )),
          Positioned(
              top: 0,
              right: 0,
              child: ClipPath(
                clipper: Ellips7(),
                child: Container(
                  width: 150.h,
                  height: 150.h,
                  color: const Color(0xff5863CB).withOpacity(0.5),
                ),
              )),
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
                icon: const Icon(Icons.arrow_back_ios),
                color: const Color(0xff6069C0),
              ),
              elevation: 0, // remove app bar shadow
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Form(
              key: _formKey,
              child: Column(
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
                      color: Colors.black,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Pinput(
                    length: 6,
                    errorPinTheme: PinTheme(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(7)),
                        width: 50.w,
                        height: 50.h,
                        textStyle:
                            TextStyle(color: Colors.red, fontSize: 18.sp)),
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Row(
                      children: [
                        Text(
                          "didn’t receive a code ?",
                          style:
                              TextStyle(color: Colors.black, fontSize: 18.sp),
                        ),
                        Text(
                          "Resend",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButton(
                      buttoncolor: AppColor.buttonColor,
                      width: 358.w,
                      height: 61.h,
                      buttonName: StringManager.verify,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context)
                              .pushNamed(Routes.restPasswordScreenRoutes);
                        }
                      },
                      textColor: Colors.white,
                      white: false)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
