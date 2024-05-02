import 'package:flutter/material.dart';

import '../../../../core/utils/spacer.dart';
import '../../../../core/utils/text_styels.dart';


class CancerTypesWidgets extends StatelessWidget {
  final String cancerType;
  final String imagePath;
  final String info;
  final bool isnetwork;
  final VoidCallback onTap;

  const CancerTypesWidgets(
      {super.key,
      required this.cancerType,
      required this.onTap,
      required this.imagePath,
        required this.isnetwork,
      required this.info
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      leading: IconButton(icon: const Icon(Icons.arrow_back_ios),onPressed: (){
          Navigator.pop(context);
      }),
      actions: [
        IconButton(onPressed:onTap, icon: Icon(
          Icons.info_outline,
          color: Color(0xFFDA80D7),
          size: 35,
        ),)
      ],
    ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  verticalSpacing(30),
                  Text(
                    cancerType,
                    style: TextStyles.font22MoveW700,
                  ),
                  verticalSpacing(20),
              isnetwork?      Image.asset(imagePath):Image.network(imagePath),
                  verticalSpacing(20),
                  Text(info, style: TextStyles.font17BlackW500)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
