import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:seen/config/style/styles.dart';
import 'package:seen/controller/reel_controller.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/data/model/reel.dart';
import 'package:seen/view/reels/widgets/comment_bottom_sheet.dart';
import 'package:seen/widgets/add_bar.dart';
import 'package:seen/widgets/loading.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class M3U8Player extends StatefulWidget {
  final String m3u8Url;
  final ReelVideo reel;

  const M3U8Player({Key? key, required this.m3u8Url, required this.reel})
      : super(key: key);

  @override
  _M3U8PlayerState createState() => _M3U8PlayerState();
}

class _M3U8PlayerState extends State<M3U8Player> {
  bool _isVisible = true;
  ReelController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('M3U8Player'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction == 0) {
          setState(() {
            _isVisible = false;
          });
        } else {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Center(
        child: _isVisible
            ? Stack(
                children: [
                  YoYoPlayer(
                    aspectRatio: 9 / 16,
                    url: widget.m3u8Url,
                    onVideoInitCompleted: (cont) {
                      cont.setLooping(true);
                      controller.initController(
                          cont, widget.reel.id.toString());
                    },
                    allowCacheFile: true,
                    showControls: false,
                    onShowMenu: (showMenu, m3u8Show) {},
                    videoPlayerOptions: VideoPlayerOptions(),
                    videoLoadingStyle:
                        VideoLoadingStyle(loading: LoadingWidget()),
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      // print('object');
                    },
                    onTap: () {
                      print('object');
                      controller.muteUnMute();
                    },
                    onLongPress: () {
                      print('object1');
                      controller.pause();
                    },
                    onLongPressEnd: (details) {
                      controller.play();
                    },
                    child: Container(
                      height: 82.h(context),
                      width: 100.w(context),
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.like(widget.reel.id.toString());
                              },
                              icon: SvgPicture.asset(
                                widget.reel.isLiked
                                    ? 'assets/svg/like.svg'
                                    : 'assets/svg/like_deactive.svg',
                                width: 25,
                              )),
                          Container(
                            height: 15,
                          ),
                          IconButton(
                              onPressed: () {
                                controller
                                    .getComments(widget.reel.id.toString());
                                showBottomSheet(
                                  context: context,
                                  builder: (context) => CommentBottomSheet(
                                    reelVideo: widget.reel,
                                  ),
                                );
                              },
                              icon: SvgPicture.asset(
                                'assets/svg/comment.svg',
                                width: 25,
                              )),
                          Container(height: 30),

                          Container(height: 10),
                          Text(
                            widget.reel.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          // if (controller.videoPlayerController != null)
                          //   VideoProgressIndicator(
                          //       controller.videoPlayerController!,
                          //       colors: VideoProgressColors(
                          //           playedColor: Color(0xffFFB321)),
                          //       allowScrubbing: true)
                          // AddBar()
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ))
                ],
              )
            : Container(),
      ),
    );
  }
}
