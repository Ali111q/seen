import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:seen/controller/stream_controller.dart';
import 'package:video_player/video_player.dart';

class StreamFullScreenView extends StatefulWidget {
  StreamFullScreenView({super.key});

  @override
  State<StreamFullScreenView> createState() => _StreamFullScreenViewState();
}

class _StreamFullScreenViewState extends State<StreamFullScreenView> {
  StreamController streamController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamController.videoPlayerController.value?.play();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (streamController.videoPlayerController == null) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Live ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    )),
              ],
            ),
          ),
        );
      }
      return Scaffold(
          body: Column(
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: Chewie(
                controller: ChewieController(
                    videoPlayerController:
                        streamController.videoPlayerController.value!),
              )),
        ],
      ));
    });
  }
}
