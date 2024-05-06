// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:seen/controller/ad_controller.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/data/model/ad.dart';
import 'package:seen/widgets/app_bar.dart';
import 'package:seen/widgets/loading.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class AdsView extends StatelessWidget {
  AdsView({super.key});
  AdController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, isSearch: false),
      body: Obx(
        () => ListView(
          children: [
            ...controller.ads.map(
              (element) => AdWidget(ad: element),
            )
          ],
        ),
      ),
    );
  }
}

class AdWidget extends StatelessWidget {
  VideoPlayerController? controller;
  AdWidget({
    super.key,
    required this.ad,
  });
  final Ad ad;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ad.local_title,
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              )),
          Text(ad.local_description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              )),
          if (ad.file_type != 'video')
            Image.network(
              ad.file,
              width: 100.w(context),
              fit: BoxFit.fitWidth,
            ),
          if (ad.file_type == 'video')
            Stack(
              children: [
                YoYoPlayer(
                  videoLoadingStyle:
                      VideoLoadingStyle(loading: LoadingWidget()),
                  url: ad.file,
                  showControls: false,
                  onVideoInitCompleted: (controller) {
                    this.controller = controller;
                  },
                  autoPlayVideoAfterInit: false,
                ),
                IconButton(
                    enableFeedback: false,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      if (controller != null && controller!.value.isPlaying) {
                        print('object');
                        controller!.pause();
                      } else {
                        print('object1');
                        controller?.play() ?? print('null');
                      }
                    },
                    icon: Container(
                      width: 100.w(context),
                      height: 19.h(context),
                    ))
              ],
            ),
          Row(
            children: [
              if (ad.instagram != null)
                adSlice(
                  icon: 'assets/svg/world.svg',
                  title: 'instagram',
                  onTap: () async {
                    if (!await launchUrl(Uri.parse(ad.instagram!))) {
                      throw Exception('Could not launch $ad.instagram');
                    }
                  },
                ),
              if (ad.website != null)
                adSlice(
                  icon: 'assets/svg/world.svg',
                  title: 'website',
                  onTap: () async {
                    if (!await launchUrl(Uri.parse(ad.website!))) {
                      throw Exception('Could not launch $ad.instagram');
                    }
                  },
                ),
              if (ad.lat != null)
                adSlice(
                  icon: 'assets/svg/pin.svg',
                  title: 'location',
                  onTap: () async {
                    openMap(double.parse(ad.lat!), double.parse(ad.lng!));
                  },
                ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class adSlice extends StatelessWidget {
  const adSlice(
      {super.key, required this.title, this.onTap, required this.icon});
  final String title;
  final void Function()? onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(
              left: Get.locale!.languageCode == 'us' ? 0 : 10,
              right: Get.locale!.languageCode != 'us' ? 0 : 10,
              top: 10,
              bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Row(
            children: [
              SvgPicture.asset(icon),
              Container(
                width: 5,
              ),
              Text(title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ))
            ],
          )),
    );
  }
}
