import 'package:flutter/material.dart';
import 'package:mobile/core/utils/app_color.dart';

class CireProgressIndecatorWidget extends StatelessWidget {
  const CireProgressIndecatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColor.primaryColor,
      ),
    );
  }
}
