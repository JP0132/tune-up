import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'colours.dart';

navBarItemStyle({icon = const Icon(Icons.apps_outlined), name = "Home"}){
  return  BottomNavyBarItem(
    icon: icon,
    title: Text(name),
    textAlign: TextAlign.center,
    activeColor: accentColour,
    inactiveColor: whiteColour
  );
}