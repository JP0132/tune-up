import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

Widget buildMarquee(String text, TextStyle style, int threshold, [height = 25.0]) {
 
  if (text.length > threshold) {
    return Container(
      height: height,
      child: Marquee(
        text: text,
        style: style,
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        velocity: 50.0,
        pauseAfterRound: Duration(seconds: 1),
        accelerationDuration: Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  } else {
    return Text(
      text,
      style: style,
    );
  }
}
