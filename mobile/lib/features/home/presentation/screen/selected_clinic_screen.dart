import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/widgets/subtitle_widget.dart';
import 'package:mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:mobile/features/home/presentation/widgets/selected_clinic_widget.dart';
import 'package:mobile/injection_container.dart' as di;

class SelectedClinicScreen extends StatefulWidget {
  const SelectedClinicScreen({super.key, required this.uid});
  final String uid;
  @override
  State<SelectedClinicScreen> createState() => _SelectedClinicScreenState();
}

class _SelectedClinicScreenState extends State<SelectedClinicScreen> {
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
            "Selected Clinic",
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
              di.sl<HomeCubit>()..getSelectedClinic(widget.uid),
          child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            if (state is GeteSlectedClinicIsLoading) {
              return const Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              );
            } else if (state is GeteSlectedClinicLoaded) {
              if (state.selectedClinic.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const SubtitleTextWidget(
                          label: "You Don't Select Clinic"),
                      Lottie.asset('assets/animation/empty_list.json'),
                    ],
                  ),
                );
              }
              else {
                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return SelectedClinicWidget(
                        image: state.selectedClinic[index].imageUrl,
                        doctorname: state.selectedClinic[index].doctorname,
                        date:
                            "${state.selectedClinic[index].dateTime1.toDate().day.toString()}/${state.selectedClinic[index].dateTime1.toDate().month.toString()}/${state.selectedClinic[index].dateTime1.toDate().year.toString()}",
                        address: state.selectedClinic[index].address);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: state.selectedClinic.length);
              }
              // Map<String, dynamic> datatime1 =
              //       extractDateTime(state.selectedClinic[in].dateTime1);
              
            } else if (state is GeteSlectedClinicError) {
              return Column(
                children: [
                  Center(
                    child: Text(state.error.toString()),
                  )
                ],
              );
            }
            return const Column(
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          }),
        ));
  }
}
