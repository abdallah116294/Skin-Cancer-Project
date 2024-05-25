import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/date_converter.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/features/clinic/screens/widget/doc_clinic_widget.dart';
import 'package:mobile/features/explore/cubit/patient_cubit_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/helper/spacing.dart';
import 'package:mobile/injection_container.dart' as di;

import '../../../core/widgets/app_button.dart';
import '../../explore/data/model/clinic_info_model.dart';
import '../cubit/clinic_cubit.dart';

class DocClinicDetailsScreen extends StatelessWidget {
  const DocClinicDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var clinicName = CacheHelper.getData(key: 'clinicName');
    var token = CacheHelper.getData(key: 'token');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          di.sl<PatientClinicCubit>()
            ..getAllClinics(),
        ),
        BlocProvider(
          create: (context) => di.sl<ClinicCubit>()..deleteClinic(id: 1, token: token),
        ),
      ],
      child: BlocConsumer<PatientClinicCubit, PatientClinicState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var token = CacheHelper.getData(key: 'token');
          Map<String, dynamic> data = Jwt.parseJwt(token);
          String docId = data[
          "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
          if (state is GetAllClinicIsSuccess) {
            Iterable<ClinicInfoModel> clinicInfoModel = state.clinicInfoModel
                .where((element) => element.doctorId == docId);

            ///Todo
            //  DateTime dateTime3 = DateTime.parse(clinicInfoModel.first.availableDates as String) ;
            return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: () {
                        context.read<ClinicCubit>().deleteClinic(
                            id: state.clinicInfoModel.first.id!.toInt(),
                            token: token);
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
                            "Dr. Ahmed Khaled ",
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
                                          "${(clinicInfoModel.first.price! -
                                              100)}\$",
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
                ));
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
