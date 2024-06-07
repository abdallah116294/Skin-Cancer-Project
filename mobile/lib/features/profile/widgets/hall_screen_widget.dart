import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/features/payments/screens/register_to_payment.dart';
import 'package:mobile/features/profile/widgets/profile_widget.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/widgets/custom_dailog.dart';

class HallProfileScreenWidget extends StatelessWidget {
  const HallProfileScreenWidget({
    super.key,
    // required this.imagUrl,
    required this.name,
    //required this.uid,
    //  required this.num,
  });

  final String name;

  // final String imagUrl;
  // final String uid;
  // final int num;
  @override
  Widget build(BuildContext context) {
    var dotoctorRole = CacheHelper.getData(key: 'doctor_role');
    return Column(
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
        verticalSpacing(100.h),
        Text(
          name,
          style:
              TextStyles.font20BlackW700.copyWith(fontWeight: FontWeight.w600),
        ),
        verticalSpacing(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              // dotoctorRole != null
              //     ? ProfileWidget(
              //         leading: const Icon(
              //             color: Color(0xFF6671EB), Icons.calendar_month),
              //         title: 'Appointments',
              //         onTap: () {
              //           Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) => const AppointmentScreen(
              //                   //    uid: uid,
              //                   )));
              //         },
              //       )
              //     :
              ProfileWidget(
                backgroundColor: const Color(0xFFE9FAEF),
                iconPath: "assets/svgs/print.svg",
                title: 'My Test & Diagnostic',
                onTap: () {
                  context.pushNamed(Routes.aIHistoryScreen);
                },
              ),

              // ProfileWidget(
              //   leading: Icon(color: Color(0xFF6671EB), Icons.favorite),
              //   title: 'Favorites',
              // ),
              // dotoctorRole == null?
              //     :
              // ProfileWidget(
              //         onTap: () {
              //           context
              //               .pushNamed(Routes.docClinicDetailsScreenRoutes);
              //           // Navigator.push(
              //           //     context,
              //           //     MaterialPageRoute(
              //           //         builder: (context) => ClinicDoctorDetials(
              //           //               uid: uid,
              //           //             )));
              //         },
              //         leading: const Icon(
              //             color: Color(0xFF6671EB),
              //             Icons.local_hospital_rounded),
              //         title: 'My Clinic',
              //       ),
              ProfileWidget(
                title: 'Payment Method',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPayment()));
                },
                iconPath: 'assets/svgs/payment.svg',
                backgroundColor: Color(0xFFFFEEEF),
              ),
              ProfileWidget(
                onTap: () {
                  context.pushNamed(Routes.patientSelectedClinic);
                },
                title: 'Booked Clinic',
                iconPath: 'assets/svgs/clinic_book.svg',
                backgroundColor: AppColor.primaryColor.withOpacity(.5),
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
                        context.pushNamedAndRemoveUntil(Routes.choseUserRoutes,
                            predicate: (Route<dynamic> route) => false);
                      });
                },
                iconPath: 'assets/svgs/logout.svg',
                backgroundColor: const Color(0xFFFFEEEF),
              ),
              // ProfileWidget(
              //   onTap: () {
              //     context.pushNamed(Routes.developerScreen);
              //     // Navigator.push(
              //     //     context, MaterialPageRoute(builder: (context)=>const DeveloperScreen()));
              //   },
              //   leading: const Icon(
              //       color: Color(0xFF6671EB), Icons.developer_mode),
              //   title: 'Developer',
              // ),
              // ProfileWidget(
              //   onTap: () {
              //     DailogAlertFun.showMyDialog(
              //         daliogContent: "Are you sure?",
              //         actionName: "Logout",
              //         context: context,
              //         onTap: () {
              //           CacheHelper.removeData(key: 'token');
              //           CacheHelper.removeData(key: 'email');
              //           if (dotoctorRole != null) {
              //             CacheHelper.removeData(key: 'doctor_role');
              //           }
              //           context.pushNamedAndRemoveUntil(
              //               Routes.choseUserRoutes,
              //               predicate: (Route<dynamic> route) => false);
              //         });
              //   },
              //   leading: const Icon(
              //       color: Color(0xFF6671EB), Icons.lock_outline_rounded),
              //   title: 'Log out',
              //   iconPath: '',
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
