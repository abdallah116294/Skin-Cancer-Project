import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/features/Auth/cubit/auth_cubit.dart';
import 'package:mobile/features/home/widget/add_clinic_widget.dart';
import 'package:mobile/features/home/widget/info_center.dart';
import 'package:mobile/injection_container.dart' as di;

import '../../config/routes/app_routes.dart';
import '../../core/utils/app_color.dart';
import 'widget/ai_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    List<Widget> infoList = [
      InfoCenter(
        imagePath: "assets/image/cancer.png",
        title: "What is Skin Cancer?",
        onTap: () {
          context.pushNamed(Routes.whatSkinCanerScreenRoutes);
        },
      ),
      InfoCenter(
        imagePath: "assets/image/cancer_facts.png",
        title: "Facts and Statistics",
        onTap: () {
          context.pushNamed(Routes.factsAndStatisticScreen);
        },
      ),
      InfoCenter(
        imagePath: "assets/image/risk_factors.png",
        title: "Risk Factors",
        onTap: () {
          context.pushNamed(Routes.riskFactorsScreen);
        },
      ),
      InfoCenter(
        imagePath: "assets/image/cancer_prevention.png",
        title: "Prevention",
        onTap: () {
          context.pushNamed(Routes.preventionScreen);
        },
      ),
      InfoCenter(
        imagePath: "assets/image/early_detection.png",
        title: "Early Detection",
        onTap: () {
          context.pushNamed(Routes.earlyDetectionScreen);
        },
      ),
    ];
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
              SizedBox(
                width: 390.w,
                height: 120.h,
                child: doctor_role != null
                    ? BlocProvider(
                        create: (context) =>
                            di.sl<AuthCubit>()..getDoctorDetials(docId),
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is GetDoctorDetialsSuccess) {
                              CacheHelper.saveData(
                                  key: 'doctor_name',
                                  value: state.doctorModel.firstName! +
                                      " " +
                                      state.doctorModel.lastName!);
                              return Padding(
                                padding: EdgeInsets.only(top: 40.h, left: 30.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        style: TextStyles.font24PrimaryW700
                                            .copyWith(color: Colors.black)
                                            .copyWith(
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.w600),
                                        "Hi,${state.doctorModel.firstName}"),
                                    verticalSpacing(5),
                                    Text(
                                      style: TextStyles.font20BlackW700
                                          .copyWith(
                                              color: const Color(0xFF616161),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400),
                                      "How are you today?",
                                    ),
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
                        create: (context) =>
                            di.sl<AuthCubit>()..getPatientDetails(docId),
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
                                            .copyWith(color: Colors.black)
                                            .copyWith(
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.w600),
                                        "Hi,${state.doctorModel.firstName}"),
                                    verticalSpacing(3),
                                    Text(
                                        style: TextStyles.font20BlackW700
                                            .copyWith(
                                                color: const Color(0xFF616161),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                        "How are you today?"),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
              ),
              doctor_role != null
                  ? verticalSpacing(10)
                  : const SizedBox(
                      height: 0.0,
                    ),
              doctor_role != null
                  ? const AddClinicWidget()
                  : verticalSpacing(0),
              doctor_role != null ? verticalSpacing(15) : verticalSpacing(0),
              const AISection(),
              verticalSpacing(10),
              verticalSpacing(10),
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
                  ],
                ),
              ),
              verticalSpacing(20),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: SizedBox(
                    height: 800.h,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: infoList.length,
                      itemBuilder: (context, index) {
                        return infoList[index];
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: .78),
                    ),
                  ))
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
