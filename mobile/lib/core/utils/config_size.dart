import 'package:flutter/material.dart';

class ConfigSize {

  static double? screenHeight;
  static double? screenWidth;
  static double? defaultSize;
  static Orientation? orientation;


  void init( BuildContext context){

    if(screenWidth == null || screenHeight == null || defaultSize == null){
      screenHeight =MediaQuery.of(context).size.height;
      screenWidth=MediaQuery.of(context).size.width;
      orientation=MediaQuery.of(context).orientation;
      defaultSize = orientation ==Orientation.landscape? screenHeight! *.024 :screenWidth! *.024 ;

    }
  }
}