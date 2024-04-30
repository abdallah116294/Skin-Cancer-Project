import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:mobile/core/utils/app_color.dart';

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // double width = size.width;
    // double height = size.height;
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
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomClipPath2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.116822, size.height * -0.1111111);
    path_0.cubicTo(
        size.width * 0.9073738,
        size.height * -0.1111111,
        size.width * 0.7065093,
        size.height * -0.06896844,
        size.width * 0.5584065,
        size.height * 0.006046178);
    path_0.cubicTo(
        size.width * 0.4103051,
        size.height * 0.08106089,
        size.width * 0.3271028,
        size.height * 0.1828022,
        size.width * 0.3271028,
        size.height * 0.2888889);
    path_0.cubicTo(
        size.width * 0.3271028,
        size.height * 0.3949756,
        size.width * 0.4103051,
        size.height * 0.4967156,
        size.width * 0.5584065,
        size.height * 0.5717333);
    path_0.cubicTo(
        size.width * 0.7065093,
        size.height * 0.6467467,
        size.width * 0.9073738,
        size.height * 0.6888889,
        size.width * 1.116822,
        size.height * 0.6888889);
    path_0.lineTo(size.width * 1.116822, size.height * 0.2888889);
    path_0.lineTo(size.width * 1.116822, size.height * -0.1111111);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomClipPath3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.062397, size.height * 0.05409893);
    path_0.cubicTo(
        size.width * 1.062397,
        size.height * 0.2105021,
        size.width * 1.162479,
        size.height * 1.068674,
        size.width * 1.033333,
        size.height * 0.9667861);
    path_0.cubicTo(
        size.width * 1.132051,
        size.height * 1.174382,
        size.width * 0.005128128,
        size.height * 1.163297,
        size.width * 0.005128128,
        size.height * 1.006893);
    path_0.cubicTo(
        size.width * -0.05730821,
        size.height * 0.8892487,
        size.width * -0.1707410,
        size.height * 0.3157166,
        size.width * -0.04487179,
        size.height * 0.3157166);
    path_0.cubicTo(
        size.width * 0.6102564,
        size.height * 0.5443289,
        size.width * 1.030769,
        size.height * -0.1936404,
        size.width * 1.062397,
        size.height * 0.05409893);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
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
    paint_0_fill.shader = ui.Gradient.radial(
        const Offset(0, 0),
        size.width * 0.002564103,
        AppColor.ellipse3,
        [0.46875, 0.425104, 0.744792, 1]);
    // paint_0_fill.shader = ui.Gradient.linear(
    //     Offset(0, 0), Offset(0, .1), AppColor.onBoardingColor);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.062397, size.height * 0.05409893);
    path_0.cubicTo(
        size.width * 1.062397,
        size.height * 0.2105021,
        size.width * 1.162479,
        size.height * 1.068674,
        size.width * 1.033333,
        size.height * 0.9667861);
    path_0.cubicTo(
        size.width * 1.132051,
        size.height * 1.174382,
        size.width * 0.005128128,
        size.height * 1.163297,
        size.width * 0.005128128,
        size.height * 1.006893);
    path_0.cubicTo(
        size.width * -0.05730821,
        size.height * 0.8892487,
        size.width * -0.1707410,
        size.height * 0.3157166,
        size.width * -0.04487179,
        size.height * 0.3157166);
    path_0.cubicTo(
        size.width * 0.6102564,
        size.height * 0.5443289,
        size.width * 1.030769,
        size.height * -0.1936404,
        size.width * 1.062397,
        size.height * 0.05409893);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(const Offset(1, 3), Offset(2, 4), [
      const Color(0xffFF72B6).withOpacity(1),
      const Color(0xffF5C9D9).withOpacity(1),
      const Color(0xff97E1D4).withOpacity(1),
      const Color(0xff8359E3).withOpacity(1)
    ], [
      0.114583,
      0.390625,
      0.635417,
      0.942708
    ]);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.116822, size.height * -0.1111111);
    path_0.cubicTo(
        size.width * 0.9073738,
        size.height * -0.1111111,
        size.width * 0.7065093,
        size.height * -0.06896844,
        size.width * 0.5584065,
        size.height * 0.006046178);
    path_0.cubicTo(
        size.width * 0.4103051,
        size.height * 0.08106089,
        size.width * 0.3271028,
        size.height * 0.1828022,
        size.width * 0.3271028,
        size.height * 0.2888889);
    path_0.cubicTo(
        size.width * 0.3271028,
        size.height * 0.3949756,
        size.width * 0.4103051,
        size.height * 0.4967156,
        size.width * 0.5584065,
        size.height * 0.5717333);
    path_0.cubicTo(
        size.width * 0.7065093,
        size.height * 0.6467467,
        size.width * 0.9073738,
        size.height * 0.6888889,
        size.width * 1.116822,
        size.height * 0.6888889);
    path_0.lineTo(size.width * 1.116822, size.height * 0.2888889);
    path_0.lineTo(size.width * 1.116822, size.height * -0.1111111);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xfA7AEF9).withOpacity(.9);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Ellipse5 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // double width = size.width;
    // double height = size.height;
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.062397, size.height * 0.05409893);
    path_0.cubicTo(
        size.width * 1.062397,
        size.height * 0.2105021,
        size.width * 1.162479,
        size.height * 1.068674,
        size.width * 1.033333,
        size.height * 0.9667861);
    path_0.cubicTo(
        size.width * 1.132051,
        size.height * 1.174382,
        size.width * 0.005128128,
        size.height * 1.163297,
        size.width * 0.005128128,
        size.height * 1.006893);
    path_0.cubicTo(
        size.width * -0.05730821,
        size.height * 0.8892487,
        size.width * -0.1707410,
        size.height * 0.3157166,
        size.width * -0.04487179,
        size.height * 0.3157166);
    path_0.cubicTo(
        size.width * 0.6102564,
        size.height * 0.5443289,
        size.width * 1.030769,
        size.height * -0.1936404,
        size.width * 1.062397,
        size.height * 0.05409893);
    path_0.close();
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Ellips1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.116822, size.height * -0.1111111);
    path_0.cubicTo(
        size.width * 0.9073738,
        size.height * -0.1111111,
        size.width * 0.7065093,
        size.height * -0.06896844,
        size.width * 0.5584065,
        size.height * 0.006046178);
    path_0.cubicTo(
        size.width * 0.4103051,
        size.height * 0.08106089,
        size.width * 0.3271028,
        size.height * 0.1828022,
        size.width * 0.3271028,
        size.height * 0.2888889);
    path_0.cubicTo(
        size.width * 0.3271028,
        size.height * 0.3949756,
        size.width * 0.4103051,
        size.height * 0.4967156,
        size.width * 0.5584065,
        size.height * 0.5717333);
    path_0.cubicTo(
        size.width * 0.7065093,
        size.height * 0.6467467,
        size.width * 0.9073738,
        size.height * 0.6888889,
        size.width * 1.116822,
        size.height * 0.6888889);
    path_0.lineTo(size.width * 1.116822, size.height * 0.2888889);
    path_0.lineTo(size.width * 1.116822, size.height * -0.1111111);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Ellipse3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
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
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Ellips7 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.407407, size.height * 0.2338710);
    path_0.cubicTo(
        size.width * 1.407407,
        size.height * 0.6569919,
        size.width * 1.092348,
        size.height,
        size.width * 0.7037037,
        size.height);
    path_0.cubicTo(size.width * 0.3150585, size.height, 0,
        size.height * 0.6569919, 0, size.height * 0.2338710);
    path_0.cubicTo(
        0,
        size.height * -0.1892508,
        size.width * 0.3150585,
        size.height * -0.5322581,
        size.width * 0.7037037,
        size.height * -0.5322581);
    path_0.cubicTo(
        size.width * 1.092348,
        size.height * -0.5322581,
        size.width * 1.407407,
        size.height * -0.1892508,
        size.width * 1.407407,
        size.height * 0.2338710);
    path_0.close();
    return path_0;
  }

  @override
 bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
