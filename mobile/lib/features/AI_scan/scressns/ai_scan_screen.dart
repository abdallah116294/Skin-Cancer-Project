import 'dart:developer';
import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_methods.dart';
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
  List? _output;
  bool _loading = true;

  File? _image;
  final picker = ImagePicker();

  Future pickFromCamera() async {
    log("pick image");
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      setState(() {
        image=null;
      });
      return null;
    }
    var compressedImage = await compressImage(File(image.path));
    setState(() {
      _image = compressedImage;
      _loading = false;
    });
    Navigator.pop(context);
    print(_loading.toString());
    print("8888888888   camera   8888888888888");

    //  detectImage(_image);
  }

  String userImageUrl = '';

  Future pickGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      setState(() {
        image=null;
      });
      return null;
    }
    var compressedImage = await compressImage(File(image.path));

    setState(() {
      _image = compressedImage;
      _loading = false;
    });
    Navigator.pop(context);
print(_loading.toString());
print("8888888888888888888888888888");
    log(image.path.toString());
    // detectImage(_image);
  }

  Future<File> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/temp.jpg';

    // Read the image from file
    img.Image image = img.decodeImage(file.readAsBytesSync())!;

    // Resize the image
    img.Image smallerImage = img.copyResize(image, width: 800);

    // Save the smaller image to a file
    File compressedImage = File(targetPath)
      ..writeAsBytesSync(img.encodeJpg(smallerImage, quality: 85));

    return compressedImage;
  }

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
                    isSuccess: false,
                    daliogContent: "Please Enter Skin Image",
                    actionName: 'Go Back',
                    context: context,
                    onTap: () {
                      context.pop();
                    });
              } else if (state.peredictionModel.prediction == 'Skin') {
                context
                    .read<AiPeredictionCubit>()
                    .peredictonCancerType(_image!);
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
                                  style: TextStyles.font26BlackW700
                                      .copyWith(fontSize: 22.sp),
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
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  width: 290.w,
                                  height: 200.h,
                                  child: _image != null
                                      ? Image.file(
                                          _image!,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(),
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
                                                  fontSize: 14.sp,
                                                  color: Colors.black),
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
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColor
                                                          .primaryColor),
                                                ),
                                              ),
                                              verticalSpacing(10),
                                              Text(
                                                disease['description']
                                                    .toString(),
                                                style: TextStyles
                                                    .font12BlackW400
                                                    .copyWith(fontSize: 14.sp),
                                              ),
                                              verticalSpacing(20),
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'What are the Symptoms?',
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColor
                                                            .primaryColor),
                                                  )),
                                              verticalSpacing(10),
                                              Text(
                                                disease['symptoms'].toString(),
                                                style: TextStyles
                                                    .font12BlackW400
                                                    .copyWith(fontSize: 14.sp),
                                              ),
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
                                              onTap: () async {
                                                setState(() {
                                                  _loading = true;
                                                });
                                                await AppMethods
                                                    .imagePickerDialog(
                                                  context: context,
                                                    camerFun: _loading == false
                                                        ? context.pop
                                                        : pickFromCamera,
                                                    removeFun: () {
                                                      context.pop();
                                                    },
                                                    galeryFun: _loading == false
                                                        ? context.pop
                                                        : pickGallery,
                                                ).then((value) {
                                                  if(_image!= null){
                                                    context
                                                        .read<
                                                        AiPeredictionCubit>()
                                                        .peredictonSkinorNot(
                                                        _image!);
                                                  }

                                                });
                                              },
                                              textColor: Colors.white,
                                              white: false),
                                        )
                                      : Expanded(
                                          child: CustomButton(
                                              buttoncolor:
                                                  AppColor.primaryColor,
                                              width: 300.w,
                                              height: 60.h,
                                              buttonName: "Explore Clinics",
                                              onTap: () async {
                                                await AppMethods
                                                    .imagePickerDialog(
                                                  context: context,
                                                  camerFun: _loading == false
                                                      ? context.pop
                                                      : pickFromCamera,
                                                  removeFun: () {
                                                    context.pop();
                                                  },
                                                  galeryFun: _loading == false
                                                      ? context.pop
                                                      : pickGallery,
                                                ).then((value) {
                                                  context
                                                      .read<
                                                          AiPeredictionCubit>()
                                                      .peredictonSkinorNot(
                                                          _image!);
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
                                          onTap: () async {
                                            await AppMethods.imagePickerDialog(
                                              context: context,
                                              camerFun: _loading == false
                                                  ? context.pop
                                                  : pickFromCamera,
                                              removeFun: () {
                                                context.pop();
                                              },
                                              galeryFun: _loading == false
                                                  ? context.pop
                                                  : pickGallery,
                                            ).then((value) {
                                              context
                                                  .read<AiPeredictionCubit>()
                                                  .peredictonSkinorNot(_image!);
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
                                      onTap: () async {
                                        await AppMethods.imagePickerDialog(
                                          context: context,
                                          camerFun: _loading == false
                                              ? context.pop
                                              : pickFromCamera,
                                          removeFun: () {
                                            context.pop();
                                          },
                                          galeryFun: _loading == false
                                              ? context.pop
                                              : pickGallery,
                                        ).then((value) {
                                          context
                                              .read<AiPeredictionCubit>()
                                              .peredictonSkinorNot(_image!);
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
                                        ? state.peredictionModel.prediction ==
                                                "Couldn't identify lesion"
                                            ? Fluttertoast.showToast(
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                toastLength: Toast.LENGTH_LONG,
                                                msg: "Couldn't upload",
                                              )
                                            : context
                                                .read<AiPeredictionCubit>()
                                                .uploadAiResult(
                                                    patientId,
                                                    state.peredictionModel
                                                        .prediction,
                                                    _image!)
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
