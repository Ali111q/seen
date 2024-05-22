import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:seen/config/style/colors.dart';
import 'package:seen/config/style/styles.dart';
import 'package:seen/controller/home_controller.dart';
import 'package:seen/controller/show_controller.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/data/model/category.dart';
import 'package:seen/data/model/episode.dart';
import 'package:seen/data/model/show.dart';
import 'package:seen/helper/custom_list_view.dart';
import 'package:seen/helper/image_checker.dart';
import 'package:seen/widgets/dots.dart';
import 'package:seen/widgets/logo.dart';

import '../../widgets/add_bar.dart';
import '../../widgets/app_bar.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: MyAppBar(context, isSearch: true),
        body: controller.home.value == null
            ? Container()
            : RefreshIndicator(
                onRefresh: controller.getHome,
                child: ListView(
                  children: [
                    Container(
                      height: 10,
                    ),
                    Container(
                      height: 40.h(context),
                      child: Stack(
                        children: [
                          Swiper(
                            autoplay: true,
                            onIndexChanged: controller.setBannerIndex,
                            itemCount: controller.home.value!.banner.length,
                            itemBuilder: (context, index) => BannerWidget(
                              show: controller.home.value!.banner[index],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Dots(
                                    index: controller.bannerIndex.value,
                                    itemsCount:
                                        controller.home.value!.banner.length)),
                          )
                        ],
                      ),
                    ),
                    if (controller.home.value!.ads.isNotEmpty)
                      AddBar(
                        ads: controller.home.value!.ads,
                      ),
                    ...controller.home.value!.categories
                        .map((e) => CategoryListView(category: e))
                  ],
                ),
              ),
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  BannerWidget({
    super.key,
    required this.show,
    this.isHome = true,
  });
  final bool isHome;
  final Episode show;
  ShowController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.getShow(show.showId!);
        Get.toNamed('/show');
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(show.seasonImage ?? ''),
              fit: BoxFit.fitWidth),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 40.h(context),
              width: 100.w(context),
              decoration: BoxDecoration(gradient: MyColors.swiperGradient),
            ),
            if (!isHome)
              Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_filled_outlined,
                    color: Colors.white,
                    size: 80,
                  )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isHome)
                    Container(
                      height: 40,
                    ),
                  Text(
                    show.localName ?? '',
                    style: MyStyles.pageTitleStyle,
                  ),
                  Text(
                    show.localDescription ?? '',
                    style: MyStyles.sliderSubtitle,
                  ),
                  Container(
                    height: 24.h(context),
                  ),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...show.tags.mapWithIndex(
                        (i, e) => Text(
                          i == show.tags.length - 1 ? e : e + ' / ',
                          style: TextStyle(
                              color: MyColors.swatch,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryListView extends StatelessWidget {
  CategoryListView({
    required this.category,
    super.key,
  });
  Category category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            category.local_name,
            style: MyStyles.buttonTitleWhiteStyle,
          ),
        ),
        Container(
          height: ResponsiveBreakpoints.of(context).isMobile
              ? 18.h(context)
              : 35.w(context),
          child: CustomListView(
            onEnd: () async {},
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              ...category.shows!.map((e) => HomeCard(
                    show: e!,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

class HomeCard extends StatelessWidget {
  HomeCard({super.key, required this.show});
  Show show;
  final ShowController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.getShow(show.id);
        Get.toNamed('/show');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w(context), vertical: 6),
            width: 30.w(context),
            height: 30.w(context),
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: NetworkImage(
            //           show.image!,
            //         ),
            //         fit: BoxFit.cover),
            //     borderRadius: BorderRadius.circular(MyStyles.cardBorderRadius)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(MyStyles.cardBorderRadius),
              child: NetworkImageChecker(
                imageUrl: show.image!,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w(context)),
            child: Text(
              show.name,
              style: MyStyles.miniText,
            ),
          )
        ],
      ),
    );
  }
}
