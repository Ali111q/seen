import 'package:flutter/material.dart';

class MyColors {
  static const Color backGround = Color(0xff000000);
  static const Color swatch = Color(0xffFFFFFF);
  static Color unselected = Colors.white.withOpacity(0.6);
  static const Color secondaryColor = Color(0xffF26722);
  static const LinearGradient buttonGradient = LinearGradient(colors: [
    Color(0xffF26722),
    Color(0xffFCB323),
  ]);
  static LinearGradient onBoardingGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: const [
        0,
        0.6,
        1,
      ],
      colors: [
        Colors.black,
        Colors.black.withOpacity(0.66),
        Colors.transparent
      ]);
  static LinearGradient swiperGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [Colors.black.withOpacity(0.75), Colors.transparent]);
}
