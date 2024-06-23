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
import 'package:mobile/features/clinic/screens/widget/booked_clinic_item.dart';
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
                      return Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          centerTitle: true,
                          leading: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back_ios)),
                          backgroundColor: Colors.white,
                          title: const Text(
                            "Booked Clinic",
                          ),
                        ),
                        body: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  addAutomaticKeepAlives: true,
                                  itemBuilder: (context, index) {
                                    DateTime dateTime = DateTime.parse(state
                                        .selectedClinic[index].date
                                        .toString());

                                    return BookedClinicItem(
                                        clinicName: state.selectedClinic[index].clinicName.toString(),
                                        patientName: state.selectedClinic[index].patientName.toString(),
                                        date: dateTime);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(),
                                  itemCount: state.selectedClinic.length),
                            ),
                          ],
                        ),
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
