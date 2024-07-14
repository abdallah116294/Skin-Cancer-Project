import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/cach_helper/cach_helper.dart';
import '../../../core/helper/date_converter.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/widgets/app_button.dart';
import '../../explore/cubit/patient_cubit_cubit.dart';

class EmptyAppointmentAnimate extends StatefulWidget {
  const EmptyAppointmentAnimate({super.key});

  @override
  State<EmptyAppointmentAnimate> createState() => _EmptyAppointmentAnimateState();
}

class _EmptyAppointmentAnimateState extends State<EmptyAppointmentAnimate> {
  var doctorrole = CacheHelper.getData(key: 'doctor_role');
  String patientId = " ";
  String selectedDateAndTime3 = '';
  var clinicId = CacheHelper.getData(key: 'clinic_id');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        verticalSpacing(30),
        Center(
          child: Lottie.asset('assets/animation/empty.json'),
        ),
        verticalSpacing(270),

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
    );
  }
}
