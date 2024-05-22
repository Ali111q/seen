import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:seen/controller/auth_controller.dart';
import 'package:seen/data/api/comment_api.dart';
import 'package:seen/data/api/reel_api.dart';
import 'package:seen/data/api/reel_video_api.dart';
import 'package:seen/data/model/reel.dart';
import 'package:video_player/video_player.dart';

class ReelController extends GetxController {
  AuthController authController = Get.find();
  ReelApi reelApi = ReelApi();
  CommentApi commentApi = CommentApi();
  ReelVideoApi reelVideoApi = ReelVideoApi();
  RxList<Reel> reels = RxList([]);
  RxList<ReelVideo> reelVideos = RxList([]);
  RxList<Comment> comments = RxList([]);
  TextEditingController commentController = TextEditingController();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getReelsCategories();
  }

  Future<void> getReelsCategories() async {
    reels.value = await reelApi.getReelCats() ?? [];
  }

  VideoPlayerController? videoPlayerController;
  bool muted = false;
  void initController(VideoPlayerController inited, String id) {
    view(id);
    videoPlayerController = inited;
    // update();
  }

  void pause() {
    videoPlayerController?.pause();
  }

  void play() {
    videoPlayerController?.play();
  }

  void muteUnMute() {
    print(muted);
    videoPlayerController?.setVolume(muted ? 10 : 0);
    muted = !muted;
  }

  void getReels(int id) async {
    this.reelVideos.value = await reelVideoApi.getReels(id) ?? <ReelVideo>[];
  }

  void getComments(String id) async {
    comments.value = [];
    comments.value = await commentApi.getComments(id) ?? [];
  }

  void like(String id) async {
    ReelVideo reel =
        reelVideos.firstWhere((element) => element.id == int.parse(id));
    int index = reelVideos.indexOf(reel);
    reelVideos[index] = reel.copyWith(isLiked: !reel.isLiked);
    await reelApi.getWithoutRes('/like?reel_id=$id');
  }

  void view(String id) async {
    await reelApi.getWithoutRes('/view?reel_id=$id');
  }

  void comment(
    String id,
  ) async {
    if (commentController.text.isNotEmpty) {
      comments.add(Comment(
          comment: commentController.text,
          id: 1,
          image: authController.user.value!.image,
          userName: authController.user.value!.name));
      await reelApi.postWithoutRes(
          '/comment', {'comment': commentController.text, 'reel_id': id});
    }
  }
}
