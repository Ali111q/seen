import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final BuildContext context;
  final List link;
  const VideoPlayerWidget(
      {super.key, required this.context, required this.link});
  @override
  _ChewieDemoState createState() => _ChewieDemoState();
}

class _ChewieDemoState extends State<VideoPlayerWidget> {
  bool showControls = false;
  bool _isDragging = false;
  bool isPlay = false;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _videoPlayerController = VideoPlayerController.network(widget.link[0]);

    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: true,
        showControls: false,
        aspectRatio: MediaQuery.of(widget.context).size.height /
            MediaQuery.of(widget.context).size.width);
    _videoPlayerController!.addListener(() {
      final position = _videoPlayerController!.value.position;

      setState(() {});
    });
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
    List qualities = [
      ListTile(
        textColor: Colors.white,
        title: Text('480'),
        onTap: () async {
          _videoPlayerController =
              VideoPlayerController.network(widget.link[0]);

          setState(() {
            _chewieController = ChewieController(
                videoPlayerController: _videoPlayerController!,
                autoPlay: true,
                looping: true,
                showControls: false,
                aspectRatio: MediaQuery.of(widget.context).size.height /
                    MediaQuery.of(widget.context).size.width);
          });
          Navigator.of(context).pop();
        },
      ),
      ListTile(
        textColor: Colors.white,
        title: Text('720'),
        onTap: () async {
          Duration? time = await _videoPlayerController!.position;
          _videoPlayerController!.dispose();
          _videoPlayerController =
              VideoPlayerController.network(widget.link[1]);
          if (_videoPlayerController!.value.isPlaying) {
            _chewieController!.pause();
          }
          _chewieController!.dispose();
          var _newChewieController = ChewieController(
              videoPlayerController: _videoPlayerController!,
              autoPlay: true,
              looping: true,
              showControls: false,
              aspectRatio: MediaQuery.of(context).size.height /
                  MediaQuery.of(context).size.width);

          setState(() {
            _chewieController = _newChewieController;
          });
          _chewieController!.seekTo(time!);
          Navigator.of(context).pop();
        },
      ),
      ListTile(
        textColor: Colors.white,
        title: Text('1080'),
        onTap: () async {
          _videoPlayerController!.dispose();

          _videoPlayerController =
              VideoPlayerController.network(widget.link[0]);
          await _videoPlayerController!.initialize();
          setState(() {
            _chewieController = ChewieController(
                videoPlayerController: _videoPlayerController!,
                autoPlay: true,
                looping: true,
                showControls: false,
                aspectRatio: MediaQuery.of(widget.context).size.height /
                    MediaQuery.of(widget.context).size.width);
          });
          Navigator.of(context).pop();
        },
      )
    ];
    List speeds = [
      ListTile(
        textColor: Colors.white,
        title: Text('0.50'),
      ),
      ListTile(
        textColor: Colors.white,
        title: Text('1.0'),
      ),
      ListTile(
        textColor: Colors.white,
        title: Text('1.5'),
      ),
      ListTile(
        textColor: Colors.white,
        title: Text('2.0'),
      )
    ];
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
                          IconButton(
                            onPressed: showControls
                                ? () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return BottomSheet(
                                              backgroundColor:
                                                  Color(0xff0B0E19),
                                              onClosing: () {},
                                              builder: (context) {
                                                return ListView(
                                                  children: [
                                                    ExpansionTile(
                                                      title: Text(
                                                        'quality',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      textColor: Colors.white,
                                                      collapsedIconColor:
                                                          Colors.white,
                                                      children: [
                                                        ...qualities
                                                            .map((e) => e)
                                                      ],
                                                    ),
                                                    ExpansionTile(
                                                      title: Text(
                                                        'show speed',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      textColor: Colors.white,
                                                      collapsedIconColor:
                                                          Colors.white,
                                                      children: [
                                                        ...speeds.map((e) => e)
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              });
                                        });
                                  }
                                : null,
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Center(
                        child: _isDragging
                            ? Text('data')
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: IconButton(
                                      onPressed: () async {
                                        _videoPlayerController!.seekTo(
                                            (await _videoPlayerController!
                                                    .position)! -
                                                const Duration(seconds: 5));
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.replay_5_sharp),
                                      iconSize: 60,
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: showControls
                                        ? () {
                                            setState(() {
                                              isPlay = !isPlay;
                                            });
                                            if (isPlay) {
                                              _videoPlayerController!.pause();
                                            } else {
                                              _videoPlayerController!.play();
                                            }
                                          }
                                        : null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.6),
                                          shape: BoxShape.circle),
                                      child: isPlay
                                          ? Icon(
                                              Icons.play_arrow,
                                              size: 80,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            )
                                          : Icon(
                                              Icons.pause_sharp,
                                              size: 80,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    child: IconButton(
                                      onPressed: () async {
                                        _videoPlayerController!.seekTo(
                                            (await _videoPlayerController!
                                                    .position)! +
                                                const Duration(seconds: 5));
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.forward_5_rounded),
                                      iconSize: 60,
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Spacer(),
                      _buildProgressBar()
                    ],
                  ),
                ),
              ),
            ),
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

  Widget _buildProgressBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // LinearProgressIndicator(
        //   value: _videoPlayerController!.value.buffered.isNotEmpty
        //       ? _videoPlayerController!.value.buffered.last.end.inMilliseconds /
        //           _videoPlayerController!.value.duration.inMilliseconds
        //       : 0.0,
        // ),
        Row(
          children: [
            SizedBox(width: 12.0),
            Text(
              _durationToString(_videoPlayerController!.value.position),
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: _buildSlider(),
              ),
            ),
            Text(
              _durationToString(_videoPlayerController!.value.duration),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 12.0),
          ],
        ),
      ],
    );
  }

  Widget _buildSlider() {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: CustomTrackShape(),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 16.0),
      ),
      child: Slider(
        value: _videoPlayerController!.value.position.inMilliseconds.toDouble(),
        min: 0.0,
        max: _videoPlayerController!.value.duration.inMilliseconds.toDouble(),
        onChanged: (value) {
          setState(() {
            _isDragging = true;
            _videoPlayerController!.seekTo(
              Duration(milliseconds: value.toInt()),
            );
          });
        },
        onChangeEnd: (value) {
          setState(() {
            _isDragging = false;
          });
          _videoPlayerController!.seekTo(
            Duration(milliseconds: value.toInt()),
          );
        },
        activeColor: Colors.white,
        inactiveColor: Colors.white.withOpacity(0.5),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight!;
    final trackLeft = offset.dx + 24.0;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width - 48.0;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

String _durationToString(Duration duration) {
  return duration.inMinutes.remainder(60).toString().padLeft(2, '0') +
      ':' +
      duration.inSeconds.remainder(60).toString().padLeft(2, '0');
}
