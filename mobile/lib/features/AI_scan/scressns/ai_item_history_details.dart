import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
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
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "The Result Would be\n" + widget.outpus['result'],
                      style: TextStyles.font20whiteW700
                          .copyWith(color: Colors.red),
                    ),
                    Text(DateConverter.getDateTimeWithMonth(dateTime)),
                  ],
                ),
                verticalSpacing(10),
                Container(
                    height: 200.h,
                    child: Image.network(
                      widget.outpus['image'],
                      fit: BoxFit.cover,
                    )),
                verticalSpacing(60),
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
                              .copyWith(color: Colors.red),
                        ))
                    : Expanded(
                      child: Container(
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
                    ),
                Spacer(),
                doctorrole != null
                    ? AppButton(
                        buttonColor: AppColor.primaryColor,
                        width: 150,
                        height: 60,
                        buttonName: 'Add Dignosis',
                        onTap: () {
                          DailogAlertFun.showaddDignosis(
                              actionName: 'Add Dignosis',
                              context: context,
                              onTap: () {
                                di
                                    .sl<AiPeredictionCubit>()
                                    .addDiagonosis(widget.outpus['id'],
                                        controller.text, token)
                                    .then((value) {
                                  context
                                      .pushReplacementNamed(Routes.bottomNavScreenRoutes);
                                });
                              },
                              controller: controller);
                        },
                        textColor: Colors.white,
                        white: true)
                    : const SizedBox()
              ],
            );
          },
        ),
      ),
    );
  }
}
