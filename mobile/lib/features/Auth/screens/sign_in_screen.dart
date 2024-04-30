import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/features/Auth/cubit/auth_cubit.dart';
import 'package:mobile/features/Auth/widgets/custom_text_feild.dart';
import 'package:mobile/features/Auth/widgets/or_line_widget.dart';
import 'package:mobile/features/onBoarding/widgets/clipper.dart';
import 'package:mobile/injection_container.dart' as di;

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
        BlocProvider(
            create: (context) => di.sl<AuthCubit>(),
            child: BlocConsumer<AuthCubit, AuthState>(
              builder: (context, state) {
                return Column(
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
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                        textInputType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                     Padding(
                                       padding: const EdgeInsets.all(5.0),
                                       child: Align(alignment:Alignment.bottomLeft,child: BlocProvider.of<AuthCubit>(context).showErrorText()),
                                     ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                        textInputType:
                                            TextInputType.visiblePassword,
                                      ),
                                    ),
                                     Padding(
                                       padding: const EdgeInsets.all(5.0),
                                       child: Align(alignment:Alignment.bottomLeft,child: BlocProvider.of<AuthCubit>(context).showErrorText()),
                                     ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(Routes
                                              .forgetPasswordScreenRoutes);
                                        },
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
                                    state is LoginUserIsLoadingState
                                        ? const CireProgressIndecatorWidget()
                                        : CustomButton(
                                            buttoncolor: AppColor.buttonColor,
                                            width: 358.w,
                                            height: 61.h,
                                            buttonName: StringManager.signIn,
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                BlocProvider.of<AuthCubit>(
                                                        context)
                                                    .userlogin(
                                                        emialController.text,
                                                        passwordController
                                                            .text);
                                              }
                                            },
                                            textColor: Colors.white,
                                            white: false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          SizedBox(
                            height: 20.h,
                          ),
                          const OrLineWidget(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                AssetsManager.facbookLogo,
                                width: 32.w,
                                height: 32.h,
                              ),
                              SvgPicture.asset(
                                AssetsManager.googleLogo,
                                width: 32,
                                height: 32,
                              )
                            ],
                          )
                        ]),
                      ),
                    ))
                  ],
                );
              },
              listener: (context, state) {
                if (state is LoginUserIsLoadingState) {
                  log('loading');
                } else if (state is LoginUserIsSuccessSetate) {
                  DailogAlertFun.showMyDialog(
                      daliogContent: state.userModel.email,
                      actionName: "Go to Home",
                      context: context,
                      onTap: () {});
                } else if (state is LoginUserIsErrorState) {
                  log(state.error);
                }
              },
            ))
      ],
    ));
  }
}
