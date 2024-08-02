import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/date_converter.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/clinic/cubit/clinic_cubit.dart';
import 'package:mobile/features/clinic/data/model/selected_clinic_model.dart';
import 'package:mobile/features/explore/cubit/patient_cubit_cubit.dart';
import 'package:mobile/injection_container.dart' as di;

class AppointmentWidget extends StatefulWidget {
  List<SelectedClinicModel> clincs;
  AppointmentWidget({super.key, required this.clincs});

  @override
  State<AppointmentWidget> createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {
  var doctorrole = CacheHelper.getData(key: 'doctor_role');
  String patientId = " ";
  String selectedDateAndTime3 = '';
  var clinicId = CacheHelper.getData(key: 'clinic_id');
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
       onRefresh: () async {
                    di.sl<ClinicCubit>().getClinicAppointments(clinicId);
                  },
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  DateTime dateTime =
                      DateTime.parse(widget.clincs[index].date.toString());
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                        height: 120.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0)
                            ]),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person,
                                    size: 60.h, color: Colors.white),
                                horizontalSpacing(5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.clincs[index].patientName
                                          .toString(),
                                      style: TextStyles.font20BlackW700
                                          .copyWith(color: Colors.white),
                                    ),
                                    verticalSpacing(5),
                                    Text(
                                      widget.clincs[index].clinicName
                                          .toString(),
                                      style: TextStyles.font16BlackW500
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      if (doctorrole != null) {
                                        context.pushNamed(
                                            Routes.aiHistoryByDoctor,
                                            arguments:
                                                widget.clincs[index].patientId);
                                      } else {
                                        context
                                            .pushNamed(Routes.aIHistoryScreen);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 40.h,
                                    ))
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: Divider(),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 30.h,
                                  color: Colors.white,
                                ),
                                horizontalSpacing(5),
                                Text(
                                  DateConverter.getDateTimeWithMonth(dateTime),
                                  style: TextStyles.font16BlackW500
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        )),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: widget.clincs.length),
          ),
          SizedBox(
            height: 15.h,
          ),
          AppButton(
            buttonColor: AppColor.primaryColor,
            width: 300.w,
            height: 50.h,
            buttonName: 'Add a new appointment',
            onTap: () async {
              Map<String, String?> date = await DateConverter.showDateTimePicker(
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
                    .read<PatientClinicCubit>()
                    .docCreateSchadual(selectedDateAndTime3, false, clinicId)
                    .then((value) {
                  context.pushNamedAndRemoveUntil(Routes.bottomNavScreenRoutes,
                      predicate: (Route<dynamic> route) => false);
                });
              }
            },
            textColor: Colors.white,
            white: false,
            borderRadius: 20.r,
          )
        ],
      ),
    );
  }
}
/*
ListTile(
                        title:
                            Text(widget.clincs[index].patientName.toString()),
                        subtitle:
                            Text(DateConverter.getDateTimeWithMonth(dateTime)),
                        trailing:
                            Text(widget.clincs[index].clinicName.toString()),
                      ),
*/