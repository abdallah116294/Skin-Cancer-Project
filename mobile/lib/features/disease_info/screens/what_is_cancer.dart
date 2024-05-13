import 'package:flutter/material.dart';
import 'package:mobile/features/disease_info/widget/info_widget.dart';


class WhatSkinCaner extends StatelessWidget {
  const WhatSkinCaner({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoWidget(
      title: 'What is skin cancer?',
      imagePath: 'assets/image/cancer.png',
      supTitle: "Skin cancer is the out-of-control growth of abnormal cells in the epidermis, the outermost skin layer, caused by unrepaired DNA damage that triggers mutations. These mutations lead the skin cells to multiply rapidly and form malignant tumors.",
      supTitle2: "The main types of skin cancer are basal cell carcinoma (BCC), squamous cell carcinoma (SCC), melanoma and Merkel cell carcinoma (MCC).",
    );
  }
}
