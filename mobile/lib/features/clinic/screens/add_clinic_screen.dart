import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/date_converter.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/widgets/app_methods.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/features/Auth/widgets/custom_text_feild.dart';
import 'package:mobile/features/clinic/cubit/clinic_cubit.dart';
import 'package:mobile/features/clinic/data/model/clinic_model.dart';
import 'package:mobile/features/clinic/data/model/create_clinic_model.dart';
import 'package:mobile/features/clinic/data/model/update_model.dart';
import 'package:mobile/features/clinic/widgets/pick_image_widget.dart';
import 'package:mobile/injection_container.dart' as di;

class AddClinicScreen extends StatefulWidget {
  final Map<String, int?> values;

  const AddClinicScreen({super.key, required this.values});

  @override
  State<AddClinicScreen> createState() => _AddClinicScreenState();
}

class _AddClinicScreenState extends State<AddClinicScreen> {
  bool _loading = true;
  late File _image;
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final priceController = TextEditingController();
  final decriptionController = TextEditingController();
  final nameController = TextEditingController();
  final picker = ImagePicker();
  XFile? _pickedImage;

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await AppMethods.imagePickerDialog(
        context: context,
        camerFun: () async {
          _pickedImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        galeryFun: () async {
          _pickedImage = await picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        removeFun: () {
          setState(() {
            _pickedImage = null;
          });
        });
  }

  DateTime dateSelected = DateTime.now();
  String selectedDateAndTime1 = '';
  String showDate1 = '';
  String selectedDateAndTime2 = '';
  String showDate2 = '';
  String selectedDateAndTime3 = '';
  String showDate3 = '';
  String userImageUrl = '';
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String username = data['sub'];
    String docId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Clinic",
          style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (context) => di.sl<ClinicCubit>(),
            child: BlocConsumer<ClinicCubit, ClinicState>(
              listener: (context, state) {
                if (state is CreateClinicIsloading) {
                  log("loading");
                } else if (state is CreateClinicIsSuccesse) {
                  DailogAlertFun.showMyDialog(
                      daliogContent:
                          state.addClinicSuccessModel.message.toString(),
                      actionName: "Go Home",
                      context: context,
                      onTap: () {
                        context.pushReplacementNamed(Routes.bottomNavScreenRoutes);
                      });
                } else if (state is CreateClinicIsError) {
                  DailogAlertFun.showMyDialog(
                      daliogContent: state.error.toString(),
                      actionName: "Go Home",
                      context: context,
                      onTap: () {
                        context.pushReplacementNamed(Routes.bottomNavScreenRoutes);
                      });
                } else if (state is UpdateClinicSuccess) {
                  DailogAlertFun.showMyDialog(
                      daliogContent: "Updated Success",
                      actionName: "Go Home",
                      context: context,
                      onTap: () {
                        context
                            .pushReplacementNamed(Routes.bottomNavScreenRoutes);
                      });
                }
              },
              builder: (context, state) {
                return Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 150.h,
                          width: 150.w,
                          child: PickImageWidget(
                            pickedImage: _pickedImage,
                            function: () {
                              localImagePicker();
                            },
                          ),
                        ),
                      ),
                      Text(
                        "Dr.$username",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: CustomTextFormFiled(
                          controller: nameController,
                          onTap: () {},
                          inputFiled: "Enter Clinic Name",
                          isObscureText: false,
                          validator: (String? valeue) {
                            if (valeue!.isEmpty) {
                              return "pleas enter name";
                            }
                            return null;
                          },
                          prefixIcon: Icons.title,
                          textInputType: TextInputType.text,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: CustomTextFormFiled(
                          controller: addressController,
                          onTap: () {},
                          inputFiled: "Enter your address",
                          isObscureText: false,
                          validator: (String? valeue) {
                            if (valeue!.isEmpty) {
                              return "pleas enter address";
                            }
                            return null;
                          },
                          prefixIcon: Icons.location_on_outlined,
                          textInputType: TextInputType.streetAddress,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: CustomTextFormFiled(
                          controller: phoneNumberController,
                          onTap: () {},
                          inputFiled: "Enter your phone",
                          isObscureText: false,
                          validator: (String? valeue) {
                            if (valeue!.isEmpty) {
                              return "pleas enter phone";
                            }
                            return null;
                          },
                          prefixIcon: Icons.phone,
                          textInputType: TextInputType.phone,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: CustomTextFormFiled(
                          maxline: 3,
                          controller: decriptionController,
                          onTap: () {},
                          inputFiled: "Description",
                          isObscureText: false,
                          validator: (String? valeue) {
                            if (valeue!.isEmpty) {
                              return "pleas enter description";
                            }
                            return null;
                          },
                          prefixIcon: Icons.description,
                          textInputType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: CustomTextFormFiled(
                          controller: priceController,
                          onTap: () {},
                          inputFiled: "Enter The price ",
                          isObscureText: false,
                          validator: (String? valeue) {
                            if (valeue!.isEmpty) {
                              return "pleas enter price";
                            }
                            return null;
                          },
                          prefixIcon: Icons.currency_pound_sharp,
                          textInputType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),


                      verticalSpacing(10),
                      widget.values["action"] == 1
                          ? Center(
                              child: CustomButton(
                                  buttoncolor: AppColor.primaryColor,
                                  width: 358.w,
                                  height: 61.h,
                                  buttonName: 'Add Clinic',
                                  onTap: () {
                                    if (formkey.currentState!.validate()) {
                                      CacheHelper.saveData(
                                          key: 'clinicName',
                                          value: nameController.text);
                                      context.read<ClinicCubit>().creatClinic(
                                          CreateClinicModel(
                                              doctorId: docId,
                                              name: nameController.text,
                                              price: int.parse(
                                                  priceController.text),
                                              phone: phoneNumberController.text,
                                              address: addressController.text,
                                              image:
                                                  'https://img.youm7.com/ArticleImgs/2020/5/26/43889-%D8%A7%D9%84%D8%B3%D9%82%D8%A7.jpg',
                                              description:
                                                  decriptionController.text,
                                              doctorName: username),
                                          token);
                                    }
                                  },
                                  textColor: Colors.white,
                                  white: false),
                            )
                          : Center(
                              child: CustomButton(
                                  buttoncolor: AppColor.primaryColor,
                                  width: 358.w,
                                  height: 61.h,
                                  buttonName: 'Update',
                                  onTap: () {
                                    if (formkey.currentState!.validate()) {
                                      context.read<ClinicCubit>().updateClinic(
                                          updateClinicModel: UpdateClinicModel(
                                              id: widget.values["clinicId"],
                                              name: nameController.text,
                                              price: int.parse(
                                                  priceController.text),
                                              phone: phoneNumberController.text,
                                              address: addressController.text,
                                              image:
                                                  "https://i.pinimg.com/564x/db/bd/22/dbbd222f3cfc06c1dafc3747f9f9a85e.jpg",
                                              description:
                                                  decriptionController.text),
                                          token: token);
                                    }
                                  },
                                  textColor: Colors.white,
                                  white: false),
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
