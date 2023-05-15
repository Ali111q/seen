import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/controller/user_controller.dart';
import 'package:seen/helper/appbar.dart';
import 'package:seen/model/reel.dart';
import 'package:video_player/video_player.dart';

import '../controller/reels_controller.dart';
import '../model/ad.dart';
import '../reel_screen.dart';

class ReelSlideNavigator extends StatefulWidget {
  ReelSlideNavigator(this.id, this.reelName);
  final int id;
  String reelName;

  @override
  _ReelSlideNavigatorState createState() => _ReelSlideNavigatorState();
}

class _ReelSlideNavigatorState extends State<ReelSlideNavigator>
    with AutomaticKeepAliveClientMixin<ReelSlideNavigator> {
  final SwiperController _controller = SwiperController();

  int _currentPageIndex = 0;
  bool isLoading = true;
  @override
  bool get wantKeepAlive => false;
  @override
  void initState() {
    Provider.of<ReelsController>(context, listen: false)
        .getReelsById(widget.id,
            token:
                Provider.of<UserController>(context, listen: false).user?.token)
        .then((value) {
      Future.delayed(Duration(milliseconds: 100));
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ReelVideo> reels = Provider.of<ReelsController>(context).reelVideos;
    int count = Provider.of<ReelsController>(context).count;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Container(
                    child: Swiper(
                      controller: _controller,
                      itemBuilder: (BuildContext context, int index) {
                        return PageStorage(
                          bucket: PageStorageBucket(),
                          child: ContentScreen(
                            src: reels[index].url,
                            reel: reels[index],
                            isLiked: reels[index].isLiked,
                          ),
                        );
                        // return MyWidget();
                      },
                      itemCount: count,
                      scrollDirection: Axis.vertical,
                      onIndexChanged: (int index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                      autoplay: false,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios_new_sharp),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('object');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('des');
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
