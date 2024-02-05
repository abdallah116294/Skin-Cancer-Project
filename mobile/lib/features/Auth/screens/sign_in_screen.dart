import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/features/Auth/widgets/custom_text_feild.dart';
import 'package:mobile/features/Auth/widgets/or_line_widget.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final emialController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Expanded(
                child: Container(
              width: 390.w,
              height: 685.h,
              decoration: BoxDecoration(
                  color: AppColor.singInContainerColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Image(
                  image: const AssetImage(AssetsManager.signIn),
                  width: 260.w,
                  height: 183.h,
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: CustomTextFormFiled(
                              controller: emialController,
                              onPresed: () {},
                              inputFiled: "Enter your email",
                              isObscureText: false,
                              validator: (String? valeue) {
                                if (valeue!.isEmpty) {
                                  return "pleas enter email";
                                }
                                return null;
                              },
                              prefixIcon: Icons.email,
                              textInputType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: CustomTextFormFiled(
                              controller: passwordController,
                              onPresed: () {},
                              inputFiled: "Enter your password",
                              isObscureText: true,
                              validator: (String? valeue) {
                                if (valeue!.isEmpty) {
                                  return "pleas enter password";
                                }
                                return null;
                              },
                              prefixIcon: Icons.lock,
                              textInputType: TextInputType.visiblePassword,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                "forget Password?",
                                style: TextStyle(
                                    color: AppColor.buttonColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomButton(
                              buttoncolor: AppColor.buttonColor,
                              width: 358.w,
                              height: 61.h,
                              buttonName: StringManager.signIn,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {}
                              },
                              textColor: Colors.white,
                              white: false),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                StringManager.donetHaveAccount,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                StringManager.signUp,
                                style: TextStyle(
                                    color: AppColor.signUptext,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                  SizedBox(height: 20.h,),
                    const OrLineWidget()
              ]),
            ))
          ],
        ),
      ),
    );
  }
}
