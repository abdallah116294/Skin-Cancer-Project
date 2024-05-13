import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/Auth/widgets/double_text.dart';
import 'package:mobile/features/Auth/widgets/terms_and_conditions.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../core/utils/text_styles.dart';
import '../../../core/widgets/circle_progress_widget.dart';
import '../../../core/widgets/custom_dailog.dart';
import '../widgets/custom_text_feild.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/injection_container.dart' as di;
import '../cubit/auth_cubit.dart';

class SignupScreen extends StatefulWidget {
  final Map<String, String> role;

  const SignupScreen({super.key, required this.role});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocProvider(
              create: (BuildContext context) => di.sl<AuthCubit>(),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is RegisterUserIsLoadingState) {
                    log("Loading state ");
                  } else if (state is RegisterUserIsSuccessSetate) {
                    log(state.message.toString());
                  } else if (state is RegisterUserIsErrorState) {
                    DailogAlertFun.showMyDialog(
                        daliogContent: state.error.toString(),
                        actionName: "Go back",
                        context: context,
                        onTap: () {});
                    log(state.error);
                  } else if (state is AddRoleSuccesState) {
                    if (widget.role.containsKey('role1')) {
                      DailogAlertFun.showMyDialog(
                          daliogContent: "Please check your email",
                          actionName: "Confirm email",
                          context: context,
                          onTap: () {
                            context.pushNamed(Routes.singInScreenRoutes,
                                arguments: widget.role);
                          });
                    } else if (widget.role.containsKey('role2')) {
                      DailogAlertFun.showMyDialog(
                          daliogContent: "Please Doctor check your email",
                          actionName: "Go Home",
                          context: context,
                          onTap: () {
                             context.pushNamed(Routes.singInScreenRoutes,
                                arguments: widget.role);
                          });
                    }
                    log(state.respons.userName);
                  } else if (state is AddRoleErrorState) {
                    log(state.error);
                  }
                },
                builder: (context, state) {
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        child: Column(children: [
                          verticalSpacing(30),
                          Text(
                            'Create Account',
                            style: TextStyles.font24PrimaryW700,
                          ),
                          verticalSpacing(10),
                          verticalSpacing(20),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomTextFormFiled(
                                    controller: nameController,
                                    inputFiled: "Enter your full  name",
                                    isObscureText: false,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Please enter name";
                                      }
                                      return null;
                                    },
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                  verticalSpacing(20),
                                  CustomTextFormFiled(
                                    controller: emailController,
                                    inputFiled: "Enter your email",
                                    isObscureText: false,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Pleas enter email";
                                      }
                                      return null;
                                    },
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                  verticalSpacing(3),
                                  verticalSpacing(17),
                                  CustomTextFormFiled(
                                    controller: phoneNumController,
                                    inputFiled: "Enter your phone number",
                                    isObscureText: false,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Please enter phone number";
                                      }
                                      return null;
                                    },
                                    textInputType: TextInputType.number,
                                  ),
                                  verticalSpacing(20),
                                  CustomTextFormFiled(
                                    controller: passwordController,
                                    inputFiled: "Enter your password",
                                    isObscureText: isObscureText,
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
                                    validator: (String? value) {
                                      String check = passwordController.text;
                                      // List<String>valid=check.split();

                                      if (check.isEmpty) {
                                        return "Please enter your password";
                                      } else {
                                        if (value!.length < 8) {
                                          return "Please enter at least 8 characters";
                                        }
                                      }
                                    },
                                    textInputType:
                                        TextInputType.visiblePassword,
                                  ),
                                  verticalSpacing(30),
                                  state is RegisterUserIsLoadingState
                                      ? const CireProgressIndecatorWidget()
                                      : AppButton(
                                          buttonColor: AppColor.primaryColor,
                                          width: 358.w,
                                          height: 61.h,
                                          buttonName: StringManager.signUp,
                                          onTap: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<AuthCubit>()
                                                  .userRegister(
                                                    firstname: nameController
                                                        .text
                                                        .split(" ")[0],
                                                    lastname: nameController
                                                        .text
                                                        .split(" ")[1],
                                                    phoneNumber:
                                                        phoneNumController.text,
                                                    email: emailController.text,
                                                    userName: emailController
                                                        .text
                                                        .split("@")[0],
                                                    password:
                                                        passwordController.text,
                                                  )
                                                  .then((value) {
                                                if (widget.role
                                                    .containsKey("role1")) {
                                                } else if (widget.role
                                                    .containsKey("role2")) {
                                                  context
                                                      .read<AuthCubit>()
                                                      .addRole(
                                                          "Doctor",
                                                          emailController.text
                                                              .split("@")[0]);
                                                }
                                              });
                                            }
                                          },
                                          textColor: Colors.white,
                                          white: false,
                                        ),
                                ],
                              )),
                          verticalSpacing(20),
                          DoubleText(
                            firstText: StringManager.alreadyHaveAccount,
                            secondText: StringManager.signIn,
                            onTap: () {
                              context.pushNamed(Routes.singInScreenRoutes);
                            },
                          ),
                          verticalSpacing(20),
                          const TermsAndConditions(),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
