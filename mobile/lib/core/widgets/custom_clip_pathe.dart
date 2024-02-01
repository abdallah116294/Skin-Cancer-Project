import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  var radius=10.0;
  @override
  Path getClip(Size size) {
    Path path = Path()
    ..lineTo(0, size.height)
    ..arcToPoint(Offset(size.width, size.height),
        radius: Radius.elliptical(30, 10))
    ..lineTo(size.width, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}