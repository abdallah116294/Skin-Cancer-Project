import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/widgets/subtitle_widget.dart';
import 'package:mobile/core/widgets/title_text.dart';

class SelectedClinicWidget extends StatefulWidget {
  SelectedClinicWidget(
      {super.key,
      required this.image,
      required this.doctorname,
      required this.date,
      required this.address
      });

  // final String coffeeImage;
  // final String coffeeName;
  // final int coffePrice;
  // //final VoidCallback ontap;
  // final CardEntity cardEntity;
  // final String uid;
  final String image;
  final String doctorname;
  final String date;
  final String address;

  @override
  State<SelectedClinicWidget> createState() => _SelectedClinicWidgetState();
}

class _SelectedClinicWidgetState extends State<SelectedClinicWidget> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FittedBox(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  imageUrl: widget.image.toString(),
                  height: size.height * 0.2,
                  width: size.width * 0.4,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              IntrinsicWidth(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: size.width * 0.6,
                            child: TitlesTextWidget(
                              label: widget.doctorname,
                              maxLines: 2,
                            )),
                        Column(
                          children: [],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SubtitleTextWidget(
                          label: "In: "+' ${widget.date}',
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                        // SubtitleTextWidget(
                        //   label: '${widget.address}\$',
                        //   color: Colors.blue,
                        //   fontSize: 16,
                        // ),
                      ],
                    ),
                     SubtitleTextWidget(
                          label:"clinic address : "+ ' ${widget.address}',
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
