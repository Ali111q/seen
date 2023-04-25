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

  VideoPlayerController _controller = VideoPlayerController.network(
      'https://seen-dorto.s3.amazonaws.com/Reels/reel1682394256video.MP4',
      videoPlayerOptions: VideoPlayerOptions());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.initialize().then((value) {
      setState(() {});
    });
    _controller.play();
    _controller.setLooping(true);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
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
      backgroundColor: Colors.black,
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
            child: Center(
              child: Container(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller))
                      : Container()),
            ),
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
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                      ),
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
              : Container(),
          Positioned(
              bottom: 10,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            ReelAction(
                              image: 'assets/images/like.svg',
                              count: '40 k',
                            ),
                            ReelAction(
                              image: 'assets/images/dislike.svg',
                              count: '20 k',
                            ),
                            ReelAction(
                              image: 'assets/images/seen_colorsless.svg',
                              count: '20 k',
                            ),
                            ReelAction(
                              image: 'assets/images/comment.svg',
                              count: '20 k',
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'اسامة',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'font',
                                fontSize: 21),
                          ),
                          Container(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.width * 0.07,
                            color: Colors.white,
                          ),
                          Container(
                            height: 10,
                          ),
                          Text(
                            'اتينت شسين تساشني يا',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'font',
                                fontSize: 21),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class ReelAction extends StatelessWidget {
  const ReelAction({
    super.key,
    required this.image,
    required this.count,
  });
  final String image;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SvgPicture.asset(image),
          Container(
            height: 5,
          ),
          Text(
            count,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
