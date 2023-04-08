import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class ReelsPlayerScreen extends StatefulWidget {
  const ReelsPlayerScreen({super.key});

  @override
  State<ReelsPlayerScreen> createState() => _ReelsPlayerScreenState();
}

class _ReelsPlayerScreenState extends State<ReelsPlayerScreen> {
  bool isPause = false;
  VideoPlayerController _controller = VideoPlayerController.asset(
      'assets/images/video.mp4',
      videoPlayerOptions: VideoPlayerOptions());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.initialize();
    _controller.play();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (isPause) {
                _controller.play();
                setState(() {
                  isPause = false;
                });
              } else {
                _controller.pause();
                setState(() {
                  isPause = true;
                });
              }
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: VideoPlayer(_controller)),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.07,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/images/person.svg'),
                      SvgPicture.asset('assets/images/seen_logo.svg'),
                    ],
                  ),
                ),
              )),
          isPause
              ? Center(
                  child: GestureDetector(
                  onTap: () {
                    if (isPause) {
                      _controller.play();
                      setState(() {
                        isPause = false;
                      });
                    } else {
                      _controller.pause();
                      setState(() {
                        isPause = true;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.8),
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.play_arrow,
                      size: 50,
                    ),
                  ),
                ))
              : Container()
        ],
      ),
    );
  }
}
