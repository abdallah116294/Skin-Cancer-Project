import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/features/Auth/widgets/custom_text_feild.dart';
import 'package:mobile/features/onBoarding/widgets/clipper.dart';

class RestPasswordScreen extends StatelessWidget {
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();
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
          Column(
            children: [
              SizedBox(
                height: 200.h,
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                height: 685.h,
                decoration: BoxDecoration(
                    color: AppColor.singInContainerColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        StringManager.restPassword,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        StringManager.restpassword2,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "New Password",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: CustomTextFormFiled(
                                    controller: passwordController,
                                    onPresed: () {},
                                    inputFiled: "Enter new Password",
                                    isObscureText: true,
                                    validator: (String? valeue) {
                                      if (valeue!.isEmpty) {
                                        return "pleas enter password";
                                      }
                                      return null;
                                    },
                                    prefixIcon: Icons.lock,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Confirm new Password",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: CustomTextFormFiled(
                                    controller: repasswordController,
                                    onPresed: () {},
                                    inputFiled: "Cofirm new Password",
                                    isObscureText: true,
                                    validator: (String? valeue) {
                                      if (valeue!.isEmpty ||
                                          repasswordController.text !=
                                              passwordController.text) {
                                        return "passwords must be one";
                                      }
                                      return null;
                                    },
                                    prefixIcon: Icons.lock,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                CustomButton(
                                    buttoncolor: AppColor.buttonColor,
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
                                              Navigator.of(context).pushNamed(
                                                  Routes.singInScreenRoutes);
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
              ))
            ],
          )
        ],
      ),
    );
  }
}
