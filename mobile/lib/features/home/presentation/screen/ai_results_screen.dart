import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:mobile/features/home/presentation/screen/doctors_check_screen.dart';
import 'package:mobile/features/home/presentation/widgets/ai_result_widget.dart';
import 'package:mobile/injection_container.dart' as di;

class AIResultsScreen extends StatefulWidget {
  const AIResultsScreen({super.key, required this.uid});
  final String uid;
  @override
  State<AIResultsScreen> createState() => _AIResultsScreenState();
}

class _AIResultsScreenState extends State<AIResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AI Result",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: BlocProvider(
        create: (context) => di.sl<HomeCubit>()..getAiresult(widget.uid),
        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          if (state is GetAIResultIsLoading) {
            return Column(
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          } else if (state is GetAIResultLoaded) {
            return ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DoctorCheckAndSendNotesScreen(
                                      image: state
                                          .aiResultEntity[index].imageUrl
                                          .toString(),
                                      output: state.aiResultEntity[index].output
                                          .toString(),
                                      uid: widget.uid,
                                    )));
                      },
                      child: AIResultWidget(
                        image: state.aiResultEntity[index].imageUrl.toString(),
                        output: state.aiResultEntity[index].output.toString(),
                      ));
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: state.aiResultEntity.length);
          } else if (state is GetAIResultError) {
            return Column(
              children: [
                Center(
                  child: Text(state.error,style: const TextStyle(color: Colors.black,fontSize: 33),),
                )
              ],
            );
          }
          return Column(
            children: [
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        }),
      ),
    );
  }
}
