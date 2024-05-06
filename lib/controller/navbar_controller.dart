import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seen/view/ads/ads.dart';
import 'package:seen/view/home/home.dart';
import 'package:seen/view/reels/reel_categories.dart';
import 'package:seen/view/stream/radio_channels.dart';
import 'package:seen/view/stream/stream_view.dart';

class NavbarController extends GetxController {
  RxInt index = 0.obs;
  List pages = [
    HomeView(),
    ReelCategories(),
    StreamView(),
    Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.7],
          colors: [Color(0xffef0001), Colors.black],
        )),
        child: RadioChannelsView()),
    AdsView(),
  ];

  void changeIndex(int i) {
    index.value = i;
  }
}
