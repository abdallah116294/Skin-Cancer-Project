import 'package:flutter/material.dart';

class RatingStarsWidgetWithoutClick extends StatelessWidget {
  final double rating; // Rating value between 0 and 10
  final int starCount; // Total number of stars (typically 5)
  final Color starColor; // Color of the stars
  final double starSize; // Size of the stars

  const RatingStarsWidgetWithoutClick({
    Key? key,
    required this.rating,
    this.starCount = 5,
    this.starColor = Colors.amber,
    this.starSize = 24.0,
  }) : super(key: key);

  double get convertedRating => rating / 2.0; // Convert 10-point rating to 5-point rating

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        if (index < convertedRating.floor()) {
          return Icon(
            Icons.star,
            color: starColor,
            size: starSize,
          );
        } else if (index < convertedRating) {
          return Icon(
            Icons.star_half,
            color: starColor,
            size: starSize,
          );
        } else {
          return Icon(
            Icons.star_border,
            color: starColor,
            size: starSize,
          );
        }
      }),
    );
  }
}
