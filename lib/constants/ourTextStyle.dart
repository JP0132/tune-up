import 'package:flutter/material.dart';
import 'colours.dart';


ourTextStyle({family = "Poppins", double? size = 18, colour = whiteColour, fontWeight = FontWeight.w400}){
  return  TextStyle(
    fontSize: size,
    color: colour,
    fontFamily: family,
    fontWeight: fontWeight,
  );
}