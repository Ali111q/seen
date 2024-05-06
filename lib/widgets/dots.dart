import 'package:flutter/material.dart';

import '../config/style/colors.dart';

class Dots extends StatelessWidget {
  Dots({super.key, required this.index, required this.itemsCount});

  final int itemsCount;
  int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
            itemsCount,
            (index) => Container(
                  margin: EdgeInsets.all(5),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: this.index == index
                          ? MyColors.swatch
                          : Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle),
                ))
      ],
    );
  }
}
