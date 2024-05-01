import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/Auth/widgets/double_text.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/custom_dailog.dart';
import '../../onBoarding/widgets/clipper.dart';
import '../widgets/custom_text_feild.dart';


class SignupScreen extends StatefulWidget {
   const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  color: const Color(0xff6069C0),
                ),
                elevation: 0, // remove app bar shadow
              ),
            ),
            Column(
              children: [
                verticalSpacing(200),
                Container(
                  width: double.infinity,
                  height: 685.h,
                  decoration: BoxDecoration(
                      color: AppColor.singInContainerColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r))),
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(children: [
                        Text(
                          'Register with us',
                          style: TextStyles.font20BlackW700,
                        ),
                        Text(
                          'Your information is safe with us',
                          style: TextStyles.font15BlackW400,
                        ),
                        verticalSpacing(10),
                        Form(
                            key: _formKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: CustomTextFormFiled(
                                      controller: nameController,
                                      onPresed: () {},
                                      inputFiled: "Enter your full  name",
                                      isObscureText: false,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "pleas enter email";
                                        }
                                        return null;
                                      },
                                      textInputType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  verticalSpacing(20),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: CustomTextFormFiled(
                                      controller: emailController,
                                      onPresed: () {},
                                      inputFiled: "Enter your email",
                                      isObscureText: false,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "pleas enter email";
                                        }
                                        return null;
                                      },
                                      textInputType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  verticalSpacing(20),
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
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "pleas enter password";
                                        }
                                        return null;
                                      },
                                      textInputType:
                                          TextInputType.visiblePassword,
                                    ),
                                  ),
                                  verticalSpacing(20),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: CustomTextFormFiled(
                                      controller: confirmPasswordController,
                                      onPresed: () {},
                                      inputFiled: "Confirm your password",
                                      isObscureText: true,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "pleas enter password";
                                        }
                                        return null;
                                      },
                                      textInputType:
                                          TextInputType.visiblePassword,
                                    ),
                                  ),
                                  verticalSpacing(30),
                                  AppButton(
                                    buttonColor: AppColor.buttonColor,
                                    width: 358.w,
                                    height: 61.h,
                                    buttonName: StringManager.signUp,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        DailogAlertFun.showMyDialog(
                                            daliogContent: "Success",
                                            actionName: "Login",
                                            context: context,
                                            onTap: () {
                                              context.pushNamed(
                                                  Routes.singInScreenRoutes);
                                            });
                                      }
                                    },
                                    textColor: Colors.white,
                                    white: false,
                                  ),
                                  verticalSpacing(20),
                                  DoubleText(
                                    firstText: StringManager.alreadyHaveAccount,
                                    secondText: StringManager.signIn,
                                    onTap: () {
                                      context
                                          .pushNamed(Routes.singInScreenRoutes);
                                    },
                                  )
                                ],
                              ),
                            )),
                      ]),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}