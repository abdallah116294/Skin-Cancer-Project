import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/explore/cubit/patient_cubit_cubit.dart';
import 'package:mobile/injection_container.dart' as di;

import '../../clinic/cubit/clinic_cubit.dart';
import '../../explore/data/model/clinic_info_model.dart';

class AddClinicWidget extends StatefulWidget {
  const AddClinicWidget({super.key});

  @override
  State<AddClinicWidget> createState() => _AddClinicWidgetState();
}

class _AddClinicWidgetState extends State<AddClinicWidget> {
  @override
  Widget build(BuildContext context) {
    var clinicName = CacheHelper.getData(key: 'clinicName');
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String docId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    return BlocConsumer<ClinicCubit, ClinicState>(
      listener: (context, state) {},
      builder: (BuildContext context, ClinicState state) {
        if (state is GetDocHasClinicIsSuccess) {
          if (state.addClinicSuccess.message == "This Doctor has already clinic") {
            return const ShowClinicDetails();
          } else {
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
                              context.pushNamed(Routes.addClinicScreenRoutes,
                                  arguments: {
                                    "action": 1,
                                    "clinicId": null,
                                  });
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
        } else if (state is GetDocHasClinicIsError) {
          return Container();
        }
        return Container();
      },
    );
  }
}

class ShowClinicDetails extends StatelessWidget {
  const ShowClinicDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          di.sl<PatientClinicCubit>()..getAllClinics(),
      child: BlocConsumer<PatientClinicCubit, PatientClinicState>(
        listener: (context, state) {},
        builder: (context, state) {
          var clinicName = CacheHelper.getData(key: 'clinicName');
          var token = CacheHelper.getData(key: 'token');
          Map<String, dynamic> data = Jwt.parseJwt(token);
          String docId = data[
              "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
          if (state is GetAllClinicIsSuccess) {
            Iterable<ClinicInfoModel> clinicInfoModel = state.clinicInfoModel
                .where((element) => element.doctorId == docId);
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
                          clinicInfoModel.first.name.toString(),
                          maxLines: 2,
                          style: TextStyles.font16BlackW500,
                        ),
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
                              context.pushNamed(
                                  Routes.docClinicDetailsScreenRoutes);
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
          return Container();
        },
      ),
    );
  }
}
