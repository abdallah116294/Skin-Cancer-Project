import 'dart:developer';

import 'package:flutter/cupertino.dart';
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
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/features/explore/cubit/patient_cubit_cubit.dart';
import 'package:mobile/features/explore/data/model/clinic_schedual_model.dart';
import 'package:mobile/features/explore/top_doc_screen.dart';
import 'package:mobile/features/explore/widgets/action_widgets.dart';
import 'package:mobile/injection_container.dart' as di;

class PatientCheckDate extends StatefulWidget {
  List<String> availableDates;
  final int clinicId;
  PatientCheckDate(
      {super.key, required this.clinicId, required this.availableDates});

  @override
  State<PatientCheckDate> createState() => _PatientCheckDateState();
}

class _PatientCheckDateState extends State<PatientCheckDate> {
  String? date;
  int? selectedIndex;
  ProfileActionState profileActionState1 =
      ProfileActionState(iconData: Icons.radio_button_off, isSelected: false);
  ProfileActionState profileActionState2 =
      ProfileActionState(iconData: Icons.radio_button_off, isSelected: false);
  ProfileActionState profileActionState3 =
      ProfileActionState(iconData: Icons.radio_button_off, isSelected: false);
  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String patientId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    return BlocProvider(
      create: (context) =>
          di.sl<PatientClinicCubit>()..getClinicSchedual(widget.clinicId),
      child: BlocConsumer<PatientClinicCubit, PatientClinicState>(
        listener: (context, state) {
          if (state is PatientBookSchedualIsSuccess) {
            if (state.patientBookSuccess.message ==
                'An error occurred while booking schedule: An error occurred while saving the entity changes. See the inner exception for details.') {
              DailogAlertFun.showMyDialog(
                  daliogContent: "You Have Book before",
                  actionName: "Go Back",
                  context: context,
                  onTap: () {
                    context.pushNamedAndRemoveUntil(Routes.bottomNavScreenRoutes,arguments: widget.clinicId,predicate:(route)=>route.settings.name==Routes.bottomNavScreenRoutes );
                  });
            } else {
              DailogAlertFun.showMyDialog(
                  daliogContent: "Booked Successfull",
                  actionName: "Go Back",
                  context: context,
                  onTap: () {
                    context.pop();
                  });
            }
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Appointments',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.h,
                      fontWeight: FontWeight.bold),
                ),
              ),
              verticalSpacing(10),
              BlocBuilder<PatientClinicCubit, PatientClinicState>(
                builder: (context, state) {
                  if (state is GetClinicSchedualIsLoading) {
                    return CireProgressIndecatorWidget();
                  } else if (state is GetClinicSchedualIsSuccess) {
                    // Filter the clinic schedule to only include items where isBooked is false
                    List<ClinicSchedualModel> availableSchedules = state
                        .clinicSchedual
                        .where((schedule) => !schedule.isBooked)
                        .toList();
                    log(availableSchedules.length.toString());
                    if (availableSchedules.isEmpty) {
                      return Center(
                        child: Lottie.asset('assets/animation/empty.json'),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: availableSchedules.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime =
                                DateTime.parse(availableSchedules[index].date);
                            bool isSelected =
                                availableSchedules[index].date == date;

                            return ProfileAction(
                              title:
                                  DateConverter.getDateTimeWithMonth(dateTime),
                              icondata: isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              function: () {
                                log('change');
                                setState(() {
                                  date = availableSchedules[index].date;
                                  // selectedIndex = index + 1;
                                  // selectedIndex = availableSchedules.indexWhere(
                                  //     (schedule) => schedule.date == date);
                                  selectedIndex = widget.availableDates
                                      .indexWhere((element) => element == date);
                                  log(selectedIndex.toString());
                                  log(date.toString());
                                });
                              },
                              icondata2: Icons.calendar_month,
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is GetClinicSchedualIsError) {
                    log("Error State: " + state.error);
                    return Text(state.error.toString());
                  }
                  return SizedBox();
                },
              ),
              verticalSpacing(10),
              state is PatientBookSchedualIsLoading
                  ? const CireProgressIndecatorWidget()
                  : AppButton(
                      buttonColor: const Color(0xFF0010B2),
                      gradient: const LinearGradient(colors: [
                        Color(0xFF7E87E2),
                        Color(0xFF0010B2),
                      ]),
                      width: 170,
                      height: 50,
                      textOfButtonStyle: TextStyles.font15BlackW500.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.white),
                      buttonName: "Book Appointment",
                      onTap: () {
                        log(patientId);
                        BlocProvider.of<PatientClinicCubit>(context)
                            .patienBookSchedual(
                                selectedIndex!, patientId, token);
                      },
                      textColor: Colors.white,
                      white: false,
                    ),
            ],
          );
        },
      ),
    );
  }
}
