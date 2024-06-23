import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/features/explore/cubit/patient_cubit_cubit.dart';
import 'package:mobile/features/explore/data/model/clinic_info_model.dart';
import 'package:mobile/features/explore/widgets/clinic_item_widget.dart';
import 'package:mobile/injection_container.dart' as di;

import '../../config/routes/app_routes.dart';

class TopDocScreen extends StatefulWidget {
  const TopDocScreen({super.key});

  @override
  State<TopDocScreen> createState() => _TopDocScreenState();
}

class _TopDocScreenState extends State<TopDocScreen> {
  final searchController = TextEditingController();
  List<ClinicInfoModel>? clinics;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => di.sl<PatientClinicCubit>()..getAllClinics(),
          child: BlocBuilder<PatientClinicCubit, PatientClinicState>(
            builder: (context, state) {
              if (state is GetAllClinicIsLoading ||
                  state is GetSearchResultIsLoading) {
                return const CireProgressIndecatorWidget();
              } else if (state is GetAllClinicIsSuccess ||
                  state is GetSearchResultSuccess) {
                if (state is GetAllClinicIsSuccess) {
                  clinics = state.clinicInfoModel;
                } else if (state is GetSearchResultSuccess) {
                  clinics = state.clinicInfoModel;
                }
                return Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(15.w),
                          child: SearchBar(
                            // backgroundColor:    WidgetStateProperty.all(
                            //   Colors.grey.shade300,
                            // ),

                            controller: searchController,
                            hintText: 'Search Specialty',
                            leading: const Icon(Icons.search),
                            onSubmitted: (value) {
                              BlocProvider.of<PatientClinicCubit>(context)
                                  .searchClinic(searchController.text);
                            },
                          ),
                        ),
                        Center(
                          child: Text(
                            "Popular Clinics",
                            style: TextStyles.font24PrimaryW700,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            verticalSpacing(10),
                        shrinkWrap: true,
                        itemCount: clinics!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              log(clinics.toString());
                              //log("Clinic ${clinics![index].availableDates.first}");
                              context.pushNamed(Routes.docDetailsScreen,
                                  arguments: clinics![index].id);
                            },
                            child: ClinicItemWidget(
                              clinicAddress: clinics![index].address.toString(),
                              clinicName: clinics![index].name.toString(),
                               rate:clinics![index].rate!=null?clinics![index].rate!.toDouble():0 ,
                            // rate: clinics![index].rate!.toDouble(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is GetAllClinicIsError) {
                return Text('There is no Item');
              } else if (state is GetSearchResultError) {
                return Center(
                  child: Lottie.asset('assets/animation/empty.json'),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

enum SelectedDate { dateTime1, dateTime2, dateTime3 }

class ProfileActionState {
  IconData iconData;
  bool isSelected;

  ProfileActionState({required this.iconData, required this.isSelected});
}
