import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/show_controller.dart';
import 'package:seen/model/episode.dart';
import 'package:seen/model/season.dart';
import 'package:seen/model/show.dart';
import 'package:seen/view/launch_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controlller/home_controller.dart';
import '../utils/colors.dart' as myColors;
import '../view/home.dart';

class EpisodeScreen extends StatefulWidget {
  const EpisodeScreen(this.id, {super.key});
  final int id;
  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen>
    with SingleTickerProviderStateMixin {
  int times = 0;
  late ScrollController _scrollController;
  bool _showAlternativeWidget = false;
  bool _animation = false;

  double _Offset = 1;
  int index = 0;
  launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      print(url);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    Provider.of<ShowController>(context, listen: false)
        .getShow(widget.id)
        .then((value) {
      List<Season>? show =
          Provider.of<ShowController>(context, listen: false).seasons;
      Provider.of<ShowController>(context, listen: false).getSeason(
        show[index].id,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
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

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    Episode? banner = Provider.of<ShowController>(context).banner;
    List<Season> season = Provider.of<ShowController>(context).seasons;
    Show? show = Provider.of<ShowController>(context).show;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [myColors.firstBackGround, myColors.sceondBackGround],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: banner == null
            ? LaunchScreen()
            : CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.53,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: _showAlternativeWidget
                        ? Container(
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                show!.name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          )
                        : BannerItem(
                            Offset: _Offset,
                            banner: banner!,
                          ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          // print(show!.trailer);
                          launchURL(show!.trailer!);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'مشاهدة الاعلان',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset('assets/images/youtube.svg')
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // HomeAdd(),
                      ],
                    ),
                    DefaultTabController(
                      length: season.length,
                      child: TabBar(
                        physics: AlwaysScrollableScrollPhysics(),
                        isScrollable: true,
                        indicatorColor: Colors.white,
                        onTap: (value) async {
                          setState(() {
                            _animation = true;
                          });
                          if (season[index].episods.isEmpty) {
                            Provider.of<ShowController>(context, listen: false)
                                .getSeason(season[index].id);
                          }
                          await Future.delayed(
                              const Duration(milliseconds: 100));
                          setState(() {
                            index = value;
                            _animation = false;
                          });
                        },
                        tabs: [
                          ...season.map(
                            (e) => Tab(
                              text: e.local_name,
                            ),
                          )
                        ],
                      ),
                    ),
                    AnimatedOpacity(
                        opacity: _animation ? 0 : 1,
                        duration: Duration(milliseconds: 100),
                        child: Provider.of<ShowController>(context)
                                .seasons[index]
                                .episods
                                .isEmpty
                            ? LaunchScreen()
                            : EpisodeContainer(
                                index: index,
                              ))
                  ])),
                ],
              ),
      ),
    );
  }
}

class EpisodeWidget extends StatelessWidget {
  const EpisodeWidget({super.key, required this.episode, required this.thumb});
  final Episode episode;
  final String thumb;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'الحلقة ${episode.episode_num}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      width: 5,
                    ),
                    Text(
                      episode.local_name!,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Container(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ...episode.tags.map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          e,
                          style: TextStyle(color: Color(0xff707070)),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 15,
                ),
                Text(
                  episode.id.toString(),
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            width: MediaQuery.of(context).size.width * 0.16,
            child: Image.network(thumb),
          ),
        ],
      ),
    );
  }
}

class EpisodeContainer extends StatefulWidget {
  const EpisodeContainer({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<EpisodeContainer> createState() => _EpisodeContainerState();
}

class _EpisodeContainerState extends State<EpisodeContainer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Season> season = Provider.of<ShowController>(context).seasons;
    List<Episode>? show =
        Provider.of<ShowController>(context).seasons[widget.index].episods;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: show == null
          ? LaunchScreen()
          : Column(
              children: [
                ...show.map((e) {
                  return EpisodeWidget(
                    episode: e,
                    thumb: season[widget.index].image,
                  );
                })
              ],
            ),
    );
  }
}
