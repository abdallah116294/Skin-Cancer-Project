import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/features/explore/widgets/chcek_date_widget.dart';
import 'package:mobile/features/explore/widgets/rating_widget.dart';

class ModalBottomSheet {
  static void addAppointment(BuildContext context,int clinicId,List<String>availableDates ) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        isDismissible: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                width: 428.w,
                height: 441.h,
                padding: const EdgeInsets.all(20),
                child: PatientCheckDate(clinicId: clinicId,availableDates: availableDates,)
              ),
            ),
          );
        });
  }
  static void addRating (BuildContext context, final Function(double) onRatingChanged,final double initialRating){
        showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        isDismissible: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                width: 428.w,
                height: 441.h,
                padding: const EdgeInsets.all(20),
                child: RatingStarsWidget(initialRating: initialRating/2, onRatingChanged: onRatingChanged,)
              ),
            ),
          );
        });
  }
}