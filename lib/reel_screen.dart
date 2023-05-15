import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/controller/reels_controller.dart';
import 'package:seen/controller/user_controller.dart';
import 'package:seen/model/user.dart';

import 'package:video_player/video_player.dart';

import 'like_icon.dart';
import 'model/reel.dart';

class ContentScreen extends StatefulWidget {
  final String? src;
  final ReelVideo reel;
  bool isLiked;
  ContentScreen({Key? key, this.src, required this.reel, required this.isLiked})
      : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer().then((value) {
      setState(() {});
    });
    Provider.of<ReelsController>(context, listen: false).view(
      widget.reel.id,
    );
    print('''
asd

asdsa
darkas
d
asd

sad
sad

sad
s
d
sda
${widget.reel.isLiked}
''');
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.src!,
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false));
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (_chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized) {
          _videoPlayerController.pause();
        }
      },
      onLongPressEnd: (e) {
        if (_chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized) {
          _videoPlayerController.play();
        }
      },
      onLongPressCancel: () {
        if (_chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized) {
          _videoPlayerController.play();
        }
      },
      onLongPressMoveUpdate: (e) {
        if (_chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized) {
          _videoPlayerController.play();
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized)
            Chewie(
              controller: _chewieController!,
            )
          else
            Image.asset(
              'assets/images/loading.gif',
              height: MediaQuery.of(context).size.width * 0.8,
            ),
          Container(
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
                            print('${widget.reel.likes_count} l l l l l l ');

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
                            _videoPlayerController.pause();
                            Navigator.of(context)
                                .pushNamed('/login')
                                .then((value) {
                              _videoPlayerController.play();
                            });
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: widget.isLiked ? Colors.red : Colors.white,
                        )),
                    Text(
                      widget.reel.likes_count.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        if (Provider.of<UserController>(context, listen: false)
                                .user !=
                            null) {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Comments(id: widget.reel.id);
                              });
                        } else {
                          _videoPlayerController.pause();
                          Navigator.of(context)
                              .pushNamed('/login')
                              .then((value) {
                            _videoPlayerController.play();
                          });
                        }
                      },
                      icon: SvgPicture.asset('assets/images/comment.svg'),
                    ),
                    Text(
                      widget.reel.comments_count.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon:
                          SvgPicture.asset('assets/images/seen_colorsless.svg'),
                    ),
                    Text(
                      widget.reel.views_count.toString(),
                      style: TextStyle(color: Colors.white),
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
                if (widget.reel.ad != null)
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
                  ),
                Container(
                  height: 50,
                )
              ],
            ),
          )
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
