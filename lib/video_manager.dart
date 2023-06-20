import 'package:video_player/video_player.dart';

class VideoPlayerManager {
  static final VideoPlayerManager _instance = VideoPlayerManager._internal();

  factory VideoPlayerManager() {
    return _instance;
  }

  VideoPlayerManager._internal();

  final List<VideoPlayerController> _videoPlayers = [];

  void addVideoPlayer(VideoPlayerController controller) {
    _videoPlayers.add(controller);
  }

  void removeVideoPlayer(VideoPlayerController controller) {
    _videoPlayers.remove(controller);
  }

  void disposeAll() {
    for (final controller in _videoPlayers) {
      controller.dispose();
    }
    _videoPlayers.clear();
  }
}
