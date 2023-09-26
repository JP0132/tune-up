import 'package:flutter/material.dart';

import 'package:tune_up/constants/colours.dart';


class Home extends StatelessWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      backgroundColor: backgroundColour,
      body: Text("Home", textAlign: TextAlign.center,),
    );
  }
}
