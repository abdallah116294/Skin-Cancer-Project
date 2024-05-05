import 'package:flutter/material.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/text_styles.dart';

class LoginWelcomeMessage extends StatelessWidget {
  const LoginWelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Welcome Back",
          style: TextStyles.font24PrimaryW700,
        ),
        verticalSpacing(10),
        Text(
            "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
          style: TextStyles.font15BlackW500.copyWith(
              height: 1.3,
            color: Color(0xFF757575)
          ),

        ),
      ],
    );
  }
}
