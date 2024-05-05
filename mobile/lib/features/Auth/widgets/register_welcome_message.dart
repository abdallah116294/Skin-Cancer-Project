import 'package:flutter/material.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/utils/text_styles.dart';

class RegisterWelcomeMessage extends StatelessWidget {
  const RegisterWelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create Account',
          style: TextStyles.font24PrimaryW700,
        ),
        verticalSpacing(10),

        Text(
          "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
          style: TextStyles.font15BlackW500.copyWith(
              height: 1.3,
              color: const Color(0xFF757575)
          ),
        ),
      ],
    );
  }
}
