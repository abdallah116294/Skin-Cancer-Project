import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/widgets/app_methods.dart';
import 'package:mobile/features/Auth/domain/entities/clinc_entity.dart';
import 'package:mobile/features/Auth/presentation/auth_cubit.dart';
import 'package:mobile/features/Auth/presentation/widgets/pick_image_widget.dart';
import 'package:mobile/features/home/presentation/screen/layout_screen.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../home/presentation/screen/home_screen.dart';
import '../widgets/custom_text_feild.dart';
import 'package:mobile/injection_container.dart' as di;

class AddClinicScreen extends StatefulWidget {
  AddClinicScreen(
      {Key? key, required this.name, required this.uid, required this.num})
      : super(key: key);
  final String name;
  final String uid;
  final int num;

  @override
  State<AddClinicScreen> createState() => _AddClinicScreenState();
}

class _AddClinicScreenState extends State<AddClinicScreen> {
  bool _loading = true;
  Timestamp? selectedDate1;
  Timestamp? selectedDate2;
  Timestamp? selectedDate3;
  late File _image;
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final priceController = TextEditingController();
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

  String userImageUrl = '';
  Future<String> uploadImage() async {
    if (widget.num == 1) {
      final ref = FirebaseStorage.instance
          .ref()
          .child("doctor")
          .child("${widget.name..trim()}.jpg");
      await ref.putFile(File(_pickedImage!.path));
      final downloadURl = await ref.getDownloadURL();
      setState(() {
        userImageUrl = downloadURl;
      });
      return userImageUrl;
    }
    return userImageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInLoadingState) {
            log("loadding");
          } else if (state is AddClinicSuccess) {
            log(widget.uid);
            // Fluttertoast.showToast(
            //     msg: "Done",
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.BOTTOM,
            //     timeInSecForIosWeb: 1,
            //     backgroundColor: AppColor.signUptext,
            //     textColor: Colors.white,
            //     fontSize: 16.0
            // );
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LayoutScreen(
                      uid: widget.uid,
                      name: widget.name,
                      num: widget.num,
                    )));
          }
        },
        builder: (context, state) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150.h,
                    width: 150.w,
                    child: PickImageWidget(
                      pickedImage: _pickedImage,
                      function: () {
                        localImagePicker();
                      },
                    ),
                  ),
                  Text(
                    "Dr.${widget.name}",
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
                      controller: addressController,
                      onPresed: () {},
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
                      onPresed: () {},
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
                      onPresed: () {},
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
                  DateTimeField(
                    decoration: const InputDecoration(
                        labelText: "Enter Date",
                        prefixIcon: Icon(Icons.date_range)),
                    firstDate: DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime.now().add(const Duration(days: 40)),
                    initialPickerDateTime:
                        DateTime.now().add(const Duration(days: 1)),
                    value: selectedDate1?.toDate(),
                    onChanged: (DateTime? value) {
                      setState(() {
                        selectedDate1 = Timestamp.fromDate(value!);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  DateTimeField(
                    decoration: const InputDecoration(
                        labelText: "Enter Date",
                        prefixIcon: Icon(Icons.date_range)),
                    firstDate: DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime.now().add(const Duration(days: 40)),
                    initialPickerDateTime:
                        DateTime.now().add(const Duration(days: 1)),
                    value: selectedDate2?.toDate(),
                    onChanged: (DateTime? value) {
                      setState(() {
                        selectedDate2 = Timestamp.fromDate(value!);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  DateTimeField(
                    dateFormat: DateFormat.yMd(),
                    decoration: const InputDecoration(
                        labelText: "Enter Date",
                        prefixIcon: Icon(Icons.date_range)),
                    firstDate: DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime.now().add(const Duration(days: 40)),
                    initialPickerDateTime:
                        DateTime.now().add(const Duration(days: 1)),
                    value: selectedDate3?.toDate(),
                    onChanged: (DateTime? value) {
                      setState(() {
                        selectedDate3 = Timestamp.fromDate(value!);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  state is AuthInLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Center(
                          child: CustomButton(
                              buttoncolor: AppColor.buttonColor,
                              width: 358.w,
                              height: 61.h,
                              buttonName: 'Upload',
                              onTap: () {
                                uploadImage().then((value) {
                                  BlocProvider.of<AuthCubit>(context)
                                      .addNewClinic(
                                          clinicEntity: ClinicEntity(
                                    uid: widget.uid,
                                    dateTime1: selectedDate1!,
                                    dateTime2: selectedDate2!,
                                    dateTime3: selectedDate3!,
                                    phonenumber: phoneNumberController.text,
                                    address: addressController.text,
                                    clinicID: '', imageUrl: userImageUrl, price: priceController.text, doctorname: widget.name,
                                    // image: image
                                  ));
                                });
                              },
                              textColor: Colors.white,
                              white: false),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
