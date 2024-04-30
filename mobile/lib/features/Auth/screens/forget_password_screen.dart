import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/features/Auth/widgets/custom_text_feild.dart';
import 'package:mobile/features/onBoarding/widgets/clipper.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
          Positioned(
            top: 150,
            right: 0,
            left: 0,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Image(image: AssetImage(AssetsManager.forgetPass)),
                  Text(
                    StringManager.forgetPassword,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    StringManager.forgetPasssword2,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: CustomTextFormFiled(
                      controller: emailController,
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
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      buttoncolor: AppColor.buttonColor,
                      width: 358.w,
                      height: 61.h,
                      buttonName: StringManager.sendCode,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context)
                              .pushNamed(Routes.oTPCodeScreenRoutes);
                        }
                      },
                      textColor: Colors.white,
                      white: false)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
