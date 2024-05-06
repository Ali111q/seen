// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seen/controller/reel_controller.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/data/model/reel.dart';
import 'package:seen/helper/image_checker.dart';
import 'package:seen/widgets/app_bar.dart';
import 'package:seen/widgets/loading.dart';

class ReelCategories extends StatelessWidget {
  ReelCategories({super.key});
  ReelController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, isSearch: false),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getReelsCategories,
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  ...controller.reels.mapWithIndex(
                    (index, value) => ReelCategoryWidget(
                      reel: value,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReelCategoryWidget extends StatelessWidget {
  ReelCategoryWidget({
    super.key,
    required this.reel,
  });
  ReelController controller = Get.find();
  final Reel reel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.getReels(reel.id);
        Get.toNamed('/reel_videos');
      },
      child: Container(
          margin: EdgeInsets.all(5),
          width: 35.w(context),
          height: reel.id.isOdd ? 60.w(context) : 80.w(context),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20),
          //     image: DecorationImage(
          //         image: NetworkImage(reel.image), fit: BoxFit.fitHeight)),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: NetworkImageChecker(
                  height: reel.id.isOdd ? 60.w(context) : 80.w(context),
                  imageUrl: reel.image,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Color(0x12000000),
                      Color(0x00000000),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(reel.local_title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
