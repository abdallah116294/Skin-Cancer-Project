import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/features/Auth/cubit/auth_cubit.dart';
import 'package:mobile/features/Auth/widgets/custom_text_feild.dart';
import 'package:mobile/injection_container.dart' as di;

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BlocProvider(
              create: (context) => di.sl<AuthCubit>(),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is ForgetPasswordIsLoadingState) {
                    log('loading');
                  } else if (state is ForgetPaswordIsSuccessState) {
             
                  } else if (state is ForgetPasswordIsErrorState) {
                           DailogAlertFun.showMyDialog(
                        daliogContent: state.error.toString(),
                        actionName: 'reset password',
                        context: context,
                        onTap: () {
                          context
                              .pushReplacementNamed(Routes.oTPCodeScreenRoutes);
                        });
                    log("Error "+state.error.toString());
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Lottie.asset(
                                "assets/animation/forget_animation.json"),
                            Text(
                              StringManager.forgetPassword,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            verticalSpacing(20),
                            Text(
                              StringManager.forgetPasssword2,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                            verticalSpacing(20),
                            CustomTextFormFiled(
                              controller: emailController,
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
                            verticalSpacing(20),
                            CustomButton(
                                buttoncolor: AppColor.primaryColor,
                                width: 358.w,
                                height: 61.h,
                                buttonName: StringManager.sendCode,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<AuthCubit>()
                                        .forgetPasssword(emailController.text);
                                  }
                                },
                                textColor: Colors.white,
                                white: false)
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
