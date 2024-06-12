import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/date_converter.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/features/clinic/cubit/clinic_cubit.dart';
import 'package:mobile/features/clinic/data/model/selected_clinic_model.dart';
import 'package:mobile/injection_container.dart' as di;

class PatientSelectedClinic extends StatefulWidget {
  const PatientSelectedClinic({super.key});

  @override
  State<PatientSelectedClinic> createState() => _PatientSelectedClinicState();
}

class _PatientSelectedClinicState extends State<PatientSelectedClinic> {
  bool isWithinNext24Hours(DateTime date) {
    final now = DateTime.now();
    final twentyFourHoursFromNow = now.add(Duration(hours: 24));

    // Check if the given date is within the next 24 hours from now
    bool within24Hours =
        date.isAfter(now) && date.isBefore(twentyFourHoursFromNow);
    log('Is within next 24 hours: $within24Hours');
    return within24Hours;
  }

  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String patientId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
          create: (context) =>
              di.sl<ClinicCubit>()..getSelectedClinic(patientId),
          child: BlocConsumer<ClinicCubit, ClinicState>(
            listener: (context, state) {
              if (state is GetSelectedClinicIsLoading) {
                log("loading");
              } else if (state is GetSelectedClinicIsSuccess) {
                log("success");
              } else if (state is GetSelectedClinicIsError) {
                log(state.error);
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              return BlocBuilder<ClinicCubit, ClinicState>(
                builder: (context, state) {
                  if (state is GetSelectedClinicIsLoading) {
                    return const Column(
                      children: [
                        Center(
                          child: CireProgressIndecatorWidget(),
                        )
                      ],
                    );
                  } else if (state is GetSelectedClinicIsSuccess) {
                    if (state.selectedClinic.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "You don't book in any clinic yet",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Center(
                            child: Lottie.asset('assets/animation/empty.json'),
                          )
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          verticalSpacing(30),
                          Expanded(
                            child: ListView.separated(
                                addAutomaticKeepAlives: true,
                                itemBuilder: (context, index) {
                                  DateTime dateTime = DateTime.parse(state
                                      .selectedClinic[index].date
                                      .toString());

                                  return Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                        height: 120.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 0.0)
                                            ]),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.local_hospital,
                                                    size: 60.h,
                                                    color: Colors.white),
                                                horizontalSpacing(5),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state
                                                          .selectedClinic[index]
                                                          .clinicName
                                                          .toString(),
                                                      style: TextStyles
                                                          .font20BlackW700
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    verticalSpacing(5),
                                                    Text(
                                                      state
                                                          .selectedClinic[index]
                                                          .patientName
                                                          .toString(),
                                                      style: TextStyles
                                                          .font16BlackW500
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                // IconButton(
                                                //     onPressed: () {
                                            
                                                //     },
                                                //     icon: Icon(
                                                //       Icons.arrow_forward_ios,
                                                //       color: Colors.white,
                                                //       size: 40.h,
                                                //     ))
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 60),
                                              child: Divider(),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  size: 30.h,
                                                  color: Colors.white,
                                                ),
                                                horizontalSpacing(5),
                                                Text(
                                                  DateConverter
                                                      .getDateTimeWithMonth(
                                                          dateTime),
                                                  style: TextStyles
                                                      .font16BlackW500
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: state.selectedClinic.length),
                          ),
                        ],
                      );
                    }
                  } else if (state is GetSelectedClinicIsError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "You don't have book in any clinic yet",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Center(
                          child: Lottie.asset('assets/animation/empty.json'),
                        )
                      ],
                    );
                  }
                  return const Column(
                    children: [
                      Center(
                        child: CireProgressIndecatorWidget(),
                      )
                    ],
                  );
                },
              );
            },
          )),
    );
  }
}
