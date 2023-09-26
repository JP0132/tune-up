import 'package:flutter/material.dart';
import 'package:tune_up/constants/colours.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backgroundColour,
      body: Text("Playlist", textAlign: TextAlign.center,),
    );
  }
}