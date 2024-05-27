import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/Auth/cubit/auth_cubit.dart';
import 'package:mobile/features/clinic/cubit/clinic_cubit.dart';
import 'package:mobile/features/home/widget/add_clinic_widget.dart';
import 'package:mobile/features/home/widget/row_of_icon_text_arrow.dart';
import 'package:mobile/features/home/widget/skin_cancer_section.dart';

import '../../config/routes/app_routes.dart';
import '../../core/utils/app_color.dart';
import 'widget/ai_section.dart';
import 'package:mobile/injection_container.dart' as di;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // log('home token' + getToken());
    super.build(context);
    var doctor_role = CacheHelper.getData(key: 'doctor_role');
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String docId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: 390.w,
                height: 130.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFD6D9F4),
                ),
                child: doctor_role != null
                    ? BlocProvider(
                        create: (context) =>
                            di.sl<AuthCubit>()..getDoctorDetials(docId),
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is GetDoctorDetialsSuccess) {
                              return Padding(
                                padding: EdgeInsets.only(top: 40.h, left: 30.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        style: TextStyles.font24PrimaryW700
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                        "welcome"),
                                    Text(
                                        style: TextStyles.font20BlackW700,
                                        state.doctorModel.firstName.toString() +
                                            " " +
                                            state.doctorModel.lastName
                                                .toString()),
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      )
                    : BlocProvider(
                        create: (context) => di.sl<AuthCubit>()..getPatientDetails(docId),
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is GetPatientDetialsSuccess) {
                              return Padding(
                                padding: EdgeInsets.only(top: 40.h, left: 30.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        style: TextStyles.font24PrimaryW700
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                        "welcome"),
                                    Text(
                                        style: TextStyles.font20BlackW700,
                                        "${state.doctorModel.firstName} ${state.doctorModel.lastName}"),
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      ),
              ),
              doctor_role != null
                  ? verticalSpacing(20)
                  : const SizedBox(
                      height: 0.0,
                    ),
              doctor_role != null
                  ? const AddClinicWidget()
                  : const SizedBox(
                      height: 0,
                    ),
              verticalSpacing(20),
              const AISection(),
              verticalSpacing(20),
              const SkinCancerSection(),
              verticalSpacing(20),
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                            size: 44,
                            Icons.info_outline_rounded,
                            color: AppColor.primaryColor),
                        horizontalSpacing(10),
                        Text(
                          "Learning Center",
                          style: TextStyles.font15BlackW500,
                        )
                      ],
                    ),
                    RowOfIconTextArrow(
                      text: "Skin Cancer Facts and Statistics",
                      onTap: () {
                        context.pushNamed(Routes.factsAndStatisticScreen);
                      },
                    ),
                    RowOfIconTextArrow(
                      text: "Risk Factors",
                      onTap: () {
                        context.pushNamed(Routes.riskFactorsScreen);
                      },
                    ),
                    RowOfIconTextArrow(
                      text: "Prevention",
                      onTap: () {
                        context.pushNamed(Routes.preventionScreen);
                      },
                    ),
                    RowOfIconTextArrow(
                        text: "Early Detection",
                        iconPath: "assets/image/alarm.png",
                        onTap: () {
                          context.pushNamed(Routes.earlyDetectionScreen);
                        }),
                  ],
                ),
              ),
              verticalSpacing(20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
