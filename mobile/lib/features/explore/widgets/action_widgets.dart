import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/widgets/sub_title_widgets.dart';

class ProfileAction extends StatelessWidget {
  ProfileAction(
      {super.key,
        required this.title,
        required this.icondata,
        required this.function,
        required this.icondata2
      });

  String title;
  IconData icondata;
  IconData icondata2;
  VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5.0,
                  spreadRadius: 0.0
              )
            ]
        ),
      child: ListTile(
        onTap: function,
        leading: Icon(
         icondata2,
        ),
        title: SubtitleTextWidget(label: title),
        trailing: Icon(icondata),
      ),
    );
  }
}