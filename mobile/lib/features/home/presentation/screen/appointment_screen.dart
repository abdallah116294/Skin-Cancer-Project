import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/core/widgets/subtitle_widget.dart';
import 'package:mobile/features/home/presentation/screen/ai_results_screen.dart';
import 'package:mobile/injection_container.dart' as di;

import '../cubit/home_cubit.dart';
import '../widgets/appointmet_container_widget.dart';
import '../widgets/doctor_container_widget.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
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

  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   BlocProvider.of<HomeCubit>(context).getAppointment(uid: widget.uid);
  // }
  @override
  Widget build(BuildContext context) {
    log(widget.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Appointment",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: BlocProvider(
        create: (context) =>
            di.sl<HomeCubit>()..getAppointment(uid: widget.uid),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is GetAppointmentLoading) {
              log("loading");
            } else if (state is GetAppointmentLoaded) {
              log("loading${state.patient.first.name}");
            } else if (state is GetAppointmentError) {
              log(state.error);
            }
          },
          builder: (context, state) {
            return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
              if (state is GetAppointmentLoading) {
                return const Column(
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              } else if (state is GetAppointmentLoaded) {
                if (state.patient.isEmpty) {
                  return   Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        SubtitleTextWidget(label: "There is no Appointment now "),
                        Lottie.asset('assets/animation/empty_list.json'),
                      ],
                    ),
                  );
                } else {
                  log(state.patient.first.date.toString());
                  Map<String, dynamic> datatime1 =
                      extractDateTime(state.patient.first.date!);
                  return ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        //  return  Text(state.patient[index].name.toString(),style: TextStyle(color: Colors.black),);
                        // bool istwork=state.doctors[index].imageUrl!=null;
                        return AppointmentContainerWidget(
                          name: state.patient[index].name.toString(),
                          email: state.patient[index].email.toString(),
                          ontap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AIResultsScreen(uid: state.patient[index].uid.toString(),)));
                            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DoctorsDetailsScreen(name: state.doctors[index].name.toString(), email: state.doctors[index].email.toString(), description: state.doctors[index].about.toString(), uid: state.doctors[index].uid.toString(), patientUid: patientUid,)));
                          },
                          image: state.patient[index].imageUrl.toString(),
                          isnetwork: true,
                          date:
                              "${datatime1['day']}${datatime1['month']} ${datatime1['hour']}",
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 20.h,
                          ),
                      itemCount: state.patient.length);
                }
              } else if (state is GetAppointmentError) {
                return Column(
                  children: [
                    Text(state.error.toString()),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CustomButton(
                        buttoncolor: const Color(0xff588CD5),
                        width: 250.w,
                        height: 51.h,
                        buttonName: "Get Started",
                        onTap: () {
                          BlocProvider.of<HomeCubit>(context)
                              .getAppointment(uid: widget.uid);
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  DoctorsScreen(patientUid:patientUid,)));
                        },
                        textColor: Colors.white,
                        white: false),
                  )
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
