import 'package:flutter/material.dart';

class Constants {
  static Duration defaultAnimationSpeed = const Duration(milliseconds: 350);
  static Duration fastAnimationSpeed = const Duration(milliseconds: 150);
  static Duration slowAnimationSpeed = const Duration(milliseconds: 650);
  static Duration longAnimationSpeed = const Duration(seconds: 3);
  static Duration instantAnimationSpeed = const Duration(milliseconds: 50);
  static LinearGradient whiteToGreyGradient = LinearGradient(
      colors: [Colors.white, Colors.grey.shade200],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static BorderRadius br = BorderRadius.circular(10);
  static BorderRadius lbr = BorderRadius.circular(5.0);
  // static brRadisu = 5.0;
  static List<BoxShadow> boxShadow = [
    BoxShadow(
      blurRadius: 10,
      spreadRadius: 2,
      color: Colors.black.withOpacity(.05),
    )
  ];
  static var ePadding = const EdgeInsets.all(10);
  static Color greenColor = const Color.fromRGBO(93, 194, 136, 1);
  static Color redColor = const Color.fromRGBO(237, 121, 109, 1);
  static Color blueColor = const Color.fromRGBO(99, 162, 255, 1);
  static Color greyColor = const Color.fromARGB(235, 235, 235, 255);
  static Color purpleColor = const Color.fromARGB(235, 197, 96, 255);

  static double cardMargin = 10;
  static double cardVerticalMargin = 10.0;
  static double cardpadding = 10.0;
  static Curve curve = Curves.fastLinearToSlowEaseIn;

  static const double opacity = 0.7;
  static double lightOpacity = .5;
}
