import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/date_converter.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/core/widgets/sub_title_widgets.dart';
import 'package:mobile/features/explore/cubit/patient_cubit_cubit.dart';
import 'package:mobile/features/explore/widgets/action_widgets.dart';
import 'package:mobile/features/explore/widgets/select_appoint_ment.dart';
import 'package:mobile/injection_container.dart' as di;

class DocDetailsScreen extends StatelessWidget {
  // final Map<String, int>? value;
  final int id;
  const DocDetailsScreen({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String patientId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    return BlocProvider(
      create: (context) => di.sl<PatientClinicCubit>()..getClinicDetails(id),
      child: BlocConsumer<PatientClinicCubit, PatientClinicState>(
        listener: (context, state) {
          if (state is PatientRatingClinicIsSuccess) {
            DailogAlertFun.showMyDialog(
                daliogContent: state.patientBookSuccess.message.toString(),
                actionName: 'Go Home',
                context: context,
                onTap: () {
                  context.pushReplacementNamed(Routes.bottomNavScreenRoutes);
                });
          }
        },
        builder: (context, state) {
          return BlocBuilder<PatientClinicCubit, PatientClinicState>(
            builder: (context, state) {
              if (state is GetClinicDetailsIsloading) {
                return const Scaffold(
                  body: Center(
                    child: CireProgressIndecatorWidget(),
                  ),
                );
              } else if (state is GetClinicDetailsIsSuccess) {
                return Scaffold(
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                              height: 327.h,
                              width: 390.w,
                              fit: BoxFit.cover,
                              "https://i.pinimg.com/564x/0c/cb/ee/0ccbeed7579bab12f78b5ed9e41660da.jpg"),
                          verticalSpacing(14),
                          Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: AppColor.primaryColor),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Ahmed Khaled",
                                        style: TextStyles.font20whiteW700,
                                      ),
                                      Text(
                                        '${state.clinicInfoModel.rate}⭐',
                                        style: TextStyles.font20whiteW700,
                                      )
                                      // RatingBar(ratingWidget: state.clinicInfoModel.rate!.toInt().toString(), onRatingUpdate: )
                                    ],
                                  ),
                                  verticalSpacing(8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.clinicInfoModel.name.toString(),
                                        style: TextStyles.font14BlackW300
                                            .copyWith(color: Colors.white),
                                      ),
                                      Text(
                                        state.clinicInfoModel.address
                                            .toString()
                                            .split(" ")
                                            .take(7)
                                            .join(''),
                                        style: TextStyles.font14BlackW300
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "About",
                            style: TextStyles.font24PrimaryW700.copyWith(
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
                          ),
                          verticalSpacing(14),
                          Text(
                            state.clinicInfoModel.description.toString(),
                            style: TextStyles.font24PrimaryW700.copyWith(
                                fontSize: 18.sp, fontWeight: FontWeight.w400),
                          ),
                          verticalSpacing(10),
                          const SubtitleTextWidget(label: 'Sechdule Dates'),
                          verticalSpacing(10),
                          Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                DateTime dateTime = DateTime.parse(state
                                    .clinicInfoModel.availableDates[index]
                                    .toString());
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 5.0,
                                              spreadRadius: 0.0)
                                        ]
                                        ),
                                    child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              DateConverter.getDateTimeWithMonth(
                                                  dateTime)),
                                        )),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount:
                                  state.clinicInfoModel.availableDates.length,
                            ),
                          ),
                          //const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  buttonColor: const Color(0xFF0010B2),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xFF7E87E2),
                                    Color(0xFF0010B2),
                                  ]),
                                  width: 170,
                                  height: 50,
                                  textOfButtonStyle: TextStyles.font15BlackW500
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                  buttonName: "Book Appointment",
                                  onTap: () {
                                    ModalBottomSheet.addAppointment(
                                        context,
                                        state.clinicInfoModel.id!,
                                        state.clinicInfoModel.availableDates);
                                  },
                                  textColor: Colors.white,
                                  white: false,
                                ),
                              ),
                              horizontalSpacing(10),
                              Expanded(
                                child: AppButton(
                                    buttonColor: const Color(0xFF0010B2),
                                    width: 170,
                                    height: 50,
                                    gradient: const LinearGradient(colors: [
                                      Color(0xFF7E87E2),
                                      Color(0xFF0010B2),
                                    ]),
                                    textOfButtonStyle:
                                        TextStyles.font15BlackW500.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                    buttonName: "Rating",
                                    onTap: () {
                                      DailogAlertFun.showRationgDialog(
                                          onRatingChanged: (double value) {
                                            log(value.toString());
                                            double intivalue = value * 2;
                                            BlocProvider.of<PatientClinicCubit>(
                                                    context)
                                                .patientRateClinic(
                                                    token,
                                                    intivalue.toInt(),
                                                    patientId,
                                                    id);
                                          },
                                          initialRating: state
                                              .clinicInfoModel.rate!
                                              .toDouble(),
                                          actionName: "Rate",
                                          context: context,
                                          onTap: () {
                                            log(token);
                                            log(patientId);
                                            context.pushNamed(
                                                Routes.bottomNavScreenRoutes);
                                          });
                                    },
                                    textColor: Colors.white,
                                    white: false),
                              ),
                            ],
                          ),
                          verticalSpacing(20),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is GetClinicDetailsIsError) {
                return Scaffold(
                  body: Column(
                    children: [Text(state.error)],
                  ),
                );
              } else {
                return const Scaffold(
                  body: Center(
                    child: CireProgressIndecatorWidget(),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
