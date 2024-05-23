import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/features/AI_scan/cubit/ai_perediction_cubit.dart';
import 'package:mobile/injection_container.dart' as di;

class AIScanScreen extends StatefulWidget {
  const AIScanScreen({super.key});

  @override
  State<AIScanScreen> createState() => _AIScanScreenState();
}

class _AIScanScreenState extends State<AIScanScreen> {
  bool _loading = true;
  late File _image;
  List? _output;
  final picker = ImagePicker();
  // detectImage(File image) async {
  //   log("detect image");
  //   var output = await Tflite.runModelOnImage(
  //       path: image.path,
  //       numResults: 7,
  //       threshold: 0.6,
  //       imageMean: 1.0,
  //       imageStd: 1.0);
  //   log(output.toString());
  //   setState(() {
  //     _output = output;
  //     _loading = false;
  //   });
  // }

  // loadModel() async {
  //   log("load Model");
  //   Tflite.loadModel(
  //     model: 'assets/EfficientNetB0_model.tflite',
  //     labels: 'assets/labels.txt',
  //     isAsset: true,
  //   );
  // }

  Future pickImage() async {
    log("pick image");
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      return null;
    }
    setState(() {
      _image = File(image!.path);
    });
    //  detectImage(_image);
  }

  String userImageUrl = '';
  Future pickGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
      _loading = false;
    });
    log(image.path.toString());
    // detectImage(_image);
  }

  // Future<String> uploadImage() async {
  //   if (widget.num == 0) {
  //     final ref = FirebaseStorage.instance
  //         .ref()
  //         .child("patient")
  //         .child('aiResult')
  //         .child("${widget.num}.jpg");
  //     await ref.putFile(File(_image.path));
  //     final downloadURl = await ref.getDownloadURL();
  //     setState(() {
  //       userImageUrl = downloadURl;
  //     });
  //     return userImageUrl;
  //   } else if (widget.num == 1) {
  //     final ref = FirebaseStorage.instance
  //         .ref()
  //         .child("doctor")
  //         .child('aiResult')
  //         .child("${widget.uid.trim()}.jpg");
  //     await ref.putFile(File(_image.path));
  //     final downloadURl = await ref.getDownloadURL();
  //     setState(() {
  //       userImageUrl = downloadURl;
  //     });
  //     return userImageUrl;
  //   }
  //   return userImageUrl;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadModel().then((value) {
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => di.sl<AiPeredictionCubit>(),
        child: BlocConsumer<AiPeredictionCubit, AiPeredictionState>(
          listener: (context, state) {
            if (state is PeredictonSkinOrNotIsloading) {
              log('loading');
            } else if (state is PeredictonSkinOrNotIsSuccess) {
              if (state.peredictionModel.prediction == "Not Skin") {
                DailogAlertFun.showMyDialog(
                    daliogContent: "Pleas Enter Skin Image",
                    actionName: 'Go Back',
                    context: context,
                    onTap: () {
                      context.pop();
                    });
              } else if (state.peredictionModel.prediction == 'Skin') {
                context.read<AiPeredictionCubit>().peredictonCancerType(_image);
              }
            } else if (state is PeredictonSkinOrNotIsError) {
              log(state.error);
            }
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upload a photo of your skin lesion",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      " Our AI will detect potential skin cancer type",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: _loading
                          ? Container(
                              width: 356.w,
                              child: Column(children: [
                                Image.asset(
                                  "assets/image/ai_scan.png",
                                  width: 356.w,
                                  height: 581.h,
                                ),
                                SizedBox(
                                  height: 20.h,
                                )
                              ]),
                            )
                          : Container(
                              child: Column(children: [
                                Container(
                                  width: 356.w,
                                  height: 400.h,
                                  child: Image.file(_image),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                BlocBuilder<AiPeredictionCubit,
                                        AiPeredictionState>(
                                    builder: (context, state) {
                                  if (state is PeredictonSkinOrNotIsloading) {
                                    return CireProgressIndecatorWidget();
                                  }
                                  else if (state is PeredictionCancerTypeIsSuccess) {
                                    return Container(
                                        padding: EdgeInsets.all(10.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: AppColor.buttonChoseuser,
                                        ),
                                        child: Text(
                                          'Ummm 😥 our AI can detect  ${state.peredictionModel.prediction} you must checkout doctor',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                        ));
                                  }else if (state is PeredictionCancerTypeIsSuccess){
                                    if(state.peredictionModel.prediction=="Not Skin"){
                                          return Container(
                                        padding: EdgeInsets.all(10.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: AppColor.buttonChoseuser,
                                        ),
                                        child: const  Text(
                                          'Pleas Enter Skin Image',
                                          style:  TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                        ));
                                    }
                                  }
                                  return SizedBox();
                                }),
                                const SizedBox(
                                  height: 15,
                                )
                              ]),
                            ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                              buttoncolor: const Color.fromRGBO(88, 99, 203, 1),
                              width: 300.w,
                              height: 60.h,
                              buttonName: "Upload",
                              onTap: () {
                                pickGallery().then((value) {
                                  context
                                      .read<AiPeredictionCubit>()
                                      .peredictonSkinorNot(_image);
                                });
                              },
                              textColor: Colors.white,
                              white: false),
                          IconButton(
                              color: Colors.grey,
                              onPressed: () {},
                              icon: const Icon(Icons.save))
                        ],
                      ),
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }
}
