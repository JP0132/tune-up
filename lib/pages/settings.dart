import 'package:flutter/material.dart';
import 'package:tune_up/constants/colours.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backgroundColour,
      body: Text("Settings", textAlign: TextAlign.center,),
    );
  }
}