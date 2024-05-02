import 'package:flutter/material.dart';
import 'package:mobile/core/utils/app_color.dart';

class CustomChatItem extends StatelessWidget {
  CustomChatItem({Key? key, required this.prescription}) : super(key: key);
   final String prescription;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        //alignment: Alignment.centerLeft,
        padding:
            const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
        margin: const EdgeInsets.all(8),
        decoration:  BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32)),
            color: AppColor.doctorTextColor),
        child: Text(
          prescription,
          style: const TextStyle(color: AppColor.textonBoardingColo, fontSize: 20),
        ),
      ),
    );
  }
}
