import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:mobile/injection_container.dart' as di;

import '../../../../core/utils/app_color.dart';
import '../widgets/doctor_container_widget.dart';
import 'doctors_details_screen.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({Key? key, required this.patientUid}) : super(key: key);
  final String patientUid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Doctors ",
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
        create: (context) => di.sl<HomeCubit>()..getDoctorData(),
        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          if (state is DoctorDataIsLoading) {
            return const Column(
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          } else if (state is DoctorDataLoaded) {
            return ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // bool istwork=state.doctors[index].imageUrl!=null;
                  return DoctorContainerWidget(
                    name: state.doctors[index].name.toString(),
                    email: state.doctors[index].email.toString(),
                    ontap: () {
                      Navigator.pushNamed(context, Routes.doctorsDetailsScreenRoutes,arguments:{
                        // state.doctors[index].name.toString(),
                        // state.doctors[index].email.toString(),
                        // state.doctors[index].about.toString(),
                        // state.doctors[index].uid.toString(),
                        // state.doctors[index].imageUrl.toString(),
                        // patientUid.toString()
                        'name':state.doctors[index].name.toString(),
                        'email':state.doctors[index].email.toString(),
                        "about":state.doctors[index].about.toString(),
                        "imageUrl":state.doctors[index].imageUrl.toString(),
                        "uid":state.doctors[index].uid.toString(),
                        'patientUid':patientUid
                      }, );
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => DoctorsDetailsScreen(
                      //           name: state.doctors[index].name.toString(),
                      //           email: state.doctors[index].email.toString(),
                      //           description:
                      //               state.doctors[index].about.toString(),
                      //           uid: state.doctors[index].uid.toString(),
                      //           patientUid: patientUid,
                      //           imageurl:
                      //               state.doctors[index].imageUrl.toString(),
                      //         )));
                    },
                    image: state.doctors[index].imageUrl.toString(),
                    isnetwork: true,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 20.h,
                    ),
                itemCount: state.doctors.length);
          } else if (state is DoctorDataError) {
            return Column(
              children: [
                Text(state.error.toString()),
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
      ),
    );
  }
}
