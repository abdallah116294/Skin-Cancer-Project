import 'package:flutter/material.dart';

import '../widget/info_widget.dart';

class RiskFactors extends StatelessWidget {
  const RiskFactors({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoWidget(
      title: 'Risk Factors',
      imagePath: 'assets/image/risk_factors.png',
      supTitle: "A risk factor is anything that increases your likelihood of developing a disease like cancer. When it comes to skin cancer risk factors, there are several that can contribute to the development of this disease. Fortunately, many of these risks can be addressed by you.",
    );  }
}
