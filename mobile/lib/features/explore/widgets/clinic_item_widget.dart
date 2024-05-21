import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/features/explore/widgets/rating_widget.dart';
import 'package:mobile/features/explore/widgets/rating_widgets_without_clic.dart';

class ClinicItemWidget extends StatefulWidget {
  const ClinicItemWidget(
      {super.key,
      required this.clinicAddress,
      required this.clinicName,
      required this.rate});
  final String clinicName;
  final String clinicAddress;
  final double rate;

  @override
  State<ClinicItemWidget> createState() => _ClinicItemWidgetState();
}

class _ClinicItemWidgetState extends State<ClinicItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Container(
        width: 343.w,
        height: 86.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 0,
                blurRadius: 10,
              ),
            ]),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              child: Image.asset("assets/image/doc1.png"),
            ),
            horizontalSpacing(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.clinicName,
                  style: TextStyles.font24PrimaryW700.copyWith(fontSize: 15),
                ),
                verticalSpacing(2),
                Text(
                  widget.clinicAddress,
                  style: TextStyles.font14BlackW300
                      .copyWith(color: Color(0xFF828BE7)),
                ),
                 RatingStarsWidgetWithoutClick(rating: widget.rate/2,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
