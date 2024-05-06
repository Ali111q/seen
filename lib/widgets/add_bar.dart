import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:seen/core/extension.dart';

import '../data/model/ad.dart';

class AddBar extends StatelessWidget {
  const AddBar({
    super.key,
    required this.ads,
  });
  final List<Ad> ads;
  @override
  Widget build(BuildContext context) {
    if (ads.length == 1) {
      return Container(
        width: 100.h(context),
        height: 15.w(context),
        child: Image.network(
          ads[0].file,
          fit: BoxFit.fitWidth,
        ),
      );
    }
    return Swiper(
        itemCount: ads.length,
        onIndexChanged: (value) {},
        itemBuilder: (context, index) {
          return Container(
            width: 100.h(context),
            height: 15.w(context),
            child: Image.network(
              ads[index].file,
              fit: BoxFit.fitWidth,
            ),
          );
        });
  }
}
