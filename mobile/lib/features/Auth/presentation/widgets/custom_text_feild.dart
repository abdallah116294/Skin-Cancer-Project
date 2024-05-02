
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/utils/app_color.dart';
class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled(
      {Key? key,
      this.isObscureText,
      this.inputFiled,
      this.prefixIcon,
      this.validator,
      this.textInputType,
      required this.controller,
      this.onchange, required this.onPresed})
      : super(key: key);
  final bool? isObscureText;
  final String? inputFiled;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final Function(String)? onchange;
  final GestureTapCallback onPresed;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onPresed,
      style:  TextStyle(color: Colors.black,fontSize: 18.sp),
      onChanged: onchange,
      obscureText: isObscureText!,
      validator: validator,
      keyboardType: textInputType,
      decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:  BorderSide(color: AppColor.error)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white)),
        contentPadding:const  EdgeInsets.symmetric(vertical: 10,horizontal: 10),
           fillColor:Colors.black ,
          hintText: inputFiled,
          hintStyle: TextStyle(color: AppColor.hintText,fontSize: 15.sp),
          prefixIcon: Icon(prefixIcon,color: AppColor.hintText,size: 18.w,),
          ),
    );
  }
}
