import 'package:flutter/material.dart';

import '../cancer_type_widget.dart';

class CancerFactsScreen extends StatelessWidget {
  const CancerFactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  CancerTypesWidgets(
      cancerType: "Skin Cancer Facts & Statistics",
      imagePath: "assets/image/cancer_facts.png",
      info:
          'In the U.S., more than 9,500 people are diagnosed with skin cancer every day. More than two people die of the disease every hour.1,2,9\n\n'
          'More than 5.4 million cases of nonmelanoma skin cancer were treated in over 3.3 million people in the U.S. in 2012, the most recent year new statistics were available.1\n\n'
          'More people are diagnosed with skin cancer each year in the U.S. than all other cancers combined.2\n\n'
          'At least one in five Americans will develop skin cancer by the age of 70.3\n\n'
          'Actinic keratosis is the most common precancer; it affects more than 58 million Americans.4 \n\n'
          'The annual cost of treating skin cancers in the U.S. is estimated at \$8.1 billion: about \$4.8 billion for nonmelanoma skin cancers and \$3.3 billion for melanoma.5', isnetwork: true, onTap: () {  },
    );
  }
}
