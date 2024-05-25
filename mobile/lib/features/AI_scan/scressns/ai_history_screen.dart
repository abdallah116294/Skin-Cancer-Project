import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/features/AI_scan/cubit/ai_perediction_cubit.dart';
import 'package:mobile/features/AI_scan/scressns/widget/ai_history_widget.dart';
import 'package:mobile/injection_container.dart' as di;

import '../../../core/cach_helper/cach_helper.dart';

class AiHistoryScreen extends StatelessWidget {
  const AiHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String patientId = data[
    "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];

    return Scaffold(
      body: BlocProvider(
        create: (context) => di.sl<AiPeredictionCubit>()..getAiHistory(patientId),
        child: BlocConsumer<AiPeredictionCubit, AiPeredictionState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            if (state is GetAiHistoryResultSuccess){
              if(state.aiHistory.isEmpty)
              {
                return Center(
                  child: Lottie.asset('assets/animation/empty.json'),
                );
              }else{
                return Column(
                  children: [
                    Expanded(
                        child: ListView.separated(itemBuilder: (context, index) {
                          return AIResultWidget(
                            image:state.aiHistory[index].imagePath.toString(),
                            output: state.aiHistory[index].result.toString(),
                          );
                        },
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: state.aiHistory.length))
                  ],
                );
              }

            }
            return const Column(
              children: [
                SizedBox()
              ],
            );

          },
        ),
      ),
    );
  }
}
