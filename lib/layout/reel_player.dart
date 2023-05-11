import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/user_controller.dart';
import 'package:seen/helper/appbar.dart';
import 'package:seen/model/reel.dart';
import 'package:video_player/video_player.dart';

import '../controlller/reels_controller.dart';
import '../model/ad.dart';
import '../reel_screen.dart';

class ReelSlideNavigator extends StatefulWidget {
  ReelSlideNavigator(this.id, this.reelName);
  final int id;
  String reelName;

  @override
  _ReelSlideNavigatorState createState() => _ReelSlideNavigatorState();
}

class _ReelSlideNavigatorState extends State<ReelSlideNavigator> {
  final PageController _controller = PageController(viewportFraction: 0.8);

  int _currentPageIndex = 0;
  @override
  void initState() {
    Provider.of<ReelsController>(context, listen: false).getReelsById(widget.id,
        token: Provider.of<UserController>(context, listen: false).user?.token);
    super.initState();
    _controller.addListener(() {
      final int newIndex = _controller.page!.round();
      if (newIndex != _currentPageIndex) {
        setState(() {
          _currentPageIndex = newIndex;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ReelVideo> reels = Provider.of<ReelsController>(context).reelVideos;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              //We need swiper for every content
              Swiper(
                itemBuilder: (BuildContext context, int index) {
                  print('dssdfdsfsdfdsfsdf${reels.length}');
                  return ContentScreen(
                      src: reels[index].url,
                      reel: reels[index],
                      isLiked: reels[index].isLiked);
                },
                itemCount: reels.length,
                scrollDirection: Axis.vertical,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
