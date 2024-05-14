import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/date_converter.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/features/clinic/screens/widget/doc_clinic_widget.dart';

import '../../../core/helper/spacing.dart';
import 'package:mobile/injection_container.dart' as di;

import '../cubit/clinic_cubit.dart';

class DocClinicDetailsScreen extends StatelessWidget {
  const DocClinicDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var clinicName = CacheHelper.getData(key: 'clinicName');
    log(clinicName);
    return BlocProvider(
        create: (context) =>
            di.sl<ClinicCubit>()..getDocClinic(name: clinicName),
        child: BlocBuilder<ClinicCubit, ClinicState>(
          builder: (context, state) {
            if (state is GetDocClinicIsSuccess) {
              DateTime dateTime1 = DateTime.parse(state.clinicModel.date1);
              DateTime dateTime2 = DateTime.parse(state.clinicModel.date2);
              DateTime dateTime3 = DateTime.parse(state.clinicModel.date3);

              return Scaffold(
                  appBar: AppBar(),
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
                                  state.clinicModel.image.toString()),
                            ),
                            verticalSpacing(10),
                            Text(
                              "Dr. Ahmed Khaled ",
                              style: TextStyles.font20BlackW700,
                            ),
                            verticalSpacing(10),
                            Text(
                              state.clinicModel.name.toString(),
                              style: TextStyles.font15BlackW500,
                            ),
                            verticalSpacing(10),
                            DocClinicWidget(
                              icon: Icons.location_on_outlined,
                              title: "Address",
                              subtitle: state.clinicModel.address.toString(),
                            ),
                            verticalSpacing(20),
                            DocClinicWidget(
                              icon: Icons.local_phone_outlined,
                              title: "Phone",
                              subtitle: state.clinicModel.phone.toString(),
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
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
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
                                            "${(state.clinicModel.price)}\$",
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
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
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
                                            "${(state.clinicModel.price - 100)}\$",
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
                            DocClinicWidget(
                              icon: Icons.calendar_month_outlined,
                              title:
                                  DateConverter.getDateTimeWithMonth(dateTime1)
                                      .split(',')[0],
                              subtitle: DateConverter.getTime(dateTime1),
                            ),
                            verticalSpacing(20),
                            DocClinicWidget(
                              icon: Icons.calendar_month_outlined,
                              title:
                                  DateConverter.getDateTimeWithMonth(dateTime2)
                                      .split(',')[0],
                              subtitle: DateConverter.getTime(dateTime2),
                            ),
                            verticalSpacing(20),
                            DocClinicWidget(
                              icon: Icons.calendar_month_outlined,
                              title:
                                  DateConverter.getDateTimeWithMonth(dateTime3)
                                      .split(',')[0],
                              subtitle: DateConverter.getTime(dateTime3),
                            ),
                            verticalSpacing(20),
                          ],
                        ),
                      ),
                    ),
                  ));
            } else if (state is GetDocClinicIsError) {
              return Scaffold(
                body: Center(
                    child: Text("some thing went wrong  ${state.error}")),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }
}
