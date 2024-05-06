import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seen/controller/radio_controller.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/data/model/radio.dart';
import 'package:seen/widgets/app_bar.dart';
import 'package:svg_flutter/svg_flutter.dart';

class RadioChannelsView extends StatelessWidget {
  RadioChannelsView({super.key});
  RadioController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/svg/logo_new.svg'),
                AppBarCircleAvatar(),
              ],
            ),
            Container(
              height: 30,
            ),
            Expanded(
                child: ListView(
              children: [
                ...controller.radioList.map((e) => RadioChannelsWidget(
                      radio: e,
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class RadioChannelsWidget extends StatelessWidget {
  final RadioChannel radio;
  RadioController controller = Get.find();
  RadioChannelsWidget({
    super.key,
    required this.radio,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.changeChannelIndex(radio.id);
        Get.toNamed('/radio');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: 75.w(context),
        height: 100.w(context),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(radio.image)),
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 75.w(context),
          height: 100.w(context),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xbf131313), Color(0x000a0a0a), Color(0xbf000000)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 15.w(context),
                    height: 15.w(context),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(radio.bodcasterImage)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          Get.locale!.languageCode == 'en'
                              ? radio.enName
                              : radio.name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      Text(
                          Get.locale!.languageCode == 'en'
                              ? radio.enSubtitle
                              : radio.subtitle,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white))
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.changeChannelIndex(radio.id);
                      Get.toNamed('/radio');
                    },
                    icon: Icon(Icons.play_circle),
                    color: Colors.white,
                    iconSize: 50,
                  ),
                  Text(radio.bodcaster,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.75)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
