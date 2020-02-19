import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  int currentStars = 0;
  int stars = 5;
  double starSize = 20;
  double width = 200;
  double height = 50;
  Color highlightColor = Colors.black;
  Color unHighLightedColor = Colors.yellow;

  RatingBar(
      {this.currentStars,
      this.stars,
      this.starSize,
      this.width,
      this.height,
      this.highlightColor,
      this.unHighLightedColor});

  @override
  _RatingBar createState() => _RatingBar();
}

class _RatingBar extends State<RatingBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.stars,
          itemBuilder: (BuildContext contex, int index) {
            if (index >= widget.currentStars) {
              return Icon(Icons.star, color: widget.unHighLightedColor, size: widget.starSize,);
            }else {
              return Icon(Icons.star, color: widget.highlightColor, size: widget.starSize,);
            }
          },
        ));
  }
}
