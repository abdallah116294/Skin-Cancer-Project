import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/features/Auth/domain/entities/doctor_entity.dart';
import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';
import 'package:mobile/features/Auth/presentation/auth_cubit.dart';
import 'package:mobile/features/Auth/presentation/screens/sign_in_screen.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/assets_path.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/app_methods.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dailog.dart';
import '../../../onBoarding/widgets/clipper.dart';
import '../widgets/about_text_formfiled.dart';
import '../widgets/custom_text_feild.dart';
import '../widgets/or_line_widget.dart';
import 'package:mobile/injection_container.dart' as di;

import '../widgets/pick_image_widget.dart';
import 'add_clinic_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, required this.num}) : super(key: key);
  var num;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emialController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final phonenumberController = TextEditingController();
  XFile? _pickedImage;
  final _formKey = GlobalKey<FormState>();

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
  String userImageUrl='';
  Future<String>uploadImage()async{
    if(widget.num==0){
      final ref = FirebaseStorage.instance
          .ref()
          .child("patient")
          .child("${emialController.text.trim()}.jpg");
      await ref.putFile(File(_pickedImage!.path));
      final downloadURl=await  ref.getDownloadURL();
      setState(() {
        userImageUrl =  downloadURl;
      });
      return userImageUrl;
    }else if(widget.num==1){
      final ref = FirebaseStorage.instance
          .ref()
          .child("doctor")
          .child("${emialController.text.trim()}.jpg");
      await ref.putFile(File(_pickedImage!.path));
      final downloadURl=await  ref.getDownloadURL();
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
      child: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is AuthInLoadingState) {
          log("Loading");
        } else if (state is RegisterSuccess) {
          // 
          if(widget.num==1){
            DailogAlertFun.showMyDialog(
              daliogContent: 'You mus add your Clinic details',
              actionName: "Add",
              context: context,
              onTap: () {
                if (widget.num == 1) {
                  log(state.uid);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AddClinicScreen(
                            name: nameController.text, uid: state.uid,
                            num:widget.num
                          )));
                } 
              });
          }else if(widget.num==0){
                DailogAlertFun.showMyDialog(
              daliogContent: 'You should sign In again',
              actionName: "Sign In",
              context: context,
              onTap: () {
                if (widget.num == 0) {
                //  log(userImageUrl);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SingInScreen(
                            num: widget.num,
                          )));
                }
              });
          }
         
        } else if (state is AuthInErrorState) {
          log(state.error.toString());
        }
      }, builder: (context, state) {
        return Scaffold(
            body: Stack(
                children: [
                Positioned(
                top: 0,
                right: 0,
                child: ClipPath(
                  clipper: Ellips7(),
                  child: Container(
                    width: 170.h,
                    height: 170.h,
                    color: const Color(0xffC5CAFB),
                  ),
                )),
            Positioned(
                top: 0,
                right: 0,
                child: ClipPath(
                  clipper: Ellips7(),
                  child: Container(
                    width: 150.h,
                    height: 150.h,
                    color: const Color(0xff5863CB).withOpacity(0.5),
                  ),
                )),
            Positioned(
              top: 22,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  color: const Color(0xff6069C0),
                ),
                elevation: 0, // remove app bar shadow
              ),
            ),
            Column(
              children: [
              SizedBox(
              height: 200.h,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 685.h,
                decoration: BoxDecoration(
                    color: AppColor.singInContainerColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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
                  Form(
                    key: _formKey,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            children: [
                        Container(
                        decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: CustomTextFormFiled(
                      controller: nameController,
                      onPresed: () {},
                      inputFiled: "Enter your name",
                      isObscureText: false,
                      validator: (String? valeue) {
                        if (valeue!.isEmpty) {
                          return "pleas enter name";
                        }
                        return null;
                      },
                      prefixIcon: Icons.text_decrease,
                      textInputType: TextInputType.name,
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
                      controller: emialController,
                      onPresed: () {},
                      inputFiled: "Enter your email",
                      isObscureText: false,
                      validator: (String? valeue) {
                        if (valeue!.isEmpty) {
                          return "pleas enter email";
                        }
                        return null;
                      },
                      prefixIcon: Icons.email,
                      textInputType: TextInputType.emailAddress,
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
                      controller: phonenumberController,
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
            widget.num==1?      SizedBox(
                    height: 10.h,
                  ): const SizedBox(height: 0.0,),
                              widget.num==1?     Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: AboutTextFormFiled(controller: descriptionController,
                                                      onPresed: () {},
                                                      prefixIcon: Icons.details,
                                                      validator: (String? valeue) {
                                                if (valeue!.isEmpty) {
                                                return "enter details about you";
                                                }
                                                return null;
                                                },
                                                    textInputType: TextInputType.text,
                                                    inputFiled: "Enter Details about you",
                                                    isObscureText: false,

                                                  ),
                              ):SizedBox(height: 0.0,),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: CustomTextFormFiled(
                    controller: passwordController,
                    onPresed: () {},
                    inputFiled: "Enter your password",
                    isObscureText: true,
                    validator: (String? valeue) {
                      if (valeue!.isEmpty) {
                        return "pleas enter password";
                      }
                      return null;
                    },
                    prefixIcon: Icons.lock,
                    textInputType:
                    TextInputType.visiblePassword,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                state is AuthInLoadingState
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : CustomButton(
                    buttoncolor: AppColor.buttonColor,
                    width: 358.w,
                    height: 61.h,
                    buttonName: StringManager.signUp,
                    onTap: () {
                      if (_formKey.currentState!
                          .validate()) {
                        log(widget.num.toString());

                        if (widget.num == 0) {
                          uploadImage().then((value){
                            BlocProvider.of<AuthCubit>(
                                context)
                                .signUpPatient(
                              patientEntity: PatientEntity(
                                  email: emialController.text,
                                  password: passwordController
                                      .text),
                            ).then((value) {
                              BlocProvider.of<AuthCubit>(
                                  context)
                                  .getCurrentPatient(
                                userEntity: PatientEntity(
                                    name: nameController
                                        .text,
                                    email:
                                    emialController
                                        .text,
                                    password:
                                    passwordController
                                        .text,
                                    uid: '',
                                    status:
                                    'I am new patient',
                                    phonenumber:
                                    phonenumberController
                                        .text,
                                    imageUrl: userImageUrl),);
                            });
                          });
                        } else if (widget.num == 1) {
                          uploadImage().then((value) {
                            BlocProvider.of<AuthCubit>(
                                context)
                                .signUpDoctor(
                              userEntity: DoctorEntity(
                                  email: emialController
                                      .text,
                                  password:
                                  passwordController
                                      .text),
                            ).then((value)
                            {
                              BlocProvider.of<AuthCubit>(context)
                                  .getCurrentDoctor(
                                  userEntity: DoctorEntity(
                                    imageUrl: userImageUrl,
                                      name:
                                      nameController
                                          .text,
                                      email:
                                      emialController
                                          .text,
                                      password:
                                      passwordController
                                          .text,
                                      uid: '',
                                      status:
                                      'I am new patient',
                                      phonenumber:
                                      phonenumberController
                                          .text,about: descriptionController.text));
                            });
                          });

                        }
                      }
                    },
                    textColor: Colors.white,
                    white: false),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringManager.haveAccount,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      StringManager.signIn,
                      style: TextStyle(
                          color: AppColor.signUptext,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )
                ],
              ),
            )),
        ]),
        ),
        ))
        ],
        ),
        ]
        ,
        )
        );
      }),
    );
  }
}
