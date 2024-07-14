import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/features/explore/cubit/patient_cubit_cubit.dart';
import 'package:mobile/injection_container.dart' as di;

class OrderDetailsScreen extends StatefulWidget {
  OrderDetailsScreen({super.key, required this.orderdetails});
  // final String clinicName;
  // final int clinicPrice;
  // final int rate;
  // final String date;
  Map<String, dynamic> orderdetails;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
        var token = CacheHelper.getData(key: 'token');

    var dotoctorRole = CacheHelper.getData(key: 'doctor_role');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String patientId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    return BlocProvider(
      create: (context) => di.sl<PatientClinicCubit>(),
      child: BlocConsumer<PatientClinicCubit, PatientClinicState>(
        listener: (context, state) {
          if (state is PaymentOrderSuccess) {
            context.pushNamed(Routes.paymentWebView,
                arguments: state.paymentResponse.url);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Appointment Details",
                style: TextStyles.font17BlackW500,
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              elevation: 0,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 318.w,
                        height: 85.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/image/start_screen_2.png"),
                                    radius: 30.r,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //clinic name
                                  Text(
                                    widget.orderdetails['clinic_name'],
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  //clinic rate
                                  Text(
                                    "${widget.orderdetails['rate']}⭐",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpacing(10),
                    Text(
                      'Date',
                      style: TextStyles.font20BlackW700,
                    ),
                    verticalSpacing(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: AppColor.primaryColor,
                          ),
                          child: Center(
                            child: SvgPicture.asset("assets/image/date.svg"),
                          ),
                        ),
                        //selected data
                        Text(
                          '${widget.orderdetails['selected_date']}',
                          style: TextStyles.font20GreyW700,
                        )
                      ],
                    ),
                    verticalSpacing(10),
                    Divider(),
                    verticalSpacing(10),
                    Text(
                      "Payment Details",
                      style: TextStyles.font20BlackW700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Appointment",
                          style: TextStyles.font20BlackW700
                              .copyWith(color: AppColor.primaryColor),
                        ),
                        //clinic price
                        Text(
                          "💲${widget.orderdetails['clinic_price']}",
                          style: TextStyles.font20BlackW700,
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Toatal",
                              style: TextStyles.font20GreyW700,
                            ),
                            Text(
                              "${widget.orderdetails['clinic_price']}",
                              style: TextStyles.font26BlackW700
                                  .copyWith(color: AppColor.primaryColor),
                            )
                          ],
                        ),
                        state is PaymentOrderLoading
                            ? const CireProgressIndecatorWidget()
                            : AppButton(
                                buttonColor: AppColor.primaryColor,
                                width: 217.w,
                                height: 46,
                                buttonName: "Pay Now",
                                onTap: () {
                                  context
                                      .read<PatientClinicCubit>()
                                      .patientPaymentOrder(
                                          clinicId:
                                              widget.orderdetails['clinic_id'],
                                          patientId:
                                              patientId,
                                          scheduleId: widget
                                              .orderdetails['selectedIndex']);
                                },
                                textColor: Colors.white,
                                white: false),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
