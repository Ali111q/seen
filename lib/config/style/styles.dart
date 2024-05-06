import 'package:flutter/material.dart';
import 'package:seen/config/style/colors.dart';

class MyStyles {
  // border radius ...
  static double buttonBorderRadius = 50.0;
  static double fieldBorderRadius = 20.0;
  static double cardBorderRadius = 10.0;

  // text styles ...
  static TextStyle pageTitleStyle = const TextStyle(
      fontWeight: FontWeight.w800, fontSize: 32, color: Colors.white);
  static final TextStyle hintStyle =
      TextStyle(fontSize: 24, color: Colors.white.withOpacity(0.75));
  static TextStyle buttonTitleStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle buttonTitleWhiteStyle = const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
  static TextStyle miniOrangeText = const TextStyle(
      color: MyColors.secondaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold);
  static TextStyle miniText = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

  static TextStyle normalText = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  static TextStyle normalOrangeText = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: MyColors.secondaryColor);
  static const TextStyle sliderSubtitle = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle adSubtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
}
