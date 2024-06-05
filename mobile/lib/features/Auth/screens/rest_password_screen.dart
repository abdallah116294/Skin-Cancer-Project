import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/core/widgets/validatort.dart';
import 'package:mobile/features/Auth/cubit/auth_cubit.dart';
import 'package:mobile/features/Auth/widgets/custom_text_feild.dart';
import 'package:mobile/injection_container.dart' as di;

import '../../../core/cach_helper/cach_helper.dart';

class RestPasswordScreen extends StatefulWidget {
  final String otpCode;

  const RestPasswordScreen(this.otpCode, {super.key});

  @override
  State<RestPasswordScreen> createState() => _RestPasswordScreenState();
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  final passwordController = TextEditingController();

  final rePasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var email = CacheHelper.getData(key: 'email');
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
            BlocProvider(
              create: (context) => di.sl<AuthCubit>(),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is ResetPasswordIsLoadingState) {
                    log('loading');
                  }
                  if (state is ResetPasswordIsSuccessState) {
                    DailogAlertFun.showMyDialog(
                        daliogContent: state.message.toString(),
                        actionName: 'Back Login',
                        context: context,
                        onTap: () {});
                  } else if (state is RegisterUserIsErrorState) {
                    DailogAlertFun.showMyDialog(
                        daliogContent: state.error,
                        actionName: "Back to log in",
                        context: context,
                        onTap: () {
                          context.pushNamed(Routes.singInScreenRoutes,
                              arguments: {"role2": "Doctor"});
                        });
                  }
                },
                builder: (context, state) {
                  return Form(
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
                                  widget.otpCode,
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
                                MyValidators.passwordValidator(value);
                               
                              },
                              prefixIcon: Icons.lock,
                              textInputType: TextInputType.visiblePassword,
                            ),
                            verticalSpacing(30),
                            state is ResetPasswordIsLoadingState
                                ? const CireProgressIndecatorWidget()
                                : CustomButton(
                                    buttoncolor: AppColor.primaryColor,
                                    width: 358.w,
                                    height: 61.h,
                                    buttonName: StringManager.restPassword,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthCubit>(context)
                                            .resetPassword(
                                          code: widget.otpCode,
                                          email: email,
                                          newPassword:
                                              rePasswordController.text,
                                        )
                                            .then((value) {
                                          context.pushReplacementNamed(
                                              Routes.singInScreenRoutes,
                                              arguments: {"role2": "Doctor"});
                                        });
                                      }
                                    },
                                    textColor: Colors.white,
                                    white: false)
                          ],
                        ),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
