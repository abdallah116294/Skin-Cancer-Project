import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/widgets/titles_text_widget.dart';

class AIResultWidget extends StatefulWidget {
  const AIResultWidget({super.key, required this.image,required this.output,required this.onTap});
   
  final String image;
  final String output;
final void Function()? onTap;
  @override
  State<AIResultWidget> createState() => _AIResultWidgetState();
}

class _AIResultWidgetState extends State<AIResultWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  InkWell(
      onTap: widget.onTap,
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
              child: ClipRect(clipBehavior: Clip.antiAlias,child: Image.network(height: 180.h,widget.image,))),
          verticalSpacing(5),
          TitlesTextWidget(fontSize: 14, label: widget.output)
        ],
      ),
    );         
  }
}