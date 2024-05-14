import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/utils/app_color.dart';

import '../../../core/utils/text_styles.dart';

class CustomTextFormFiled extends StatelessWidget {
   CustomTextFormFiled(
      {Key? key,
      this.maxline,
      this.isObscureText,
      this.inputFiled,
      this.prefixIcon,
      this.validator,
      this.textInputType,
      required this.controller,
      this.onchange,
       this.onTap,
      this.suffixIcon})
      : super(key: key);
  final bool? isObscureText;
  final String? inputFiled;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final Function(String)? onchange;
  final void Function()? onTap;
  final Widget? suffixIcon;
  int?maxline;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      maxLines: maxline??1,
      style: TextStyles.font14BlackW600,
      onChanged: onchange,
      obscureText: isObscureText ?? false,
      validator: validator,
      keyboardType: textInputType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColor.primaryColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColor.error)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColor.error)),
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        fillColor: const Color(0xFFFDFDFF),
        filled: true,
        isDense: true,
        hintText: inputFiled,
        hintStyle: TextStyle(color: AppColor.hintText, fontSize: 15.sp),
        suffixIcon: suffixIcon,
        prefixIcon: Icon(
          prefixIcon,
          color: AppColor.hintText,
          size: 18.w,
        ),
      ),
    );
  }
}
