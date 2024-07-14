import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/date_converter.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_styles.dart';

class BookedClinicItem extends StatelessWidget {
  final String clinicName;
  final String patientName;
  final DateTime date;

  const BookedClinicItem(
      {super.key,
      required this.clinicName,
      required this.patientName,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          padding: EdgeInsets.only(
            top: 10.h,
left: 10.w,            bottom: 10.h,
          ),
          height: 150.h,
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
                  Icon(Icons.local_hospital, size: 60.h, color: Colors.white),
                  horizontalSpacing(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clinicName,
                        style: TextStyles.font20BlackW700
                            .copyWith(color: Colors.white),
                      ),
                      verticalSpacing(5),
                      Text(
                        patientName,
                        style: TextStyles.font16BlackW500
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              verticalSpacing(5),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Divider(),
              ),
              verticalSpacing(5),
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
                    DateConverter.getDateTimeWithMonth(date),
                    style: TextStyles.font16BlackW500
                        .copyWith(color: Colors.white),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
