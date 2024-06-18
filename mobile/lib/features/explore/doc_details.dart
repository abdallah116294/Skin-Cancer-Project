import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:mobile/features/explore/widgets/select_appoint_ment.dart';
import 'package:mobile/injection_container.dart' as di;

class DocDetailsScreen extends StatefulWidget {
  // final Map<String, int>? value;
  final int id;

  const DocDetailsScreen({super.key, required this.id});

  @override
  State<DocDetailsScreen> createState() => _DocDetailsScreenState();
}

class _DocDetailsScreenState extends State<DocDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');
    double? ratingvalue;
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String patientId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    return BlocProvider(
      create: (context) =>
          di.sl<PatientClinicCubit>()..getClinicDetails(widget.id),
      child: BlocConsumer<PatientClinicCubit, PatientClinicState>(
        listener: (context, state) {
          if (state is PatientRatingClinicIsSuccess) {
            if (state.patientBookSuccess.message ==
                "This Patient has rated this clinic before") {
              Fluttertoast.showToast(
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_LONG,
                msg: "You rating this clinic before",
              ).then((value) {
                context.pushNamedAndRemoveUntil(Routes.bottomNavScreenRoutes,
                    predicate: (Route<dynamic> route) => false);
              });
            } else {
              DailogAlertFun.showMyDialog(
                  daliogContent: state.patientBookSuccess.message.toString(),
                  actionName: 'Go Home',
                  context: context,
                  onTap: () {
                    context.pushNamedAndRemoveUntil(
                        Routes.bottomNavScreenRoutes,
                        predicate: (Route<dynamic> route) => false);
                  });
            }
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
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.r),
                              bottomLeft: Radius.circular(20.r),
                            ),
                          ),
                          child: Image.network(
                              height: 250.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              "https://i.pinimg.com/originals/1e/14/5b/1e145b7b9133b8d24cd7184a8208621d.jpg"),
                        ),
                        verticalSpacing(14),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Dr ${state.clinicInfoModel.doctorName!.split(" ").take(7).join(" ").toString()}",
                                    style: TextStyles.font20whiteW700.copyWith(
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColor.primaryColor,
                                        fontSize: 23.sp),
                                  ),
                                  Text(
                                    '⭐${state.clinicInfoModel.rate != null ? state.clinicInfoModel.rate : 0}',
                                    style: TextStyles.font20whiteW700.copyWith(
                                      color: AppColor.primaryColor,
                                      fontSize: 25.sp,
                                    ),
                                  )
                                ],
                              ),
                              verticalSpacing(8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.clinicInfoModel.name.toString(),
                                    style: TextStyles.font14BlackW300.copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    state.clinicInfoModel.address
                                        .toString()
                                        .split(" ")
                                        .take(7)
                                        .join(''),
                                    style: TextStyles.font14BlackW300.copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              verticalSpacing(40),
                              Text(
                                "About",
                                style: TextStyles.font24PrimaryW700.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              verticalSpacing(14),
                              Text(
                                state.clinicInfoModel.description.toString(),
                                style: TextStyles.font24PrimaryW700.copyWith(
                                    fontSize: 18.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                              ),
                              verticalSpacing(10),
                              const SubtitleTextWidget(label: 'Schedule Dates'),
                              verticalSpacing(10),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 140.h,
                          width: double.infinity,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              DateTime dateTime = DateTime.parse(state
                                  .clinicInfoModel.availableDates[index]
                                  .toString());
                              return Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 5.0,
                                            spreadRadius: 0.0)
                                      ]),
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
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                buttonColor: AppColor.primaryColor,
                                width: 170,
                                height: 60,
                                textOfButtonStyle: TextStyles.font15BlackW500
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                buttonName: "Book Appointment",
                                onTap: () {
                                  ModalBottomSheet.addAppointment(
                                      context,
                                      state.clinicInfoModel.id!,
                                      state.clinicInfoModel.availableDates!=null?state.clinicInfoModel.availableDates:[],
                                      state.clinicInfoModel.name.toString(),
                                      state.clinicInfoModel.rate!=null?state.clinicInfoModel.rate!.toInt():0,
                                      state.clinicInfoModel.price!.toInt());
                                },
                                textColor: Colors.white,
                                white: false,
                              ),
                            ),
                            horizontalSpacing(10),
                            Expanded(
                              child: AppButton(
                                  buttonColor: AppColor.primaryColor,
                                  width: 170,
                                  height: 60,
                                  textOfButtonStyle: TextStyles.font15BlackW500
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                  buttonName: "Rating",
                                  onTap: () {
                                    DailogAlertFun.showRationgDialog(
                                        onRatingChanged: (double value) {
                                          log(value.toString());
                                          double intivalue = value * 2;
                                          setState(() {
                                            ratingvalue = intivalue;
                                          });
                                        },
                                        initialRating: state.clinicInfoModel.rate!=null?state.clinicInfoModel.rate!.toDouble():0.toDouble(),
                                        actionName: "Rate",
                                        context: context,
                                        onTap: () {
                                          BlocProvider.of<PatientClinicCubit>(
                                                  context)
                                              .patientRateClinic(
                                                  token,
                                                  ratingvalue!.toInt(),
                                                  patientId,
                                                  widget.id);
                                          log(token);
                                          log(patientId);
                                        });
                                  },
                                  textColor: Colors.white,
                                  white: false),
                            ),
                          ],
                        ),
                        verticalSpacing(50),
                      ],
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
