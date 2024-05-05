import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/features/Auth/widgets/custom_text_feild.dart';

class RestPasswordScreen extends StatelessWidget {
  final String otpCode;
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RestPasswordScreen(this.otpCode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpacing(200),
            Text(
              StringManager.restPassword,
              style: TextStyles.font24PrimaryW700,
            ),
            verticalSpacing(10),
            Text(
              StringManager.restpassword2,
              style: TextStyle(
                color: Colors.black.withOpacity(.5),
                fontSize: 15.sp,
              ),
            ),
            verticalSpacing(30),
            Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Code :",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          horizontalSpacing(20),
                          Text(
                            otpCode,
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp),
                          ),
                        ],
                      ),
                      verticalSpacing(30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Confirm new password",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      verticalSpacing(30),
                      CustomTextFormFiled(
                        controller: rePasswordController,
                        inputFiled: "Confirm new password",
                        isObscureText: true,
                        validator: (String? value) {
                          if (value!.isEmpty ||
                              rePasswordController.text !=
                                  passwordController.text) {
                            return "Passwords must be one";
                          }
                          return null;
                        },
                        prefixIcon: Icons.lock,
                        textInputType: TextInputType.visiblePassword,
                      ),
                      verticalSpacing(30),
                      CustomButton(
                          buttoncolor: AppColor.primaryColor,
                          width: 358.w,
                          height: 61.h,
                          buttonName: StringManager.restPassword,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              DailogAlertFun.showMyDialog(
                                  daliogContent: "Password Change",
                                  actionName: "Back to log in",
                                  context: context,
                                  onTap: () {
                                    context
                                        .pushNamed(Routes.singInScreenRoutes);
                                  });
                            }
                          },
                          textColor: Colors.white,
                          white: false)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
