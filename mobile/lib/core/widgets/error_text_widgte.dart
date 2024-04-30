import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({super.key,required this.errormessage,});
  final String errormessage;
  @override
  Widget build(BuildContext context) {
    return  Text(errormessage,style:const TextStyle(color: Colors.red,fontSize: 15),);
  }
}