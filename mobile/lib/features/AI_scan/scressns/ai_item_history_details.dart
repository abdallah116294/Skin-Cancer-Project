import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/date_converter.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/features/AI_scan/cubit/ai_perediction_cubit.dart';
import 'package:mobile/features/AI_scan/scressns/widget/expanded_text_widget.dart';
import 'package:mobile/features/Auth/widgets/double_text.dart';
import 'package:mobile/injection_container.dart' as di;

class AIItemHistoryDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> outpus;

  const AIItemHistoryDetailsScreen({super.key, required this.outpus});

  @override
  State<AIItemHistoryDetailsScreen> createState() =>
      _AIItemHistoryDetailsScreenState();
}

class _AIItemHistoryDetailsScreenState
    extends State<AIItemHistoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.outpus["date"]);
    var doctorrole = CacheHelper.getData(key: 'doctor_role');
    TextEditingController controller = TextEditingController();
    var token = CacheHelper.getData(key: 'token');
    return BlocProvider(
      create: (context) => di.sl<AiPeredictionCubit>(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.white,
          title: const Text(
            "History Details",
          ),
        ),
        body: BlocConsumer<AiPeredictionCubit, AiPeredictionState>(
          listener: (context, state) {
            if (state is AddDiagonosisSucessState) {
              DailogAlertFun.showMyDialog(
                  daliogContent: state.result.toString(),
                  actionName: "Go Back",
                  context: context,
                  onTap: () {
                    context.pushReplacementNamed(Routes.bottomNavScreenRoutes);
                  });
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("AI detection result",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                            ),),
                          Text(widget.outpus['result'],
                              style: TextStyles.font20whiteW700
                                  .copyWith(color: AppColor.primaryColor,
                               ),
                          ),
                        ],
                      ),

                      verticalSpacing(10),
                      Center(
                        child: Container(
                            clipBehavior: Clip.antiAlias,
                            height: 200.h,
                            width: 320.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Image.network(
                              widget.outpus['image'],
                              fit: BoxFit.cover,
                            )),
                      ),
                      verticalSpacing(10),
                      Row(
                        children: [
                          Text("Scan Time : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                          ),),
                          Text(DateConverter.getDateTimeWithMonth(dateTime),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.primaryColor
                          ),),
                        ],
                      ),
                      verticalSpacing(10),
                      widget.outpus['diagnosis'].isEmpty
                          ? Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 5.0,
                                        spreadRadius: 0.0)
                                  ]),
                              child: Text(
                                'There is No Diagnosis Right Know',
                                style: TextStyles.font20whiteW700
                                    .copyWith(color: Colors.black),
                              ))

                              : Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 5.0,
                                            spreadRadius: 0.0)
                                      ]),
                                  child: Text(widget.outpus['diagnosis'])),
                      // Spacer(),
                      verticalSpacing(250),
                      doctorrole != null
                          ? AppButton(
                              buttonColor: AppColor.primaryColor,
                              width: 300,
                              height: 60,
                              buttonName: 'Add Diagnosis',
                              onTap: () {
                                DailogAlertFun.showaddDignosis(

                                    actionName: 'Add Diagnosis',
                                    context: context,
                                    onTap: () {
                                      di
                                          .sl<AiPeredictionCubit>()
                                          .addDiagonosis(widget.outpus['id'],
                                              controller.text, token)
                                          .then((value) {
                                        context.pushReplacementNamed(
                                            Routes.bottomNavScreenRoutes);
                                      });
                                    },
                                    controller: controller);
                              },
                              textColor: Colors.white,
                              white: true)
                          : const SizedBox()
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
