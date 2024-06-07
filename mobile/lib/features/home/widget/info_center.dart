import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/widgets/titles_text_widget.dart';

class InfoCenter extends StatelessWidget {
  final String imagePath;
  final String title;
  final void Function()? onTap;

  const InfoCenter({
    super.key,
    required this.imagePath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5.0,
                        spreadRadius: 0.0)
                  ]),
              child: Image.asset(height: 180.h, imagePath)),
          verticalSpacing(5),
          TitlesTextWidget(fontSize: 14, label: title)
        ],
      ),
    );
  }
}
