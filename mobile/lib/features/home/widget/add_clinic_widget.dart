import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_button.dart';

class AddClinicWidget extends StatefulWidget {
  const AddClinicWidget({super.key});

  @override
  State<AddClinicWidget> createState() => _AddClinicWidgetState();
}

class _AddClinicWidgetState extends State<AddClinicWidget> {

  @override
  Widget build(BuildContext context) {
    var clinicName =CacheHelper.getData(key: 'clinicName');
    if(clinicName== null) {
      return Container(
        width: 365.w,
        height: 190.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: const Color(0xFFC5CAFB),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 5.h, left: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      maxLines: 2,
                      style: TextStyles.font16BlackW500,
                      "Add Your Clinic Info\n"),
                  verticalSpacing(5),
                  Text(
                      style: TextStyles.font14BlackW300,
                      "Reach more patients\nto better healthcare\nby adding your clinic "),
                  verticalSpacing(5),
                  AppButton(
                      borderRadius: 8.r,
                      buttonColor: Colors.white,
                      width: 120,
                      height: 40,
                      textOfButtonStyle: TextStyles.font14BlackW600,
                      buttonName: "Add Your Clinic ",
                      onTap: () {
                        context.pushNamed(Routes.addClinicScreenRoutes);
                      },
                      textColor: Colors.black,
                      white: false)
                ],
              ),
              horizontalSpacing(12),
              Image.asset(
                fit: BoxFit.cover,
                "assets/image/clinic.png",
              )
            ],
          ),
        ),
      );
    }
    else{
      return Container(
        width: 365.w,
        height: 190.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: const Color(0xFFC5CAFB),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 5.h, left: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      maxLines: 2,
                      style: TextStyles.font16BlackW500,
                      clinicName.toString()),
                  verticalSpacing(5),
                  Text(
                      style: TextStyles.font14BlackW300,
                      "Reach more patients\nto better healthcare\nby adding your clinic "),
                  verticalSpacing(5),
                  AppButton(
                      borderRadius: 8.r,
                      buttonColor: Colors.white,
                      width: 120,
                      height: 40,
                      textOfButtonStyle: TextStyles.font14BlackW600,
                      buttonName: "My Clinic ",
                      onTap: () {
                        context.pushNamed(Routes.docClinicDetailsScreenRoutes);
                      },
                      textColor: Colors.black,
                      white: false)
                ],
              ),
              horizontalSpacing(12),
              Image.asset(
                fit: BoxFit.cover,
                "assets/image/clinic.png",
              )
            ],
          ),
        ),
      );

    }
  }
}
