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
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/features/Auth/cubit/auth_cubit.dart';
import 'package:mobile/features/Auth/widgets/custom_text_feild.dart';
import 'package:mobile/features/Auth/widgets/double_text.dart';
import 'package:mobile/injection_container.dart' as di;

import '../../../core/utils/text_styles.dart';
import '../widgets/terms_and_conditions.dart';

class SingInScreen extends StatefulWidget {
  final Map<String, String> roles;

  const SingInScreen({super.key, required this.roles});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => di.sl<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginUserIsLoadingState) {
              log('loading');
            } else if (state is LoginUserIsSuccessSetate) {
              DailogAlertFun.showMyDialog(
                  daliogContent: state.userModel.roles[1],
                  actionName: "Go to Home",
                  context: context,
                  onTap: () {});
            } else if (state is LoginUserIsErrorState) {
              log(state.error);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpacing(30),
                      Lottie.asset("assets/animation/login_animation.json"),
                      verticalSpacing(30),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormFiled(
                              controller: emailController,
                              inputFiled: "Enter your email",
                              isObscureText: false,
                              validator: (String? valeue) {
                                if (valeue!.isEmpty) {
                                  return "Please enter email";
                                }
                                return null;
                              },
                              prefixIcon: Icons.email,
                              textInputType: TextInputType.emailAddress,
                            ),
                            verticalSpacing(10),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: BlocProvider.of<AuthCubit>(context)
                                    .showErrorText()),
                            verticalSpacing(10),
                            CustomTextFormFiled(
                              controller: passwordController,
                              inputFiled: "Enter your password",
                              isObscureText: isObscureText,
                              validator: (String? valeue) {
                                if (valeue!.isEmpty) {
                                  return "Please enter password";
                                }
                                return null;
                              },
                              prefixIcon: Icons.lock,
                              textInputType: TextInputType.visiblePassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    setState(() {
                                      isObscureText = !isObscureText;
                                    });
                                  });
                                },
                                icon: Icon(isObscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            verticalSpacing(10),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: BlocProvider.of<AuthCubit>(context)
                                    .showErrorText()),
                            verticalSpacing(10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  context.pushNamed(
                                      Routes.forgetPasswordScreenRoutes);
                                },
                                child: Text(
                                  "Forget Password?",
                                  style: TextStyles.font15BlackW500.copyWith(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            verticalSpacing(10),
                            state is LoginUserIsLoadingState
                                ? const CireProgressIndecatorWidget()
                                : CustomButton(
                                    buttoncolor: AppColor.primaryColor,
                                    width: 358.w,
                                    height: 61.h,
                                    buttonName: StringManager.signIn,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthCubit>(context)
                                            .userlogin(emailController.text,
                                                passwordController.text);
                                      }
                                    },
                                    textColor: Colors.white,
                                    white: false),
                          ],
                        ),
                      ),
                      verticalSpacing(20),
                      DoubleText(
                          onTap: () => context.pushNamed(
                              Routes.signUpScreenRoutes,
                              arguments: widget.roles),
                          firstText: StringManager.donetHaveAccount,
                          secondText: StringManager.signUp),
                      verticalSpacing(20),
                      const TermsAndConditions(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
