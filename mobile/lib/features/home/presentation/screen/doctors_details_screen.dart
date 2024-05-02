import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:mobile/features/home/presentation/screen/clinic_detailsScren.dart';
import 'package:mobile/injection_container.dart' as di;
import '../../../../core/utils/app_color.dart';

class DoctorsDetailsScreen extends StatelessWidget {
  const DoctorsDetailsScreen(
      {Key? key,
      required this.name,
      required this.email,
      required this.description,
      required this.uid,
      required this.patientUid,
      required this.imageurl})
      : super(key: key);
  final String name;
  final String email;
  final String description;
  final String imageurl;
  final String uid;
  final String patientUid;
  @override
  Widget build(BuildContext context) {
    log(uid);
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){}),
      // ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) =>
              di.sl<HomeCubit>()..getSpecificPatient(patientUid, 0),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is GetSpecificPatient) {
                log('done');
              }
            },
            builder: (context, state) {
              return BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is DoctorDataIsLoading) {
                    return const Column(
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  } else if (state is GetSpecificPatient) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 390.w,
                          height: 327,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(imageurl.toString()),
                                  fit: BoxFit.fill)),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 22,
                                left: 0,
                                right: 0,
                                child: AppBar(
                                  backgroundColor: Colors.transparent,
                                  leading: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back_ios),
                                    color: const Color(0xff6069C0),
                                  ),
                                  elevation: 0, // remove app bar shadow
                                ),
                              ),
                              Positioned(
                                  top: 22,
                                  left: 290,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: Color(0xff6671EB),
                                    ),
                                    onPressed: () {},
                                  )),
                              Positioned(
                                  top: 250,
                                  child: Text(
                                    'Dr.$name',
                                    style: TextStyle(
                                        color: const Color(0xff747EE4),
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Positioned(
                                  top: 280,
                                  child: Text(
                                    email,
                                    style: TextStyle(
                                      color: const Color(0xff828BE7),
                                      fontSize: 14.sp,
                                    ),
                                  )),
                              SizedBox(
                                height: 20.h,
                              ),
                              // Positioned(top: ,child: Text("⭐⭐⭐⭐",style: TextStyle(color: AppColor.starColor),)),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color(0xff4F8CE2),
                          endIndent: 30,
                          indent: 30,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Text(
                            "About",
                            style: TextStyle(
                                color: const Color(0xff828BE7),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Text(
                            "\t\t\t\t\t\t\t\n"
                            "$description",
                            style: TextStyle(
                              color: const Color(0xff828BE7),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomButton(
                                buttoncolor: const Color(0xff7E87E2),
                                width: 190.w,
                                height: 50.h,
                                buttonName: "Book Appointment",
                                onTap: () {
                                  BlocProvider.of<HomeCubit>(context)
                                      .getSpecificPatient(patientUid, 0)
                                      .then((value) {
                                    Navigator.pushNamed(context,
                                        Routes.clinicDetailsScreenRoutes,arguments: 
                                        {
                                          "uid":uid.toString(),
                                          "patientUid":patientUid.toString(),
                                          "patientEntity":state.patientEntity,
                                          "doctorname":name
                                        });
                                  });
                                },
                                textColor: Colors.white,
                                white: false))
                      ],
                    );
                  } else if (state is DoctorDataError) {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        )
                        // Align(alignment: Alignment.bottomCenter, child:  CustomButton(buttoncolor:Color(0xff7E87E2) ,  width: 190.w, height: 50.h, buttonName: "Book Appointment", onTap: (){}, textColor: Colors.white, white: false))
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
      ),
    );
  }
}
