import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/app_button.dart';

class DocDetailsScreen extends StatelessWidget {
  const DocDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
                height: 327.h,
                width: 390.w,
                fit: BoxFit.cover,
                "assets/image/doc1.png"),
            verticalSpacing(14),
            Text(
              "Ahmed Khaled",
              style: TextStyles.font24PrimaryW700,
            ),
            verticalSpacing(8),

            Text(
              "Sr.Dermatologist",
              style: TextStyles.font14BlackW300
                  .copyWith(color: const Color(0xFF828BE7)),
            ),
            verticalSpacing(14),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: const Divider(
                thickness: 1.5,
                color: Color(0xFF828BE7),
              ),
            ),
            Text(
              "About",
              style: TextStyles.font24PrimaryW700
                  .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            verticalSpacing(14),

            Text(
              "Dr Hiba kamal is a highly skilled and qualified consultant dermatologist based in Cairo. She has established her own clinic in maadi where she currently sees patients.",
              style: TextStyles.font24PrimaryW700
                  .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    buttonColor: const Color(0xFF0010B2),
                    gradient: LinearGradient(colors: [
                      Color(0xFF7E87E2),
                      Color(0xFF0010B2),
                    ]),
                    width: 170,
                    height: 50,
                    textOfButtonStyle: TextStyles.font15BlackW500.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                    buttonName: "Book Appointment",
                    onTap: () {},
                    textColor: Colors.white,
                    white: false,
                  ),
                ),
                horizontalSpacing(10),
                Expanded(
                  child: AppButton(
                      buttonColor: Color(0xFF0010B2),
                      width: 170,
                      height: 50,
                      gradient: LinearGradient(colors: [
                        Color(0xFF7E87E2),
                        Color(0xFF0010B2),
                      ]),
                      textOfButtonStyle: TextStyles.font15BlackW500.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.white),
                      buttonName: "E-Consultation",
                      onTap: () {},
                      textColor: Colors.white,
                      white: false),
                ),
              ],
            ),
            verticalSpacing(20),

          ],
        ),
      ),
    );
  }
}
