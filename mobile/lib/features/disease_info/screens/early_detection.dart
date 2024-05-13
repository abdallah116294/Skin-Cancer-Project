import 'package:flutter/material.dart';
import 'package:mobile/features/disease_info/widget/info_widget.dart';

class EarlyDetectionScreen extends StatelessWidget {
  const EarlyDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(title: "Early Detection",
        imagePath: "assets/image/early_detection.png",
        supTitle:"The world’s most common cancer is a relentless disease that strikes one in five people by age 70. The good news is that most cases are curable if they are diagnosed and treated early enough. But in order to stop skin cancer, we have to spot it on time.\n"
            "Skin cancer is the cancer you can see. Unlike cancers that develop inside the body, skin cancers form on the outside and are usually visible. That’s why skin exams, both at home and with a dermatologist, are especially vital.\n"
            "Early detection saves lives. Learning what to look for on your own skin gives you the power to detect cancer early when it’s easiest to cure, before it can become dangerous, disfiguring or deadly."
    );}}
