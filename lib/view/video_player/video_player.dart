import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:logger/logger.dart';
import 'package:seen/widgets/loading.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String? videoUrl;
  final VideoPlayerController? controller;

  VideoPlayerScreen({
    this.videoUrl,
    this.controller,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool showControlls = true;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void initState() {
    Logger().i('controller:${widget.controller}');
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: const Locale('en_US'),
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              YoYoPlayer(
                videoLoadingStyle: VideoLoadingStyle(loading: LoadingWidget()),
                controller: widget.controller,
                url: widget.videoUrl ??
                    'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8',
                onVideoInitCompleted: (controller) {
                  setState(() {
                    showControlls = false;
                  });
                  SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.immersiveSticky,
                  );
                },
                onFullScreen: (fullScreenTurnedOn) {
                  if (!fullScreenTurnedOn) {
                    Navigator.pop(context);
                  }
                },
                onShowMenu: (showMenu, m3u8Show) {
                  print(showMenu);
                  setState(() {
                    showControlls = showMenu;
                  });
                },
                displayFullScreenAfterInit: true,
              ),
              if (showControlls)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Get.locale!.languageCode == 'en'
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )),
                )
            ],
          ),
        ),
      ),
    );
  }
}
