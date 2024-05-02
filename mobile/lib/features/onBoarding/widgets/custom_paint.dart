import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class Ellipse3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.119864, size.height * 0.2781698);
    path_0.cubicTo(
        size.width * 1.171126,
        size.height * 0.5091985,
        size.width * 0.9865846,
        size.height * 0.7378327,
        size.width * 0.5521436,
        size.height * 0.7492047);
    path_0.cubicTo(
        size.width * 0.1279546,
        size.height * 0.7061111,
        size.width * -0.4974359,
        size.height * 0.8389388,
        size.width * -0.4974359,
        size.height * 0.6181286);
    path_0.cubicTo(
        size.width * -0.4974359,
        size.height * 0.3973196,
        size.width * -0.1066023,
        size.height * -0.07615481,
        size.width * 0.3201846,
        size.height * -0.07615481);
    path_0.cubicTo(
        size.width * 0.7469744,
        size.height * -0.07615481,
        size.width * 1.119864,
        size.height * 0.05735943,
        size.width * 1.119864,
        size.height * 0.2781698);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
      Offset(0, size.height * 0.5), // Start point
      Offset(size.width, size.height * 0.5), // End point
      [
        const Color(0xffFF72B6).withOpacity(0.9),
        const Color(0xffF492B6).withOpacity(0.85),
        const Color(0xff97E1D4).withOpacity(0.81),
        const Color(0xff8359E3).withOpacity(0.89),
      ],
      [
        0.0,
        0.4,
        0.7,
        1.0,
      ],
    );
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


//Copy this CustomPainter code to the Bottom of the File
class GifCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width,size.height*0.5000000);
    path_0.cubicTo(size.width,size.height*0.7761410,size.width*0.9513988,size.height,size.width*0.6129017,size.height);
    path_0.cubicTo(size.width*0.2744064,size.height,0,size.height*0.7761410,0,size.height*0.5000000);
    path_0.cubicTo(0,size.height*0.2238577,size.width*0.2744064,0,size.width*0.6129017,0);
    path_0.cubicTo(size.width*0.9513988,0,size.width,size.height*0.2238577,size.width,size.height*0.5000000);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xffF6D1D1).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width,size.height*0.5000000);
    path_1.cubicTo(size.width,size.height*0.7761410,size.width*0.9513988,size.height,size.width*0.6129017,size.height);
    path_1.cubicTo(size.width*0.2744064,size.height,0,size.height*0.7761410,0,size.height*0.5000000);
    path_1.cubicTo(0,size.height*0.2238577,size.width*0.2744064,0,size.width*0.6129017,0);
    path_1.cubicTo(size.width*0.9513988,0,size.width,size.height*0.2238577,size.width,size.height*0.5000000);
    path_1.close();

    Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
    paint_1_fill.color = Color(0xffC5CAFB).withOpacity(1.0);
    canvas.drawPath(path_1,paint_1_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}