import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/utils/extention.dart';
import 'package:mobile/core/utils/spacer.dart';
import 'package:mobile/core/utils/text_styels.dart';
import 'package:mobile/features/Auth/presentation/auth_cubit.dart';
import 'package:mobile/features/home/presentation/screen/ai_results_screen.dart';
import 'package:mobile/features/home/presentation/screen/appointment_screen.dart';
import 'package:mobile/features/home/presentation/screen/clinic_doctor_details_screen.dart';
import 'package:mobile/features/home/presentation/screen/selected_clinic_screen.dart';
import 'package:mobile/features/onBoarding/screens/developer_screen.dart';
import 'package:mobile/features/onBoarding/screens/on_boarding_screen.dart';
import 'package:mobile/features/payments/screens/register_to_payment.dart';
import 'package:mobile/features/profile/widget/profiel_widget.dart';

class HallProfileScreenWidget extends StatelessWidget {
  const HallProfileScreenWidget({
    super.key,
    required this.imagUrl,
    required this.name,
    required this.uid,
    required this.num,
  });
  final String name;
  final String imagUrl;
  final String uid;
  final int num;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignoutSuccess) {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => const OnBoardingScreen()));
          SystemNavigator.pop();
        }
      },
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 227.h,
                    width: 407.w,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(120.w),
                        bottomRight: Radius.circular(120.w),
                      ),
                    ),
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/skinyapp.appspot.com/o/Gemini_Generated_Image%20(1).jpg?alt=media&token=67b6e86d-3d12-4a57-9a7f-da02ab39f681",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 70.h,
                    left: 20.w,
                    child: InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        height: 42.h,
                        width: 42.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: const Color(0xFFC1C6F6).withOpacity(.8),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.only(left: 8.w),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF424DC1),
                          size: 24.0, // Adjust the size as needed
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150.h,
                    left: MediaQuery.of(context).size.width / 4.w,
                    child: CircleAvatar(
                      radius: 80.r,
                      backgroundImage: NetworkImage(imagUrl),
                    ),
                  ),
                  Positioned(
                      top: 290.h,
                      left: 175.w,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 28,
                          color: Color(0xFF424ECA),
                        ),
                      )),
                ],
              ),
              verticalSpacing(110.h),
              Text(
                name,
                style: TextStyles.font20BlackW700
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              verticalSpacing(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    // ProfileWidget(
                    //   leading: Icon(color: Color(0xFF6671EB), Icons.person),
                    //   title: 'Your profile',
                    // ),
                    num == 1
                        ? ProfileWidget(
                            leading: const Icon(
                                color: Color(0xFF6671EB), Icons.calendar_month),
                            title: 'Appointments',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AppointmentScreen(
                                        uid: uid,
                                      )));
                            },
                          )
                        : ProfileWidget(
                            leading: const Icon(
                                color: Color(0xFF6671EB), Icons.history),
                            title: 'AI history',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AIResultsScreen(
                                        uid: uid,
                                      )));
                            },
                          ),
                    // ProfileWidget(
                    //   leading: Icon(color: Color(0xFF6671EB), Icons.favorite),
                    //   title: 'Favorites',
                    // ),
                    num == 0
                        ? ProfileWidget(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SelectedClinicScreen(uid: uid)));
                            },
                            leading: const Icon(
                                color: Color(0xFF6671EB),
                                Icons.local_hospital_rounded),
                            title: 'Selected Clinic',
                          )
                        : ProfileWidget(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ClinicDoctorDetials(
                                            uid: uid,
                                          )));
                            },
                            leading: const Icon(
                                color: Color(0xFF6671EB),
                                Icons.local_hospital_rounded),
                            title: 'My Clinic',
                          ),
                    ProfileWidget(
                      leading: const Icon(
                          color: Color(0xFF6671EB), Icons.credit_card),
                      title: 'Payment Method',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPayment()));
                      },
                    ),
                    ProfileWidget(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context)=>const DeveloperScreen()));
                      },
                      leading: const Icon(
                          color: Color(0xFF6671EB), Icons.developer_mode),
                      title: 'Developer',
                    ),
                    ProfileWidget(
                      onTap: () {
                        BlocProvider.of<AuthCubit>(context)
                            .userSignout()
                            .then((value) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OnBoardingScreen()));
                        });
                      },
                      leading: const Icon(
                          color: Color(0xFF6671EB), Icons.lock_outline_rounded),
                      title: 'Log out',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
