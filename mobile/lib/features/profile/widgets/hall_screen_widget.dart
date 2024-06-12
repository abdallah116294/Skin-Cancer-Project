import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/features/appointment/screen/appointment_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    var dotoctorRole = CacheHelper.getData(key: 'doctor_role');
    var clinic_price=CacheHelper.getData(key: 'clinic_price');
    var total_booking=CacheHelper.getData(key: 'total_booking');
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
        dotoctorRole != null ?  Text(
            "Dr: $name",
            style: TextStyles.font20BlackW700
                .copyWith(fontWeight: FontWeight.w600),
          ):  Text(
            name,
            style: TextStyles.font20BlackW700
                .copyWith(fontWeight: FontWeight.w600),
          ),
          dotoctorRole != null ? verticalSpacing(10) : SizedBox(),
          dotoctorRole != null
              ? Container(
                width: 233.0.w,
                padding: EdgeInsets.symmetric(horizontal: 10.w,),
                height: 25.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child:total_booking!=null ?Row(
                  children: [
                    Text("Total Booking :${total_booking??0}",style: TextStyles.font17BlackW500.copyWith(color: Colors.grey),),
                     Text("💲${clinic_price*total_booking??0}",style: TextStyles.font17BlackW500.copyWith(color: Colors.grey),)
                  ],
                  ):const  SizedBox(),
                )
              :const  SizedBox(),
          verticalSpacing(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                dotoctorRole != null
                    ? ProfileWidget(
                        backgroundColor: AppColor.primaryColor.withOpacity(.5),
                        iconPath: "assets/svgs/clinic_book.svg",
                        title: 'Appointments',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AppointmentScreen(
                                  //    uid: uid,
                                  )));
                        },
                      )
                    : ProfileWidget(
                        backgroundColor: const Color(0xFFE9FAEF),
                        iconPath: "assets/svgs/print.svg",
                        title: 'My Test & Diagnostic',
                        onTap: () {
                          context.pushNamed(Routes.aIHistoryScreen);
                        },
                      ),
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
                dotoctorRole != null
                    ? ProfileWidget(
                        onTap: () {
                          context
                              .pushNamed(Routes.docClinicDetailsScreenRoutes);
                        },
                        title: 'Clinic',
                        iconPath: 'assets/svgs/clinic_book.svg',
                        backgroundColor: AppColor.primaryColor.withOpacity(.5),
                      )
                    : ProfileWidget(
                        onTap: () {
                          context.pushNamed(Routes.patientSelectedClinic);
                        },
                        title: 'Booked Clinic',
                        iconPath: 'assets/svgs/clinic_book.svg',
                        backgroundColor: AppColor.primaryColor.withOpacity(.5),
                      ),
                ProfileWidget(
                  iconPath: "assets/svgs/developer.svg",
                  backgroundColor: Color(0xf0088ff),
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
