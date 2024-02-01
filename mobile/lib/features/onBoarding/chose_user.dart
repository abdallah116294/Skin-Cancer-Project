import 'package:flutter/material.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/utils/string_manager.dart';

class ChoseUser extends StatefulWidget {
  const ChoseUser({super.key});

  @override
  State<ChoseUser> createState() => _ChoseUserState();
}

class _ChoseUserState extends State<ChoseUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppColor.choseColor)),
        child:  Column(
          
          children: [
            const Center(
              child: Text(
                StringManager.welcomeMessage,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 26),
              ),
            ),
            Container(
              decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:const  DecorationImage(image: AssetImage(AssetsManager.patient_user))
              ),
            ),

          ],
        ),
      ),
    );
  }
}
