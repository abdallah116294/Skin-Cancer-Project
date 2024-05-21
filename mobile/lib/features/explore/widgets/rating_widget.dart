import 'package:flutter/material.dart';

class RatingStarsWidget extends StatefulWidget {
  final double initialRating; // Rating value between 0 and 5
  final int starCount; // Total number of stars (typically 5)
  final Color starColor; // Color of the stars
  final double starSize; // Size of the stars
  Function(double)? onRatingChanged; 
   RatingStarsWidget({
    Key? key,
    required this.initialRating,
    this.starCount = 5,
    this.starColor = Colors.amber,
    this.starSize = 24.0,
     this.onRatingChanged
  }) : super(key: key);

  @override
  State<RatingStarsWidget> createState() => _RatingStarsWidgetState();
}

class _RatingStarsWidgetState extends State<RatingStarsWidget> {
  late double rating;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rating = widget.initialRating;
  }
    void updateRating(double newRating) {
    setState(() {
      rating = newRating;
    });
    widget.onRatingChanged!(newRating);
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        return GestureDetector(
          onTap: () {
            double newRating = (index + 1).toDouble();
            updateRating(newRating);
          },
          onHorizontalDragUpdate: (details) {
            RenderBox box = context.findRenderObject() as RenderBox;
            Offset position = box.globalToLocal(details.globalPosition);
            double newRating = (position.dx / widget.starSize).clamp(0, widget.starCount).toDouble();
            updateRating(newRating);
          },
          child: Icon(
            index < rating.floor()
                ? Icons.star
                : index < rating
                    ? Icons.star_half
                    : Icons.star_border,
            color: widget.starColor,
            size: widget.starSize,
          ),
        );
      }),
    );
  }
}
