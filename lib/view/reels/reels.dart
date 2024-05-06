import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/widgets/loading.dart';
import 'package:seen/widgets/video_player.dart';

import '../../controller/reel_controller.dart';

class ReelsView extends StatelessWidget {
  ReelsView({super.key});
  ReelController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => PageView(
          scrollDirection: Axis.vertical,
          children: [
            if (controller.reelVideos.isEmpty) const LoadingWidget(),
            if (controller.reelVideos.isNotEmpty)
              ...controller.reelVideos.mapWithIndex(
                (index, value) => M3U8Player(
                  reel: value,
                  m3u8Url: value.url,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
