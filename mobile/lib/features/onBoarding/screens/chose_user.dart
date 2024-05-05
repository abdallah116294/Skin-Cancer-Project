import 'package:flutter/material.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/features/onBoarding/widgets/chose_user_button.dart';

import '../../../core/utils/text_styles.dart';

class ChoseUser extends StatefulWidget {
  const ChoseUser({super.key});

  @override
  State<ChoseUser> createState() => _ChoseUserState();
}

class _ChoseUserState extends State<ChoseUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpacing(20),
            Center(
              child: Text(
                  StringManager.welcomeMessage,
                  style: TextStyles.font26BlackW700
              ),
            ),
            Text(
              StringManager.choseUser,
              style: TextStyles.font20BlackW700.copyWith(fontWeight: FontWeight.w400),
            ),
            verticalSpacing(50),

            ChoseUserButton(
              imagePathe: AssetsManager.patient_user,
              user: StringManager.patient,
              onTap: () {
                //add two user role as arrguments with navigator
                context.pushNamed(Routes.singInScreenRoutes,
                    arguments: {"role1": "Patient"});
                // Navigator.pushNamed(
                //     context, Routes.choseAuthFunScreenRoutes);
              },
            ),
            verticalSpacing(50),
            ChoseUserButton(
              imagePathe: AssetsManager.doctor_user,
              user: StringManager.doctor,
              onTap: () {
                context.pushNamed(Routes.singInScreenRoutes,
                    arguments: {"role2": "Doctor"});
              },
            ),
          ],
        ),
      ),
    );
  }
}
