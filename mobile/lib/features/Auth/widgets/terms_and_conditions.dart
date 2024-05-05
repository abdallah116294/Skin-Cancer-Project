import 'package:flutter/material.dart';

import '../../../core/utils/text_styles.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign:TextAlign.center,

      text: TextSpan(children: [
        TextSpan(
            text: "By logging, you agree to our",
            style: TextStyles.font14BlackW300.copyWith(
    color: const Color(0xFFA8A8A8),
            )),
        TextSpan(
            text: " Terms & Conditions ", style: TextStyles.font14BlackW300.copyWith(
          color: const Color(0xFF242424),
          fontWeight: FontWeight.w500
        )),

        TextSpan(text: "and", style: TextStyles.font14BlackW300.copyWith(
    color: const Color(0xFFA8A8A8),
        )),
        TextSpan(
            text: " PrivacyPolicy. ", style: TextStyles.font14BlackW300.copyWith(
            color: const Color(0xFF242424),
          fontWeight: FontWeight.w500
        )),
      ]),
    );
  }
}