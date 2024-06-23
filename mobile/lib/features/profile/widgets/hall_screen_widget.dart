import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/features/appointment/screen/appointment_screen.dart';
import 'package:mobile/features/clinic/cubit/clinic_cubit.dart';
import 'package:mobile/features/clinic/data/model/selected_clinic_model.dart';
import 'package:mobile/features/payments/screens/register_to_payment.dart';
import 'package:mobile/features/profile/widgets/profile_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mobile/injection_container.dart' as di;
import 'package:qr_flutter/qr_flutter.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/widgets/custom_dailog.dart';
import '../../QR_code/screen/qr_code_screen.dart';

class HallProfileScreenWidget extends StatefulWidget {
  const HallProfileScreenWidget({
    super.key,
    // required this.imagUrl,
    required this.name,
    //required this.uid,
    //  required this.num,
  });

  final String name;

  @override
  State<HallProfileScreenWidget> createState() =>
      _HallProfileScreenWidgetState();
}

class _HallProfileScreenWidgetState extends State<HallProfileScreenWidget> {
  String? _rseult;
  void setResult(String result) {
    setState(() => _rseult = result);
    log(_rseult.toString());
  }

  void _showQRCodeDialog(BuildContext context, String data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('QR Code'),
          content: QrImageView(
            data: data,
            version: QrVersions.auto,
            size: 200.0,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var dotoctorRole = CacheHelper.getData(key: 'doctor_role');
    var clinic_price = CacheHelper.getData(key: 'clinic_price');
    var total_booking = CacheHelper.getData(key: 'total_booking');
    var clinicid = CacheHelper.getData(key: 'clinic_id');
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String patientId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    if (dotoctorRole != null)
    {
      if (clinicid == null) {
        return Center(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200.h,
                    width: 407.w,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  Positioned(
                    top: 140.h,
                    left: MediaQuery.of(context).size.width / 3.2,
                    child: CircleAvatar(
                      radius: 70.r,
                      backgroundColor: Colors.white,
                      child: Image.asset("assets/image/profile.png"),
                    ),
                  ),
                ],
              ),
              verticalSpacing(90.h),
              Card(
                color: Colors.white.withOpacity(.99),
                child: Padding(
                  padding:  EdgeInsets.all(10.w),
                  child: Column(
                    children: [
                      Text(
                        "Dr: ${widget.name}",
                        style: TextStyles.font20BlackW700
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),

              verticalSpacing(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                     ProfileWidget(
                      backgroundColor:const Color(0xFFE9FAEF),
                      iconPath: "assets/svgs/calendar.svg",
                      title: 'Appointments',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                            const AppointmentScreen(
                              //    uid: uid,
                            )));
                      },
                    ),

                     ProfileWidget(
                      onTap: () {
                        context.pushNamed(
                            Routes.docClinicDetailsScreenRoutes);
                      },
                      title: 'Clinic',
                      iconPath: 'assets/svgs/clinic_icon.svg',
                      backgroundColor:Color(0xFFFFEAFF),
                    ),


                         ProfileWidget(
                      iconPath: "assets/svgs/qrcode.svg",
                      backgroundColor: const Color(0xf0088ff),
                      onTap: () {

                      },
                      title: 'Scan Qr ',
                    ),
                    ProfileWidget(
                      iconPath: "assets/svgs/developer.svg",
                      backgroundColor: const Color(0xFFFFFFFF),
                      onTap: () {
                        context.pushNamed(Routes.developerScreen);
                      },
                      title: 'Developer',
                    ),
                    ProfileWidget(
                      title: 'Log out',
                      onTap: () {
                        DailogAlertFun.showMyDialog(
                            daliogContent: "Are you sure?",
                            actionName: "Logout",
                            context: context,
                            onTap: () {
                              CacheHelper.removeData(key: 'token');
                              CacheHelper.removeData(key: 'email');
                              if (dotoctorRole != null) {
                                CacheHelper.removeData(key: 'doctor_role');
                              }
                              context.pushNamedAndRemoveUntil(
                                  Routes.choseUserRoutes,
                                  predicate: (Route<dynamic> route) =>
                                  false);
                            });
                      },
                      iconPath: 'assets/svgs/logout.svg',
                      backgroundColor: const Color(0xFFFFEEEF),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
      else{
 return BlocProvider(
        create: (context) =>
            di.sl<ClinicCubit>()..getClinicAppointments(clinicid),
        child: BlocConsumer<ClinicCubit, ClinicState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 200.h,
                        width: 407.w,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      Positioned(
                        top: 140.h,
                        left: MediaQuery.of(context).size.width / 3.2,
                        child: CircleAvatar(
                          radius: 70.r,
                          backgroundColor: Colors.white,
                          child: Image.asset("assets/image/profile.png"),
                        ),
                      ),
                    ],
                  ),
                  verticalSpacing(90.h),
                      Card(
                    color: Colors.white.withOpacity(.99),
                        child: Padding(
                          padding:  EdgeInsets.all(10.w),
                          child: Column(
                            children: [
                              Text(
                                  "Dr: ${widget.name}",
                                  style: TextStyles.font20BlackW700
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              Text(
                                "Total Booking :${total_booking ?? 0}",
                                style: TextStyles.font17BlackW500
                                    .copyWith(color: Colors.grey),
                              ),
                              Text(
                                "💲${clinic_price * total_booking ?? 0}",
                                style: TextStyles.font17BlackW500
                                    .copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),



                  verticalSpacing(5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      children: [
                       ProfileWidget(
                                backgroundColor:
                                    Color(0xFFE9FAEF),
                                iconPath: "assets/svgs/calendar.svg",
                                title: 'Appointments',
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const AppointmentScreen(
                                              //    uid: uid,
                                              )));
                                },
                              ),

                         ProfileWidget(
                                onTap: () {
                                  context.pushNamed(
                                      Routes.docClinicDetailsScreenRoutes);
                                },
                                title: 'Clinic',
                                iconPath: 'assets/svgs/clinic_icon.svg',
                                backgroundColor:
                                Color(0xFFFFEAFF),

                         ),

                         state is GetSelectedClinicIsSuccess
                                ? ProfileWidget(
                                    iconPath: "assets/svgs/qrcode.svg",
                                    backgroundColor: Color(0xf0088ff),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QrCodeScanner(
                                                  selectedClinicModel:
                                                      state.selectedClinic,
                                                  setResult: setResult,
                                                )),
                                      );
                                    },
                                    title: 'Scan Qr ',
                                  ):ProfileWidget(
                           iconPath: "assets/svgs/qrcode.svg",
                           backgroundColor: Color(0xf0088ff),
                           onTap: () {

                           },
                           title: 'Scan Qr ',
                         ) ,

                        ProfileWidget(
                          iconPath: "assets/svgs/developers.svg",
                          backgroundColor: const Color(0xFFEAF2FF),
                          onTap: () {
                            context.pushNamed(Routes.developerScreen);
                          },
                          title: 'Developer',
                        ),
                        ProfileWidget(
                          title: 'Log out',
                          onTap: () {
                            DailogAlertFun.showMyDialog(
                                daliogContent: "Are you sure?",
                                actionName: "Logout",
                                context: context,
                                onTap: () {
                                  CacheHelper.removeData(key: 'token');
                                  CacheHelper.removeData(key: 'email');
                                  if (dotoctorRole != null) {
                                    CacheHelper.removeData(key: 'doctor_role');
                                  }
                                  context.pushNamedAndRemoveUntil(
                                      Routes.choseUserRoutes,
                                      predicate: (Route<dynamic> route) =>
                                          false);
                                });
                          },
                          iconPath: 'assets/svgs/logout.svg',
                          backgroundColor: const Color(0xFFFFEEEF),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    
      }
     
    }
    else {
      return Center(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200.h,
                  width: 407.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColor.primaryColor,
                  ),
                ),
                Positioned(
                  top: 140.h,
                  left: MediaQuery.of(context).size.width / 3.2,
                  child: CircleAvatar(
                    radius: 70.r,
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/image/profile.png"),
                  ),
                ),
              ],
            ),
            verticalSpacing(90.h),
                Text(
                    widget.name,
                    style: TextStyles.font20BlackW700
                        .copyWith(fontWeight: FontWeight.w600),
                  ),

            verticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  ProfileWidget(
                    backgroundColor: const Color(0xFFE9FAEF),
                    iconPath: "assets/svgs/print.svg",
                    title: 'My Test & Diagnostic',
                    onTap: () {
                      context.pushNamed(Routes.aIHistoryScreen);
                    },
                  ),
                  ProfileWidget(
                    onTap: () {
                      context.pushNamed(Routes.patientSelectedClinic);
                    },
                    title: 'Booked Clinic',
                    iconPath: 'assets/svgs/clinic_icon.svg',
                    backgroundColor: const Color(0XffFFEAFF),
                  ),
                  ProfileWidget(
                    iconPath: "assets/svgs/qrcode.svg",
                    backgroundColor: const Color(0x0f0088ff),
                    onTap: () {
                      _showQRCodeDialog(context, patientId);
                    },
                    title: 'QR Code',
                  ),
                  ProfileWidget(
                    iconPath: "assets/svgs/developers.svg",
                    backgroundColor: const Color(0xFFEAF2FF),
                    onTap: () {
                      context.pushNamed(Routes.developerScreen);
                    },
                    title: 'Developer',
                  ),
                  ProfileWidget(
                    title: 'Log out',
                    onTap: () {
                      DailogAlertFun.showMyDialog(
                          daliogContent: "Are you sure?",
                          actionName: "Logout",
                          context: context,
                          onTap: () {
                            CacheHelper.removeData(key: 'token');
                            CacheHelper.removeData(key: 'email');
                            if (dotoctorRole != null) {
                              CacheHelper.removeData(key: 'doctor_role');
                            }
                            context.pushNamedAndRemoveUntil(
                                Routes.choseUserRoutes,
                                predicate: (Route<dynamic> route) => false);
                          });
                    },
                    iconPath: 'assets/svgs/logout.svg',
                    backgroundColor: const Color(0xFFFFEEEF),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
