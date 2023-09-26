import 'package:flutter/material.dart';
import 'package:tune_up/constants/colours.dart';


class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backgroundColour,
      body: Text("Favourite", textAlign: TextAlign.center,),
    );
  }
}