import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.height = 100, this.width = 100});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: SvgPicture.asset('assets/svg/logo.svg'));
  }
}
