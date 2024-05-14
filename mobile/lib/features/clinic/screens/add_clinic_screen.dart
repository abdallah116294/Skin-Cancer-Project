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
import 'package:mobile/features/clinic/widgets/pick_image_widget.dart';
import 'package:mobile/injection_container.dart' as di;

class AddClinicScreen extends StatefulWidget {
  const AddClinicScreen({super.key});

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
                        context.pushNamed(Routes.bottomNavScreenRoutes);
                      });
                } else if (state is CreateClinicIsError) {
                  DailogAlertFun.showMyDialog(
                      daliogContent: state.error.toString(),
                      actionName: "Go Home",
                      context: context,
                      onTap: () {
                        context.pushNamed(Routes.bottomNavScreenRoutes);
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
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Availability',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          showDate1.isEmpty
                              ? const Text('Enter Your availabile Date')
                              : Text(showDate1),
                          IconButton(
                              onPressed: () async {
                                Map<String, String?> result =
                                    await DateConverter.showDateTimePicker(
                                        selectedDateAndTime:
                                            selectedDateAndTime1,
                                        showDate: showDate1,
                                        context: context,
                                        firstDate: DateTime(2015, 8),
                                        lastDate: DateTime(2101),
                                        initialDate: DateTime.now());
                                setState(() {
                                  showDate1 = result['showDate']!;
                                  selectedDateAndTime1 =
                                      result['selectedDateAndTime']!;
                                });
                              },
                              icon: Icon(
                                color: AppColor.primaryColor,
                                Icons.date_range,
                              ))
                        ],
                      ),
                      verticalSpacing(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          showDate2.isEmpty
                              ? Text('Enter Your availabile Date')
                              : Text(showDate2),
                          IconButton(
                              onPressed: () async {
                                log(showDate2);
                                Map<String, String?> result =
                                    await DateConverter.showDateTimePicker(
                                        context: context,
                                        selectedDateAndTime:
                                            selectedDateAndTime2,
                                        showDate: showDate2,
                                        firstDate: DateTime(2015, 8),
                                        lastDate: DateTime(2101),
                                        initialDate: DateTime.now());
                                setState(() {
                                  showDate2 = result['showDate']!;
                                  selectedDateAndTime2 =
                                      result['selectedDateAndTime']!;
                                });
                                log(showDate2);
                              },
                              icon: Icon(
                                color: AppColor.primaryColor,
                                Icons.date_range,
                              ))
                        ],
                      ),
                      verticalSpacing(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          showDate3.isEmpty
                              ? Text('Enter Your availabile Date')
                              : Text(showDate3),
                          IconButton(
                              onPressed: () async {
                                log(showDate1);
                                Map<String, String?> result =
                                    await DateConverter.showDateTimePicker(
                                        context: context,
                                        selectedDateAndTime:
                                            selectedDateAndTime3,
                                        showDate: showDate3,
                                        firstDate: DateTime(2015, 8),
                                        lastDate: DateTime(2101),
                                        initialDate: DateTime.now());
                                setState(() {
                                  showDate3 = result['showDate']!;
                                  selectedDateAndTime3 =
                                      result['selectedDateAndTime']!;
                                });
                                log(showDate1);
                              },
                              icon: Icon(
                                color: AppColor.primaryColor,
                                Icons.date_range,
                              ))
                        ],
                      ),
                      verticalSpacing(10),

                      Center(
                        child: CustomButton(
                            buttoncolor: AppColor.primaryColor,
                            width: 358.w,
                            height: 61.h,
                            buttonName: 'Upload',
                            onTap: () {

                              if (formkey.currentState!.validate()) {

                                CacheHelper.saveData(key: 'clinicName',
                                    value: nameController.text);
                                context.read<ClinicCubit>().creatClinic(
                                    ClinicModel(
                                        id: 0,
                                        name: nameController.text,
                                        price: int.parse(priceController.text),
                                        phone: phoneNumberController.text,
                                        address: addressController.text,
                                        image:
                                            'https://i.pinimg.com/564x/7a/10/3a/7a103a52bd6ce9b5f29566d6f0dc6306.jpg',
                                        description: decriptionController.text,
                                        date1: selectedDateAndTime1,
                                        date2: selectedDateAndTime2,
                                        date3: selectedDateAndTime3,
                                        doctorName: username),
                                    token);
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
