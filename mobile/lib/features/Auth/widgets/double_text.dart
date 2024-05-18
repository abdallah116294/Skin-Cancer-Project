import 'package:flutter/material.dart';

import '../../../core/utils/text_styles.dart';

class DoubleText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final void Function()? onTap;

  const DoubleText({
    super.key,
    this.onTap,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            firstText,
            style:  TextStyles.font16BlackW400.copyWith(
              color: Colors.black.withOpacity(.5)
            )
        ),

        InkWell(

          onTap: onTap,
          child: Text(
              maxLines: 2,
              secondText,
              style:  TextStyles.font18PrimaryW500 ),
        ),

      ],
    );
  }
}