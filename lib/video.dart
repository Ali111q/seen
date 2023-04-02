import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  List<String> _qualityOptions = ['360p', '720p', '1080p'];
  int _selectedQualityIndex = 0;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _changeQuality(int index) async {
    String qualityUrl = _getQualityUrl(_qualityOptions[index]);
    setState(() {
      _selectedQualityIndex = index;
      _videoPlayerController = VideoPlayerController.network(qualityUrl);
      _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    });
    await _initializeVideoPlayerFuture;
    _videoPlayerController.play();
  }

  String _getQualityUrl(String quality) {
    // Replace the quality identifier in the URL with the selected quality
    String url = widget.videoUrl;
    String identifier = '.m3u8';
    int identifierIndex = url.lastIndexOf(identifier);
    String qualityIdentifier = '_' + quality + identifier;
    return url.substring(0, identifierIndex) + qualityIdentifier;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _qualityOptions.asMap().entries.map((entry) {
                    int index = entry.key;
                    String option = entry.value;
                    return GestureDetector(
                      onTap: () => _changeQuality(index),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: index == _selectedQualityIndex
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        child: Text(option),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
