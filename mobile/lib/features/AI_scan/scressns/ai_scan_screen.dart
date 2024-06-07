import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/circle_progress_widget.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/features/AI_scan/cubit/ai_perediction_cubit.dart';
import 'package:mobile/features/AI_scan/data/models/disease_info_mode.dart';
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

  Disease? getDiseaseByName(List<Disease> diseases, String name) {
    try {
      return diseases.firstWhere(
        (disease) => disease.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  Map<String, String> findDiseaseByName(String name) {
    for (var disease in StringManager.diseaes) {
      if (disease['name'].toString() == name.toString()) {
        return disease;
      }
    }
    return {}; // Return null if no disease is found
  }

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
    var patient_role = CacheHelper.getData(key: 'patient_role');
    var doctor_role = CacheHelper.getData(key: 'doctor_role');
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String patientId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            } else if (state is UploadAiResultSuccess) {
              DailogAlertFun.showMyDialog(
                  daliogContent: "Upload Success",
                  actionName: 'Go Back',
                  context: context,
                  onTap: () {
                    context.pushNamedAndRemoveUntil(
                        Routes.bottomNavScreenRoutes,
                        predicate: (Route<dynamic> route) => false);
                  });
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state is PeredictionCancerTypeIsSuccess
                          ? const SizedBox()
                          : Text(
                              "Upload a photo of your skin lesion",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                      verticalSpacing(
                        5,
                      ),
                      state is PeredictionCancerTypeIsSuccess
                          ? const SizedBox()
                          : Text(
                              " Our AI will detect potential skin cancer type",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                      verticalSpacing(10),
                      state is PeredictionCancerTypeIsSuccess
                          ? state.peredictionModel.prediction ==
                                  "Couldn't identify lesion"
                              ? Text(
                                  state.peredictionModel.prediction,
                                  style: TextStyles.font26BlackW700,
                                )
                              : Text(
                                  state.peredictionModel.prediction,
                                  style: TextStyles.font26BlackW700,
                                )
                          : const SizedBox(),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: _loading
                            ? SizedBox(
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
                            : Column(children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 400.h,
                                  child: Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                verticalSpacing(20),
                                BlocBuilder<AiPeredictionCubit,
                                        AiPeredictionState>(
                                    builder: (context, state) {
                                  if (state is PeredictonSkinOrNotIsloading) {
                                    return const CireProgressIndecatorWidget();
                                  } else if (state
                                      is PeredictionCancerTypeIsSuccess) {
                                    Map<String, String> disease =
                                        findDiseaseByName(
                                            state.peredictionModel.prediction);
                                    if (disease['name'] ==
                                        "Couldn't identify lesion") {
                                      return Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 0.0)
                                            ]),
                                        child: Column(
                                          children: [
                                            Text(
                                              'AI Couldn\'t identify your Image ,\n You can Explore Doctor\'s Clinic to get Private Dignonoses',
                                              style: TextStyle(
                                                  fontSize: 27.sp,
                                                  color: Colors.red),
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 5.0,
                                                    spreadRadius: 0.0)
                                              ]),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'What is ${disease['name'].toString()}?',
                                                  style: TextStyle(
                                                      fontSize: 27.sp,
                                                      color: Colors.red),
                                                ),
                                              ),
                                              verticalSpacing(10),
                                              Text(disease['description']
                                                  .toString()),
                                              verticalSpacing(10),
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'What are the Symptoms?',
                                                    style: TextStyle(
                                                        fontSize: 27.sp,
                                                        color: Colors.red),
                                                  )),
                                              Text(disease['description']
                                                  .toString()),
                                            ],
                                          ));
                                    }
                                  } else if (state
                                      is PeredictionCancerTypeIsSuccess) {
                                    if (state.peredictionModel.prediction ==
                                        "Not Skin") {
                                      return Container(
                                          padding: EdgeInsets.all(10.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: AppColor.buttonChoseuser,
                                          ),
                                          child: const Text(
                                            'Pleas Enter Skin Image',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24),
                                          ));
                                    }
                                  }
                                  return const SizedBox();
                                }),
                                const SizedBox(
                                  height: 15,
                                )
                              ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state is PeredictionCancerTypeIsSuccess
                              ? state.peredictionModel.prediction ==
                                      'Couldn\'t identify lesion'
                                  ? doctor_role != null
                                      ? Expanded(
                                          child: CustomButton(
                                              buttoncolor:
                                                  AppColor.primaryColor,
                                              width: 300.w,
                                              height: 60.h,
                                              buttonName: "Upload",
                                              onTap: () {
                                                pickGallery().then((value) {
                                                  context
                                                      .read<
                                                          AiPeredictionCubit>()
                                                      .peredictonSkinorNot(
                                                          _image);
                                                });
                                              },
                                              textColor: Colors.white,
                                              white: false),
                                        )
                                      : Expanded(
                                          child: CustomButton(
                                              buttoncolor: const Color.fromRGBO(
                                                  88, 99, 203, 1),
                                              width: 300.w,
                                              height: 60.h,
                                              buttonName: "Explore Clinics",
                                              onTap: () {
                                                context.pushNamed(
                                                    Routes.topDocScreen);
                                              },
                                              textColor: Colors.white,
                                              white: false),
                                        )
                                  : Expanded(
                                      child: CustomButton(
                                          buttoncolor: const Color.fromRGBO(
                                              88, 99, 203, 1),
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
                                    )
                              : Expanded(
                                  child: CustomButton(
                                      buttoncolor: AppColor.primaryColor,
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
                                ),
                          doctor_role != null
                              ? const SizedBox()
                              : IconButton(
                                  color: Colors.grey,
                                  onPressed: () {
                                    state is PeredictionCancerTypeIsSuccess
                                        ? context
                                            .read<AiPeredictionCubit>()
                                            .uploadAiResult(
                                                patientId,
                                                state.peredictionModel
                                                    .prediction,
                                                _image)
                                        : log("not done");
                                  },
                                  icon: const Icon(Icons.save))
                        ],
                      ),
                      verticalSpacing(40),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
