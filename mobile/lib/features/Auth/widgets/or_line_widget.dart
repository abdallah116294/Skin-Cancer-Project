import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/utils/string_manager.dart';

class OrLineWidget extends StatelessWidget {
  const OrLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(
              left: 10, right:20),
          child: const Divider(
            color: Colors.grey,
            height: 36,
            thickness: 2,
          ),
        )),
        Text(
          StringManager.ortext,
          style: TextStyle(
            fontSize:18.sp,color: Colors.grey),
        ),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(
              left:20, right: 10),
          child: Divider(
            color: Colors.grey,
            height: 36.h,
            thickness: 2,
          ),
        ))
      ],
    );
  }
}