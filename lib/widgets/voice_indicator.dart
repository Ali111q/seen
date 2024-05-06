import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:seen/controller/radio_controller.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;

  AudioPlayerWidget({required this.url});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  RadioController controller = Get.find();
  int id = 0;
  @override
  void initState() {
    super.initState();
    controller.init(widget.url).then((value) {
      setState(() {
        id = 2;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.disposePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(controller.radioState.value);
      return !controller.radioState.value || controller.player.value == null
          ? CircularProgressIndicator()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    color: Colors.white,
                    iconSize: 80,
                    onPressed: () {},
                    icon: Icon(Get.locale!.languageCode != 'us'
                        ? Icons.skip_previous
                        : Icons.skip_next)),
                IconButton(
                  icon: Icon(
                    controller.isPlaying.value
                        ? Icons.pause_circle
                        : Icons.play_circle,
                    size: 80,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (controller.isPlaying.value) {
                      setState(() {
                        controller.player.value?.pause();
                      });
                    } else {
                      setState(() {
                        controller.player.value?.play();
                      });
                    }
                  },
                ),
                IconButton(
                    color: Colors.white,
                    iconSize: 80,
                    onPressed: () {},
                    icon: Icon(Get.locale!.languageCode == 'us'
                        ? Icons.skip_previous
                        : Icons.skip_next)),
              ],
            );
    });
  }
}
