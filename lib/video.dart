import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final BuildContext context;

  const VideoPlayerWidget({super.key, required this.context});
  @override
  _ChewieDemoState createState() => _ChewieDemoState();
}

class _ChewieDemoState extends State<VideoPlayerWidget> {
  bool showControls = false;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _videoPlayerController = VideoPlayerController.network(
        'https://seen-dorto.s3.amazonaws.com/episode/1681682453seenvideo.m3u8');
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: true,
        showControls: false,
        aspectRatio: MediaQuery.of(widget.context).size.height /
            MediaQuery.of(widget.context).size.width);
    setState(() {});
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: showControlsFunction,
        child: Stack(
          children: [
            Chewie(controller: _chewieController!),
            AnimatedContainer(
              duration: Duration(milliseconds: 100),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: showControls
                  ? Colors.black.withOpacity(0.2)
                  : Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedOpacity(
                  opacity: showControls ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 100),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.settings),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // child: Container(),
    );
  }

  showControlsFunction() async {
    if (showControls) {
      setState(() {
        showControls = false;
      });
    } else {
      setState(() {
        showControls = true;
      });
      await Future.delayed(Duration(seconds: 7));
      setState(() {
        showControls = false;
      });
    }
  }
}
