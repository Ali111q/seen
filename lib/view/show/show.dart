// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seen/config/style/colors.dart';
import 'package:seen/config/style/styles.dart';
import 'package:seen/controller/show_controller.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/data/model/ad.dart';
import 'package:seen/data/model/episode.dart';
import 'package:seen/view/video_player/video_player.dart';
import 'package:seen/widgets/add_bar.dart';
import 'package:seen/widgets/logo.dart';

import '../../widgets/loading.dart';

class ShowView extends StatelessWidget {
  ShowView({super.key});
  ShowController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    void goToVideo(String url) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(videoUrl: url)));
    }

    return Scaffold(
      body: Obx(
        () => controller.show.value == null
            ? LoadingWidget()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        goToVideo(controller.show.value!.firstEpisode!.url!);
                      },
                      child: ShowBanner(
                        episode: controller.show.value!.firstEpisode!,
                      ),
                    ),
                    if (false) AddBar(ads: []),
                    Container(
                      height: 16,
                    ),
                    Text(controller.show.value!.name,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    Container(height: 11),
                    Text(controller.show.value!.description,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        )),
                    Container(
                      height: 16,
                    ),
                    Row(
                      children: [
                        ...controller.show.value!.seasons!.mapWithIndex(
                          (i, e) => Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                              gradient: controller.seasonIndex.value != i
                                  ? null
                                  : MyColors.buttonGradient,
                              color: controller.seasonIndex == i
                                  ? null
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text(
                              e.local_name,
                              style: TextStyle(
                                  color: controller.seasonIndex == i
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 16,
                    ),
                    if (controller.episodes.isEmpty) LoadingWidget(),
                    if (controller.episodes.isNotEmpty)
                      ...controller.episodes.value.mapWithIndex(
                        (index, value) => Container(
                          width: 100.w(context),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  value.thumbnail!,
                                  width: 25.w(context),
                                  height: 25.w(context),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(value.localName!,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white)),
                                    Container(
                                      height: 11,
                                    ),
                                    Text(
                                        "Episode " +
                                            value.episodeNum.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white)),
                                    Container(
                                      height: 16,
                                    ),
                                    GestureDetector(
                                      child: GestureDetector(
                                        onTap: () {
                                          goToVideo(value.url!);
                                        },
                                        child: Container(
                                          height: 4.h(context),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white),
                                          child: Row(
                                            children: [
                                              Icon(Icons
                                                  .play_circle_fill_rounded),
                                              Text("Watch Now",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
      ),
    );
  }
}

class ShowBanner extends StatelessWidget {
  const ShowBanner({
    super.key,
    required this.episode,
  });
  final Episode episode;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(episode.seasonImage!), fit: BoxFit.fitWidth)),
      child: Stack(
        children: [
          Container(
            width: 100.w(context),
            height: 40.h(context),
            decoration: BoxDecoration(
              gradient: MyColors.swiperGradient,
            ),
            child: Column(
              children: [
                Container(
                  height: 20.h(context),
                ),
                const Icon(
                  Icons.play_circle,
                  color: Colors.white,
                  size: 60,
                ),
                Container(
                  height: 4.h(context),
                ),
                Text(
                  episode.localName ?? '',
                  style: MyStyles.pageTitleStyle,
                ),
                Container(
                  height: 2.h(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...episode.tags.mapWithIndex(
                      (i, e) => Text(
                        i == episode.tags.length - 1 ? e : e + ' . ',
                        style: const TextStyle(
                            color: MyColors.swatch,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Align(
              alignment: Get.locale!.languageCode == 'en'
                  ? Alignment.topLeft
                  : Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
