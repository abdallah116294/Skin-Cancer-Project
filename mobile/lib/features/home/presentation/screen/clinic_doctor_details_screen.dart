import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:mobile/features/home/presentation/screen/clinic_detailsScren.dart';
import 'package:mobile/features/home/presentation/widgets/list_tile_widget.dart';
import 'package:mobile/injection_container.dart' as di;

class ClinicDoctorDetials extends StatefulWidget {
  const ClinicDoctorDetials({super.key,required this.uid});
  final String uid;
  @override
  State<ClinicDoctorDetials> createState() => _ClinicDoctorDetialsState();
}

class _ClinicDoctorDetialsState extends State<ClinicDoctorDetials> {
  Timestamp? date;
    Map<String, dynamic> extractDateTime(Timestamp timestamp) {
    // Convert Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

    // Extract day, month, and hour
    int day = dateTime.day;
    String month = DateFormat('MMMM').format(dateTime); // Full month name
    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return {
      'day': day,
      'month': month,
      'hour': formattedTime,
    };
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clinic',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => di.sl<HomeCubit>()..getClinic(uid: widget.uid),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is AddSelectedClinicSuccess) {

            }
          },
          builder: (context, state) {
            return BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is GetClinicIsLoading) {
                  return const Column(
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                } else if (state is GetClinicLoaded) {
                  Map<String, dynamic> datatime1 =
                      extractDateTime(state.clinic.first.dateTime1);
                  Map<String, dynamic> datatime2 =
                      extractDateTime(state.clinic.first.dateTime2);
                  Map<String, dynamic> datatime3 =
                      extractDateTime(state.clinic.first.dateTime3);
                  ProfileActionState profileActionState1 = ProfileActionState(
                      iconData: Icons.radio_button_off, isSelected: false);
                  ProfileActionState profileActionState2 = ProfileActionState(
                      iconData: Icons.radio_button_off, isSelected: false);
                  ProfileActionState profileActionState3 = ProfileActionState(
                      iconData: Icons.radio_button_off, isSelected: false);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(state.clinic.first.imageUrl),
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ProfileAction(
                          title: "Dr.${state.clinic.first.doctorname}",
                          icondata: AppColor.medical_services_outlined,
                          function: () {},
                          icondata2: Icons.person,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ProfileAction(
                          title: "${state.clinic.first.price} EGY",
                          icondata: Icons.currency_pound,
                          function: () {},
                          icondata2: Icons.currency_pound,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ProfileAction(
                          title: state.clinic.first.address,
                          icondata: Icons.arrow_forward_ios_rounded,
                          function: () {},
                          icondata2: AppColor.location_pin,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
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
                        SizedBox(
                          height: 20.h,
                        ),
                        ProfileAction(
                          title:
                              "${datatime1['day']}${datatime1['month']} ${datatime1['hour']}",
                          icondata: profileActionState1.iconData,
                          function: () {
                            log('change');
                            setState(() {
                              // Toggle the icon and isSelected state for ProfileAction 1
                              profileActionState1.isSelected =
                                  !profileActionState1.isSelected;
                              profileActionState1.iconData =
                                  profileActionState1.isSelected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off;
                              // Set the selected date for ProfileAction 1
                              date = profileActionState1.isSelected
                                  ? state.clinic.first.dateTime1
                                  : null;
                            });
                          },
                          icondata2: Icons.calendar_month,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ProfileAction(
                          title:
                              "${datatime2['day']}${datatime2['month']} ${datatime2['hour']}",
                          icondata: profileActionState2.iconData,
                          function: () {
                            setState(() {
                              // Toggle the icon and isSelected state for ProfileAction 1
                              profileActionState2.isSelected =
                                  !profileActionState2.isSelected;
                              profileActionState2.iconData =
                                  profileActionState2.isSelected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off;
                              // Set the selected date for ProfileAction 1
                              date = profileActionState2.isSelected
                                  ? state.clinic.first.dateTime1
                                  : null;
                            });
                          },
                          icondata2: Icons.calendar_month,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ProfileAction(
                          title:
                              "${datatime3['day']}${datatime3['month']} ${datatime3['hour']}",
                          icondata: profileActionState3.iconData,
                          function: () {
                            setState(() {
                              // Toggle the icon and isSelected state for ProfileAction 1
                              profileActionState3.isSelected =
                                  !profileActionState3.isSelected;
                              profileActionState3.iconData =
                                  profileActionState3.isSelected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off;
                              // Set the selected date for ProfileAction 1
                              date = profileActionState3.isSelected
                                  ? state.clinic.first.dateTime1
                                  : null;
                            });
                          },
                          icondata2: Icons.calendar_month,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  );
                } else if (state is GetClinicError) {
                  return Column(
                    children: [
                      Text(state.error),
                    ],
                  );
                }
                return const Column(
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
