import 'dart:developer';

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
import '../../onBoarding/widgets/clipper.dart';
import '../widgets/custom_text_feild.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/injection_container.dart' as di;
import '../cubit/auth_cubit.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumController = TextEditingController();
  final passwordController = TextEditingController();
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
            BlocProvider(
              create: (BuildContext context) => di.sl<AuthCubit>(),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is RegisterUserIsLoadingState) {
                    log("Loading state ");
                  } else if (state is RegisterUserIsSuccessSetate) {
                    log(state.message.toString());
                  } else if (state is RegisterUserIsErrorState) {
                    log(state.error);
                  }
                },
                builder: (context, state) {
                  return Column(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: CustomTextFormFiled(
                                            controller: nameController,
                                            onPresed: () {},
                                            inputFiled: "Enter your full  name",
                                            isObscureText: false,
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return "Please enter name";
                                              }
                                              return null;
                                            },
                                            textInputType:
                                                TextInputType.emailAddress,
                                          ),
                                        ),
                                        verticalSpacing(20),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: CustomTextFormFiled(
                                            controller: emailController,
                                            onPresed: () {},
                                            inputFiled: "Enter your email",
                                            isObscureText: false,
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return "Pleas enter email";
                                              }
                                              return null;
                                            },
                                            textInputType:
                                                TextInputType.emailAddress,
                                          ),
                                        ),
                                        verticalSpacing(20),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: CustomTextFormFiled(
                                            controller: phoneNumController,
                                            onPresed: () {},
                                            inputFiled:
                                                "Enter your phone number",
                                            isObscureText: false,
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return "Please enter phone number";
                                              }
                                              return null;
                                            },
                                            textInputType: TextInputType.number,
                                          ),
                                        ),
                                        verticalSpacing(20),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: CustomTextFormFiled(
                                            controller: passwordController,
                                            onPresed: () {},
                                            inputFiled: "Enter your password",
                                            isObscureText: true,
                                            validator: (String? value) {
                                              String check =
                                                  passwordController.text;
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
                                        ),
                                        verticalSpacing(30),
                                        AppButton(
                                          buttonColor: AppColor.buttonColor,
                                          width: 358.w,
                                          height: 61.h,
                                          buttonName: StringManager.signUp,
                                          onTap: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              log(nameController.text
                                                  .split(" ")[0]);
                                              log(nameController.text
                                                  .split(" ")[1]);
                                              log(emailController.text
                                                  .split("@")[0]);
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
                                                  );
                                            }
                                          },
                                          textColor: Colors.white,
                                          white: false,
                                        ),
                                        verticalSpacing(20),
                                        DoubleText(
                                          firstText:
                                              StringManager.alreadyHaveAccount,
                                          secondText: StringManager.signIn,
                                          onTap: () {
                                            context.pushNamed(
                                                Routes.singInScreenRoutes);
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
