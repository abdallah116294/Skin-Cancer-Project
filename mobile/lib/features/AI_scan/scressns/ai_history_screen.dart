import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/features/AI_scan/cubit/ai_perediction_cubit.dart';
import 'package:mobile/features/AI_scan/scressns/widget/ai_history_widget.dart';
import 'package:mobile/injection_container.dart' as di;

import '../../../core/cach_helper/cach_helper.dart';

class AiHistoryScreen extends StatefulWidget {
  //String userId=" ";
  AiHistoryScreen({
    super.key,
  });

  @override
  State<AiHistoryScreen> createState() => _AiHistoryScreenState();
}

class _AiHistoryScreenState extends State<AiHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    var doctorrole = CacheHelper.getData(key: 'doctor_role');
    String actualpatientId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        title: const Text(
          "Ai History",
        ),
      ),

      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) =>
            di.sl<AiPeredictionCubit>()..getAiHistory(actualpatientId),
        child: BlocConsumer<AiPeredictionCubit, AiPeredictionState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetAiHistoryResultLoading) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: CireProgressIndecatorWidget())],
              );
            } else if (state is GetAiHistoryResultSuccess) {
              if (state.aiHistory.isEmpty) {
                return Center(
                  child: Lottie.asset('assets/animation/empty.json'),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 30.h),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.aiHistory.length,
                            itemBuilder: (context, index) {
                              return AIResultWidget(
                                  image: state.aiHistory[index].imagePath
                                      .toString(),
                                  output: state.aiHistory[index].result
                                      .toString(),
                                  onTap: () {
                                    context.pushNamed(
                                        Routes.aIItemHistoryDetailsScreen,
                                        arguments: {
                                          "image": state
                                              .aiHistory[index].imagePath
                                              .toString(),
                                          "result": state
                                              .aiHistory[index].result
                                              .toString(),
                                          "date": state
                                              .aiHistory[index].date
                                              .toString(),
                                          "diagnosis": state
                                              .aiHistory[index].diagnosis
                                              .toString(),
                                          "id": state.aiHistory[index].id
                                        });
                                  });
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: .78),
                          )),
                    ],
                  ),
                );
              }
            }
            return const Column(
              children: [SizedBox()],
            );
          },
        ),
      ),
    );
  }
}
