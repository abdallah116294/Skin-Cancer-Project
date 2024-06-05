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
import 'package:mobile/features/appointment/widgets/appointment_widget.dart';
import 'package:mobile/features/clinic/cubit/clinic_cubit.dart';
import 'package:mobile/features/clinic/data/model/selected_clinic_model.dart';
import 'package:mobile/injection_container.dart' as di;

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    var clinicid = CacheHelper.getData(key: 'clinic_id');
    String patientId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    log(clinicid.toString());
    Size size = MediaQuery.of(context).size;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    bool isWithinNext24Hours(DateTime date) {
      final now = DateTime.now();
      final twentyFourHoursFromNow = now.add(Duration(hours: 24));

      // Check if the given date is within the next 24 hours from now
      bool within24Hours =
          date.isAfter(now) && date.isBefore(twentyFourHoursFromNow);
      log('Is within next 24 hours: $within24Hours');
      return within24Hours;
    }

    bool isTomorrow(DateTime date) {
      final now = DateTime.now();
      final tomorrow = DateTime(now.year, now.month, now.day + 1);

      return tomorrow.year == date.year &&
          tomorrow.month == date.month &&
          tomorrow.day == date.day;
    }

    return Scaffold(
      body: clinicid != null
          ? BlocProvider(
              create: (context) =>
                  di.sl<ClinicCubit>()..getClinicAppointments(clinicid),
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
                                "You don't have booking yet",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Center(
                                child:
                                    Lottie.asset('assets/animation/empty.json'),
                              )
                            ],
                          );
                        } else {
                          List<SelectedClinicModel> selectedClinictody = state
                              .selectedClinic
                              .where((element) =>
                                  element.date!.day==DateTime.now().day)
                              .toList();
                          List<SelectedClinicModel> selectedClinictomoro = state
                              .selectedClinic
                              .where((element) => element.date!=null&&
                                          element.date!.isAfter(DateTime.now()) )
                              .toList();
                          List<SelectedClinicModel> selectedClinicfeature =
                              state.selectedClinic
                                  .where(
                                      (element) =>
                                          element.date!=null&&
                                          element.date!.isAfter(DateTime.now()))
                                  .toList();
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 20, right: 20),
                            child: DefaultTabController(
                              length: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    child: TabBar(
                                      labelColor: Colors.white,
                                      unselectedLabelColor:
                                          AppColor.primaryColor,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicator: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              30), // Creates border
                                          color: AppColor.primaryColor),
                                      onTap: (index) {},
                                      tabs: const [
                                        Tab(
                                          text: 'All',
                                        ),
                                        Tab(text: 'Tomorrow'),
                                        Tab(text: 'Next'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: size.height * .7,
                                    child: TabBarView(children: [
                                     state.selectedClinic.isNotEmpty? AppointmentWidget(
                                        clincs: state.selectedClinic,
                                      ): Center(
                                              child: Lottie.asset(
                                                  'assets/animation/empty.json'),
                                            ),
                                      selectedClinictomoro.isNotEmpty
                                          ? AppointmentWidget(
                                              clincs: selectedClinictomoro)
                                          : Center(
                                              child: Lottie.asset(
                                                  'assets/animation/empty.json'),
                                            ),
                                      selectedClinicfeature.isNotEmpty
                                          ? AppointmentWidget(
                                              clincs: selectedClinicfeature)
                                          : Center(
                                              child: Lottie.asset(
                                                  'assets/animation/empty.json'),
                                            )
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      } else if (state is GetSelectedClinicIsError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "You don't have booking yet",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Center(
                              child:
                                  Lottie.asset('assets/animation/empty.json'),
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
              ))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "You don't have clinic yet",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Center(
                  child: Lottie.asset('assets/animation/empty.json'),
                )
              ],
            ),
    );
  }
}
