import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:video_player/video_player.dart';

class StreamController extends GetxController {
  Rx<VideoPlayerController?> videoPlayerController = Rx(null);

  void setVideoPlayerController(VideoPlayerController con) {
    videoPlayerController.value = con;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.value?.dispose();
    videoPlayerController.value = null;
  }
}
