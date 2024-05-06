import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:qyplayer/Widgets/widget_volume.dart';
import 'package:seen/controller/radio_controller.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/data/model/radio.dart';
import 'package:seen/widgets/app_bar.dart';
import 'package:seen/widgets/logo.dart';
import 'package:seen/widgets/sound_level_indecator.dart';
import 'package:seen/widgets/voice_indicator.dart';
import 'package:svg_flutter/svg.dart';

class RadioView extends StatefulWidget {
  RadioView({super.key});

  @override
  State<RadioView> createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> {
  RadioController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    RadioChannel channel = controller.radioList.firstWhere((element) =>
        element.id.toString() == controller.channelId.value.toString());
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.2, 0.7],
        colors: [Color(0xffef0001), Colors.black],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: SvgPicture.asset('assets/svg/logo_new.svg'),
          centerTitle: true,
          actions: [
            AppBarCircleAvatar(),
            Container(
              width: 10,
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 13.h(context),
            ),
            Center(
              child: RadioDisk(),
            ),
            Container(
              height: 20,
            ),
            Container(
              width: 80.w(context),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          controller.radioList
                              .firstWhere((element) =>
                                  element.id == controller.channelId.value)
                              .name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          )),
                      Text(
                          controller.radioList
                              .firstWhere((element) =>
                                  element.id == controller.channelId.value)
                              .enName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          controller.radioList
                              .firstWhere((element) =>
                                  element.id == controller.channelId.value)
                              .bodcaster,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(0.75))),
                      Text(
                          controller.radioList
                              .firstWhere((element) =>
                                  element.id == controller.channelId.value)
                              .bodcaster,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(0.75))),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 5.h(context),
            ),
            Obx(
              () => AudioPlayerWidget(
                  url: controller.radioList
                      .firstWhere(
                          (element) => element.id == controller.channelId.value)
                      .url),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  ...controller.radioList
                      .mapWithIndex((i, e) => GestureDetector(
                            onTap: () {
                              controller.changeChannelIndex(e.id);
                              controller.changeRadioChannel();
                            },
                            child: CircleAvatar(
                              radius:
                                  controller.channelId.value == e.id ? 50 : 30,
                              backgroundImage: AssetImage(e.bodcasterImage),
                            ),
                          )),
                  Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RadioDisk extends StatelessWidget {
  RadioDisk({
    super.key,
  });
  RadioController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return RotatingDisk(
      child: Obx(
        () => Container(
          width: 70.w(context),
          height: 70.w(context),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
            // border: Border.all(color: Colors.white, width: 5),
            image: DecorationImage(
                image: AssetImage(controller.radioList
                    .firstWhere(
                        (element) => element.id == controller.channelId.value)
                    .image),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Container(
              width: 20.w(context),
              height: 20.w(context),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter,
                    colors: [
                      Color(0xffEF0001),
                      Color(0xff000000),
                    ],
                  ),
                  shape: BoxShape.circle),
            ),
          ),
        ),
      ),
    );
  }
}

class RotatingDisk extends StatefulWidget {
  final Widget child;

  const RotatingDisk({super.key, required this.child});
  @override
  _RotatingDiskState createState() => _RotatingDiskState();
}

class _RotatingDiskState extends State<RotatingDisk>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _controller.repeat(reverse: false);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        // width: 100,
        // height: 100,
        // color: Colors.blue,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
