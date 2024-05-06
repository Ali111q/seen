import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/view/video_player/video_player.dart';
import 'package:seen/widgets/loading.dart';

import 'package:seen/widgets/logo.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:video_player/video_player.dart';

import '../../controller/stream_controller.dart';

class StreamView extends StatelessWidget {
  StreamController controller = Get.find();
  StreamView({super.key});
  VideoPlayerController? videoPlayerController;
  @override
  Widget build(BuildContext context) {
    var url = 'https://stream.app-seen.com/live/live1.m3u8';
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Live ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  )),
              Logo(
                width: 60,
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                YoYoPlayer(
                    videoLoadingStyle:
                        VideoLoadingStyle(loading: LoadingWidget()),
                    onVideoInitCompleted: (controller) {
                      this.videoPlayerController = controller;
                      this.controller.setVideoPlayerController(controller);
                    },
                    showControls: false,
                    url: url),
                IconButton(
                  onPressed: () {
                    if (controller != null) {
                      // Get.toNamed(
                      //   '/video-player',
                      // );
                      Navigator.of(context).push(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => VideoPlayerScreen(
                          controller: controller.videoPlayerController.value,
                        ),
                      ));
                    }
                  },
                  icon: Container(
                    width: 100.w(context),
                    height: 70.w(context),
                  ),
                )
              ],
            )
          ],
        ));
  }
}

class CommentBar extends StatelessWidget {
  const CommentBar({
    super.key,
    this.onLike,
    this.onComment,
  });
  final void Function()? onLike;
  final void Function()? onComment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: onLike, icon: SvgPicture.asset('assets/svg/like.svg')),
          Container(
              width: 70.w(context),
              child: TextField(
                onSubmitted: (value) {
                  onComment ?? ();
                },
                scrollPadding: const EdgeInsets.only(bottom: 30),
                decoration: InputDecoration(
                  fillColor: const Color(0xff717171).withOpacity(0.5),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              )),
          IconButton(
              onPressed: onComment,
              icon: SvgPicture.asset('assets/svg/comment.svg'))
        ],
      ),
    );
  }
}

class NeonContainer extends StatelessWidget {
  const NeonContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80.w(context),
        height: 35.w(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
          border: Border.all(color: Colors.white, width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E99FE).withAlpha(225),
              blurRadius: 45.0,
              spreadRadius: 5.0,
              offset: const Offset(
                -15.0,
                0.0,
              ),
            ),
            BoxShadow(
              color: const Color(0xFFF26722).withAlpha(225),
              blurRadius: 45.0,
              spreadRadius: 5.0,
              offset: const Offset(
                15.0,
                0.0,
              ),
            ),
            const BoxShadow()
          ],
        ),
        child: const Center(
          child: Text(
            '00:00:00',
            style: TextStyle(color: Colors.white, fontSize: 45),
          ),
        ),
      ),
    );
  }
}
