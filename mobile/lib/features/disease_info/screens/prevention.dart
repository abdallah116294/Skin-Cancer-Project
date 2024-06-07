import 'package:flutter/material.dart';
import 'package:mobile/features/disease_info/widget/info_widget.dart';

class PreventionScreen extends StatelessWidget {
  const PreventionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoWidget(
        title: "Skin Cancer Prevention",
        imagePath: "assets/image/cancer_prevention.png",
        supTitle:
            "Skin cancer prevention requires a comprehensive approach to protecting yourself against harmful ultraviolet (UV) radiation. +" +
                "That’s because UV radiation from the sun isn’t just dangerous, it’s also sneaky. Not only can it cause premature aging and skin cancer, it reaches you even when you’re trying to avoid it – penetrating clouds and glass, and bouncing off of snow, water and sand. What’s more, sun damage accumulates over the years, from prolonged outdoor exposure to simple activities like walking the dog, going from your car to the store and bringing in the mail.");
  }
}
