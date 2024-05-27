import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/features/AI_scan/cubit/ai_perediction_cubit.dart';
import 'package:mobile/features/AI_scan/scressns/widget/ai_history_widget.dart';
import 'package:mobile/injection_container.dart' as di;

import '../../../core/cach_helper/cach_helper.dart';

class AiHistoryScreen extends StatefulWidget {
   //String userId=" ";
   AiHistoryScreen({super.key,  });

  @override
  State<AiHistoryScreen> createState() => _AiHistoryScreenState();
}

class _AiHistoryScreenState extends State<AiHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    var doctorrole = CacheHelper.getData(key: 'doctor_role');
    String actualpatientId =  data[
            "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    return Scaffold(
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
                return Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  context.pushNamed(
                                      Routes.aIItemHistoryDetailsScreen,
                                      arguments: {
                                        "image": state
                                            .aiHistory[index].imagePath
                                            .toString(),
                                        "result": state.aiHistory[index].result
                                            .toString(),
                                        "date": state.aiHistory[index].date
                                            .toString(),
                                        "diagnosis": state
                                            .aiHistory[index].diagnosis
                                            .toString(),
                                        "id": state.aiHistory[index].id
                                      });
                                },
                                child: AIResultWidget(
                                  image: state.aiHistory[index].imagePath
                                      .toString(),
                                  output:
                                      state.aiHistory[index].result.toString(),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: state.aiHistory.length))
                  ],
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
