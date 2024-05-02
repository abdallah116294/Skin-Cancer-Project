import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/Auth/data/model/prescription_model.dart';
import 'package:mobile/features/Auth/domain/entities/prescription_entity.dart';
import 'package:mobile/features/Auth/presentation/widgets/about_text_formfiled.dart';
import 'package:mobile/features/Auth/presentation/widgets/custom_text_feild.dart';
import 'package:mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:mobile/features/home/presentation/widgets/ai_result_widget.dart';
import 'package:mobile/features/home/presentation/widgets/prescription_item_widget.dart';
import 'package:mobile/injection_container.dart' as di;

class DoctorCheckAndSendNotesScreen extends StatefulWidget {
  DoctorCheckAndSendNotesScreen({
    super.key,
    required this.image,
    required this.output,
    required this.uid,
  });
  final String image, output, uid;

  @override
  State<DoctorCheckAndSendNotesScreen> createState() =>
      _DoctorCheckAndSendNotesScreenState();
}

class _DoctorCheckAndSendNotesScreenState
    extends State<DoctorCheckAndSendNotesScreen> {
  final checoutController = TextEditingController();
final _controller = ScrollController();
  // final resultCollectionRef =
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prescriptionCollection = FirebaseFirestore.instance
        .collection("patient")
        .doc(widget.uid)
        .collection('prescription')
        .snapshots();
    return Scaffold(
      body: BlocProvider(
        create: (context) => di.sl<HomeCubit>(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is ChcekoutSendOk) {
              log("done");
            } else if (state is ChcekoutSendError) {
              log(state.error);
            }
          },
          builder: (context, state) {
         return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                AIResultWidget(
                  image: widget.image,
                  output: widget.output,
                ),
                const Spacer(),
                AboutTextFormFiled(
                  controller: checoutController,
                  onPresed: () {},
                  inputFiled: "Enter The prescription",
                  isObscureText: false,
                  textInputType: TextInputType.text,
                ),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<HomeCubit>(context)
                          .addprescription(
                              widget.uid,
                              checoutController.text,
                              widget.output,
                              PrescriptionEntity(
                                  aiUid: widget.uid,
                                  prescription: checoutController.text,
                                  imageUrl: widget.image,
                                  output: widget.output,
                                  uid: ""))
                          .then((value) {
                        // checoutController.clear();
                      });
                    },
                    icon: const Icon(Icons.send)),
              ],
            );
         
          },
        ),
      ),
    );
  }
}
