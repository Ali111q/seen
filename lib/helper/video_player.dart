import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/model/reel.dart';
import 'package:video_player/video_player.dart';

import '../controller/reels_controller.dart';
import '../controller/user_controller.dart';
import '../reel_screen.dart';

class VidePlayerReel extends StatefulWidget {
  final String videoUrl;
   VidePlayerReel({Key? key, required this.videoUrl, required this.src, required this.reel, required this.isLiked}) : super(key: key);
  final String src;
  final ReelVideo reel ;
   bool isLiked;
  @override
  State<VidePlayerReel> createState() => _VidePlayerItemState();
}

class _VidePlayerItemState extends State<VidePlayerReel> with SingleTickerProviderStateMixin {
  bool _isLiked = false;
    late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
   bool _showControlls = true;
  late VideoPlayerController videoPlayerController;
  bool isInitialized = false;

  @override
  void initState() {
    print('object');
    super.initState();
      _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),);
   initializePlayer();
  }

  @override
  void dispose() {
    super.dispose();
    if (isInitialized) {
      videoPlayerController.pause();
      videoPlayerController.dispose();
    }
  }
  Future<void> initializePlayer() async {
    print(widget.src);
    // final cachedVideoPath = await cacheNetworkVideo(widget.src!);

    videoPlayerController = VideoPlayerController.network(widget.src);
    await videoPlayerController.initialize().then((_) {
        setState(() {
          isInitialized = true;
        });
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
        videoPlayerController.setLooping(true);
      });



    setState(() {});
  }

  Future<String> cacheNetworkVideo(String videoUrl) async {
    final videoCacheManager = CacheManager(Config('cacheCustomkey',
        stalePeriod: const Duration(hours: 4), maxNrOfCacheObjects: 100));
    final file = await videoCacheManager.getSingleFile(videoUrl);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (isInitialized) {
          videoPlayerController.pause();
          videoPlayerController.dispose();
        }
        return true;
      },
      child: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: isInitialized
            ? GestureDetector(
              behavior: HitTestBehavior.translucent,
      onLongPress: () {
        if (videoPlayerController.value.isInitialized ) {
          videoPlayerController.pause();
          setState(() {
            _showControlls = false;
          });
        }
      },
      onLongPressEnd: (e) {
        if (videoPlayerController.value.isInitialized ) {
          videoPlayerController.play();
          setState(() {
            _showControlls = true;
          });
        }
      },
      onLongPressCancel: () {
        if (videoPlayerController.value.isInitialized ) {
          videoPlayerController.play();
          setState(() {
            _showControlls = true;
          });
        }
      },
      onLongPressMoveUpdate: (e) {
        if (videoPlayerController.value.isInitialized) {
          videoPlayerController.play();
          setState(() {
            _showControlls = true;
          });
        }
      },
      onDoubleTap: _handleDoubleTap,
              child: Stack(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController)),
                  ),
                   AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: videoPlayerController.value.isInitialized && _showControlls ? 1 : 0,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.2)
                    ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (Provider.of<UserController>(context,
                                        listen: false)
                                    .user !=
                                null) {
                              setState(() {
                                widget.isLiked = !widget.isLiked;
                              });
                              Provider.of<ReelsController>(context, listen: false)
                                  .like(
                                      widget.reel.id,
                                      Provider.of<UserController>(context,
                                              listen: false)
                                          .user!
                                          .token);
                            } else {
                              videoPlayerController.pause();
                              Navigator.of(context)
                                  .pushNamed('/login')
                                  .then((value) {
                                videoPlayerController.play();
                              });
                            }
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: widget.isLiked ? Colors.red : Colors.white,
                          ),
                        ),
                        Text(
                          widget.reel.likes_count.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                        IconButton(
                          onPressed: () {
                            if (Provider.of<UserController>(context,
                                        listen: false)
                                    .user !=
                                null) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Comments(id: widget.reel.id);
                                  });
                            } else {
                              videoPlayerController.pause();
                              Navigator.of(context)
                                  .pushNamed('/login')
                                  .then((value) {
                                videoPlayerController.play();
                              });
                            }
                          },
                          icon: SvgPicture.asset('assets/images/comment.svg'),
                        ),
                        Text(
                          widget.reel.comments_count.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                              'assets/images/seen_colorsless.svg'),
                        ),
                        Text(
                          widget.reel.views_count.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(
                            widget.reel.title,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    widget.reel.ad!=null?
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.width * 0.06,
                              color: Colors.white,
                              child: Image.network(widget.reel.ad!.file),
                            )
                          ],
                        ),
                      ):Container(),
                    Container(
                      height: 50,
                    )
                  ],
                ),
              ),
                      ),
                        Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _isLiked ? 1 : 0,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget? child) {
                  return Transform.scale(
                    scale: _isLiked ? _scaleAnimation.value : 1.0,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.grey,
                      size: 80.0,
                    ),
                  );
                },
              ),
            ),
          ),
                ],
              ),
            )
            : Image.asset(
                'assets/images/loading.gif',
                height: MediaQuery.of(context).size.width * 0.8,
              ),
      ),
    );
  }
   void _handleDoubleTap() {
    setState(() {
      _isLiked = true;
    });
    _animationController.forward();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isLiked = false;
      });
      _animationController.reverse();
    });
    if (Provider.of<UserController>(context, listen: false).user != null) {
      if (!widget.isLiked) {
        setState(() {
          widget.isLiked = true;
        });
        Provider.of<ReelsController>(context, listen: false).like(
            widget.reel.id,
            Provider.of<UserController>(context, listen: false).user!.token);
      }
    } else {
      videoPlayerController.pause();
      Navigator.of(context).pushNamed('/login').then((value) {
        videoPlayerController.play();
      });
    }
  }
}
