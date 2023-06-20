import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/controller/reels_controller.dart';
import 'package:seen/controller/user_controller.dart';
import 'package:seen/helper/video_player.dart';

import 'package:video_player/video_player.dart';

import 'model/reel.dart';


class ContentScreen extends StatefulWidget {
  final String src;
  final ReelVideo reel;
  bool isLiked;
  ContentScreen(
      {Key? key, required this.src, required this.reel, required this.isLiked})
      : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen>
    with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _showControlls = true;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    // initializePlayer().then((value) {
    //   setState(() {});
    // });
    Provider.of<ReelsController>(context, listen: false).view(
      widget.reel.id,
    );
  }

  Future<void> initializePlayer() async {
    print(widget.src);
    final cachedVideoPath = await cacheNetworkVideo(widget.src!);

    _videoPlayerController = VideoPlayerController.file(File(cachedVideoPath));
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
    );

    setState(() {});
  }

  Future<String> cacheNetworkVideo(String videoUrl) async {
    final videoCacheManager = CacheManager(Config('cacheCustomkey',
        stalePeriod: const Duration(hours: 4), maxNrOfCacheObjects: 100));
    final file = await videoCacheManager.getSingleFile(videoUrl);
    return file.path;
  }

  // @override
  // void dispose() {
  //   _videoPlayerController.dispose();
  //   _chewieController!.dispose();
  //   _animationController.dispose();
  //   super.dispose();
  // }

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
      _videoPlayerController.pause();
      Navigator.of(context).pushNamed('/login').then((value) {
        _videoPlayerController.play();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: () {
        if (_videoPlayerController.value.isInitialized &&
            _chewieController!.videoPlayerController.value.isInitialized) {
          _videoPlayerController.pause();
          setState(() {
            _showControlls = false;
          });
        }
      },
      onLongPressEnd: (e) {
        if (_videoPlayerController.value.isInitialized &&
            _chewieController!.videoPlayerController.value.isInitialized) {
          _videoPlayerController.play();
          setState(() {
            _showControlls = true;
          });
        }
      },
      onLongPressCancel: () {
        if (_videoPlayerController.value.isInitialized &&
            _chewieController!.videoPlayerController.value.isInitialized) {
          _videoPlayerController.play();
          setState(() {
            _showControlls = true;
          });
        }
      },
      onLongPressMoveUpdate: (e) {
        if (_videoPlayerController.value.isInitialized&&
            _chewieController!.videoPlayerController.value.isInitialized) {
          _videoPlayerController.play();
          setState(() {
            _showControlls = true;
          });
        }
      },
      onDoubleTap: _handleDoubleTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // if (_videoPlayerController.value.isInitialized &&
          //     _chewieController!.videoPlayerController.value.isInitialized)
           VidePlayerReel(videoUrl: widget.reel.url, src: widget.src, reel: widget.reel, isLiked: widget.isLiked,)
          // else
          //   Image.asset(
          //     'assets/images/loading.gif',
          //     height: MediaQuery.of(context).size.width * 0.8,
          //   )
          ,
         
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
    );
  }
}

class Comments extends StatefulWidget {
  const Comments({super.key, required this.id});
  final int id;

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ReelsController>(context, listen: false).getComments(widget.id);
  }

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Comment> comments = Provider.of<ReelsController>(context).comments;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Expanded(
              child: comments.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      shrinkWrap: true,
                      children: [
                        ...comments.map(
                          (e) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(e.image),
                            ),
                            title: Text(e.userName),
                            subtitle: Text(e.comment),
                          ),
                        )
                      ],
                    ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8),
              child: Row(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: _controller.text.isNotEmpty
                          ? MediaQuery.of(context).size.width * 0.84
                          : MediaQuery.of(context).size.width * 0.92,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'comment',
                        ),
                      )),
                  if (_controller.text.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        print(_controller.text);
                        Provider.of<ReelsController>(context, listen: false)
                            .postCommetn(
                                widget.id.toString(),
                                _controller.text,
                                Provider.of<UserController>(context,
                                        listen: false)
                                    .user!);
                        _controller.clear();
                      },
                      icon: Icon(Icons.send),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
