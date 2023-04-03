import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppBar extends AppBar {
  final String titleText;

  MyAppBar({required this.titleText})
      : super(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: [
                SvgPicture.asset('assets/images/person.svg'),
                Container(
                  width: 20,
                ),
                SvgPicture.asset('assets/images/search.svg'),
                Container(
                  width: 20,
                ),
                SvgPicture.asset('assets/images/screen.svg')
              ],
            ),
            actions: [
              SvgPicture.asset('assets/images/seen_logo.svg'),
              Container(
                width: 10,
              )
            ]);
}
