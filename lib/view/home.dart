import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/home_controller.dart';
import 'package:seen/model/ad.dart';
import 'package:seen/model/episode.dart';
import 'package:seen/model/tag.dart';
import 'package:seen/view/launch_screen.dart';
import '../utils/colors.dart' as myColors;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ScrollController _scrollController;
  bool _showAlternativeWidget = false;
  double _Offset = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    Provider.of<HomeController>(context, listen: false).getHome();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);

    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _Offset = _scrollController.offset;
    });

    if (_scrollController.offset > 400) {
      // adjust threshold as needed
      setState(() {
        _showAlternativeWidget = true;
      });
    } else {
      setState(() {
        _showAlternativeWidget = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Ad?> ads = Provider.of<HomeController>(context).ads;
    List<Episode?> banner = Provider.of<HomeController>(context).banner;
    List<Tag?> tags = Provider.of<HomeController>(context).tags;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: banner.isEmpty
          ? LaunchScreen()
          : CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.6,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: _showAlternativeWidget
                        ? Container(
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                'Home',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          )
                        : Swiper(
                            itemBuilder: (context, index) {
                              return BannerItem(
                                Offset: _Offset,
                                banner: banner[index]!,
                              );
                            },
                            itemCount: banner.length,
                            autoplay: banner.length == 1 ? false : true,
                            duration: 500,
                            loop: banner.length == 1 ? false : true,
                          )),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HomeAdd(
                          ads: ads,
                        ),
                      ],
                    ),
                    ...tags.map((e) {
                      return SectionWidget(
                        tag: e!,
                      );
                    })
                  ]),
                ),
              ],
            ),
    );
  }
}

class HomeAdd extends StatelessWidget {
  HomeAdd({
    this.ads,
    super.key,
  });
  List<Ad?>? ads;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.09,
      color: Colors.white,
      child: Swiper(
        itemCount: ads!.length,
        itemBuilder: (context, index) => Image.network(
          ads![index]!.file,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class BannerItem extends StatelessWidget {
  const BannerItem({
    super.key,
    required double Offset,
    required this.banner,
  }) : _Offset = Offset;

  final double _Offset;
  final Episode banner;
  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        children: [
          Center(
            child: Image.network(
              banner.thumbnail,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height *
                0.6 *
                ((1000 - _Offset) / 1000),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Color(0xff0A1D2D).withOpacity(0.6),
                  Color(0xff091726),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
              right: MediaQuery.of(context).size.width * 0.2,
              left: MediaQuery.of(context).size.width * 0.2,
              top: MediaQuery.of(context).size.height *
                  0.4 *
                  ((400 - _Offset) / 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    banner.local_name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...banner.tags.map((e) => Text(
                            ' $e .',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          )),
                      Text(' 2022',
                          style: TextStyle(
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  Text(
                    'الحلقة ${banner.episode_num} الموسم ${banner.season_num}',
                    style: TextStyle(color: Colors.white),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text('عرض الان',
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      )),
                ],
              ))
        ],
      ),
    );
  }
}

class SectionWidget extends StatefulWidget {
  const SectionWidget({
    super.key,
    required this.tag,
  });
  final Tag tag;

  @override
  State<SectionWidget> createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeController>(context, listen: false)
        .getEpisode(widget.tag.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.tag.local_name,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          child: Row(children: [
            ...widget.tag.shows!.map((e) => Container(
                  margin: EdgeInsets.all(6),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(e!.image), fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(-1, 1),
                            color: Colors.black,
                            blurRadius: 3,
                            spreadRadius: 3)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Container(),
                        Text(
                          e.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                    blurRadius: 6,
                                    color: Colors.white.withOpacity(0.4))
                              ]),
                        )
                      ],
                    ),
                  ),
                ))
          ]),
        ),
        Container(
          height: 30,
        ),
      ],
    );
  }
}
