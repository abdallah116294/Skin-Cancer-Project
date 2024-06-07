import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/date_converter.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/features/Auth/cubit/auth_cubit.dart';
import 'package:mobile/features/clinic/screens/widget/doc_clinic_widget.dart';
import 'package:mobile/features/explore/cubit/patient_cubit_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/helper/spacing.dart';
import 'package:mobile/injection_container.dart' as di;

import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/custom_dailog.dart';
import '../../explore/data/model/clinic_info_model.dart';
import '../cubit/clinic_cubit.dart';

class DocClinicDetailsScreen extends StatefulWidget {
  const DocClinicDetailsScreen({super.key});

  @override
  State<DocClinicDetailsScreen> createState() => _DocClinicDetailsScreenState();
}

class _DocClinicDetailsScreenState extends State<DocClinicDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    String selectedDateAndTime3 = '';

    var clinicName = CacheHelper.getData(key: 'clinicName');
    var token = CacheHelper.getData(key: 'token');
    var doctorname = CacheHelper.getData(key: 'doctor_name');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<PatientClinicCubit>()..getAllClinics(),
        ),
        BlocProvider(
          create: (context) => di.sl<ClinicCubit>(),
        ),
      ],
      child: BlocConsumer<PatientClinicCubit, PatientClinicState>(
        listener: (context, state) {
          if (state is DocCreateSchedualSuccess) {
            DailogAlertFun.showMyDialog(
                daliogContent: "Create Schedual Success",
                actionName: "Go Home",
                context: context,
                onTap: () =>
                    context.pushReplacementNamed(Routes.bottomNavScreenRoutes));
          }
        },
        builder: (context, state) {
          var clinicId = CacheHelper.getData(key: 'clinic_id');

          var token = CacheHelper.getData(key: 'token');
          Map<String, dynamic> data = Jwt.parseJwt(token);
          String docId = data[
              "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
          if (state is GetAllClinicIsSuccess) {
            Iterable<ClinicInfoModel> clinicInfoModel = state.clinicInfoModel
                .where((element) => element.doctorId == docId);
            //  clinicInfoModel.isEmpty? CacheHelper.saveData(
            //       key: 'clinic_id', value: clinicInfoModel.first.id):log("there is no clinic ");

            ///Todo
            //  DateTime dateTime3 = DateTime.parse(clinicInfoModel.first.availableDates as String) ;
            if (clinicInfoModel.isEmpty) {
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You don't have any clinic yet",
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
            } else {
              CacheHelper.saveData(
                  key: 'clinic_id', value: clinicInfoModel.first.id);
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: () {
                        context
                            .read<ClinicCubit>()
                            .deleteClinic(
                                id: state.clinicInfoModel.first.id!.toInt(),
                                token: token)
                            .then((value) {
                          context.pushReplacementNamed(
                              Routes.bottomNavScreenRoutes);
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: AppColor.primaryColor,
                      ),
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Image.network(
                                height: 130.h,
                                width: 130.w,
                                fit: BoxFit.cover,
                                "https://i.pinimg.com/564x/0c/cb/ee/0ccbeed7579bab12f78b5ed9e41660da.jpg"),
                          ),
                          verticalSpacing(10),
                          Text(
                            "Dr. $doctorname",
                            style: TextStyles.font20BlackW700,
                          ),
                          verticalSpacing(10),
                          Text(
                            clinicInfoModel.first.name.toString(),
                            style: TextStyles.font15BlackW500,
                          ),
                          verticalSpacing(10),
                          DocClinicWidget(
                            icon: Icons.location_on_outlined,
                            title: "Address",
                            subtitle: clinicInfoModel.first.address.toString(),
                          ),
                          verticalSpacing(20),
                          DocClinicWidget(
                            icon: Icons.local_phone_outlined,
                            title: "Phone",
                            subtitle: clinicInfoModel.first.phone.toString(),
                          ),
                          verticalSpacing(20),
                          Text(
                            "Cost",
                            style: TextStyles.font20BlackW700,
                          ),
                          verticalSpacing(20),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "offline",
                                    style: TextStyles.font20BlackW700
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    height: 66.h,
                                    width: 146.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        border: Border.all(
                                            color: const Color(0xFF9EA5F0),
                                            width: 1.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.monetization_on_outlined,
                                          color: Color(0xFF9EA5F0),
                                        ),
                                        Text(
                                          "${(clinicInfoModel.first.price)}\$",
                                          style: TextStyles.font15BlackW500,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    "online",
                                    style: TextStyles.font20BlackW700
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    height: 66.h,
                                    width: 146.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        border: Border.all(
                                            color: const Color(0xFF9EA5F0),
                                            width: 1.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.monetization_on_outlined,
                                          color: Color(0xFF9EA5F0),
                                        ),
                                        Text(
                                          "${(clinicInfoModel.first.price! - 100)}\$",
                                          style: TextStyles.font15BlackW500,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          verticalSpacing(20),
                          Text(
                            "Availability",
                            style: TextStyles.font20BlackW700,
                          ),
                          verticalSpacing(20),
                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  DateTime dateTime = DateTime.parse(
                                      clinicInfoModel
                                          .first.availableDates[index]);

                                  return DocClinicWidget(
                                    icon: Icons.calendar_month_outlined,
                                    title: DateConverter.getDateTimeWithMonth(
                                            dateTime)
                                        .split(',')[0],
                                    subtitle: DateConverter.getTime(dateTime),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: clinicInfoModel
                                    .first.availableDates.length),
                          ),
                          verticalSpacing(20),
                          Center(
                            child: AppButton(
                                borderRadius: 8.r,
                                buttonColor: AppColor.primaryColor,
                                width: 120,
                                height: 40,
                                textOfButtonStyle: TextStyles.font20whiteW700,
                                buttonName: "Update",
                                onTap: () {
                                  context.pushNamed(
                                      Routes.addClinicScreenRoutes,
                                      arguments: {
                                        "action": 0,
                                        "clinicId": clinicInfoModel.first.id,
                                      });
                                },
                                textColor: Colors.black,
                                white: false),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    Map<String, String?> date =
                        await DateConverter.showDateTimePicker(
                      context: context,
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                      initialDate: DateTime.now(),
                      selectedDateAndTime: selectedDateAndTime3,
                    );
                    setState(() {
                      selectedDateAndTime3 = date['selectedDateAndTime']!;
                    });
                    if (date['showDate'] != null) {
                      context
                          .read<ClinicCubit>()
                          .docCreateSchadual(
                              selectedDateAndTime3, false, clinicId)
                          .then((value) {
                        context.read<PatientClinicCubit>().getAllClinics();
                      });
                    }
                  },
                  child: const Icon(Icons.add),
                ),
              );
            }
          } else if (state is GetAllClinicIsError) {
            return Scaffold(
              body: Center(
                  child:
                      Text("some thing went wrong  ${state.error.toString()}")),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
