import 'package:card_swiper/card_swiper.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:seen/controller/home_controller.dart';
import 'package:seen/helper/image_checker.dart';
import 'package:seen/jj.dart';
import 'package:seen/layout/Episode.dart';
import 'package:seen/model/ad.dart';
import 'package:seen/model/episode.dart';
import 'package:seen/model/tag.dart';
import 'package:seen/view/launch_screen.dart';
import '../helper/overlay_loading.dart';
import '../utils/colors.dart' as myColors;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ScrollController _scrollController;
  bool _showAlternativeWidget = false;
  double _Offset = 1;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
 
    Provider.of<HomeController>(context, listen: false)
        .getHome()
        .then((value) {
   
        });
        
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
    bool isError = Provider.of<HomeController>(context).homeError;
    print(isError);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: isError
          ? Center(
              child: IconButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                Provider.of<HomeController>(context, listen: false)
                    .getHome()
                    .then((value) {
                  setState(() {
                    isLoading = true;
                  });
                });
              },
              icon: Center(
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    child: Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                    )),
              ),
              iconSize: 60,
            ))
          : banner.isEmpty
              ? LaunchScreen()
              : CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                   
                    SliverAppBar(
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.55,
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
                            ads.isEmpty
                                ? Container()
                                : HomeAdd(
                                    ads: ads,
                                  ),
                          ],
                        ),
                        ...tags.mapIndexed((index ,e) {
                          return SectionWidget(
                            tag: e!,
                            index: index ,
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
        loop: ads!.length != 1,
        itemBuilder: (context, index) => NetworkImageChecker(
          imageUrl: ads![index]!.file,
          fit: BoxFit.fill,
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
            child: ShaderMask(
               shaderCallback: (rect) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.transparent],
    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
  },
  blendMode: BlendMode.dstIn,
              child: NetworkImageChecker(
                imageUrl: banner.thumbnail,
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          // Container(
          //   height: MediaQuery.of(context).size.height *
          //       0.55 *
          //       ((1000 - _Offset) / 1000),
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         Colors.transparent,
          //         Colors.transparent,
          //         Color(0xff0A1D2D).withOpacity(0.6),
          //         Color(0xff091726),
          //       ],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //     ),
          //   ),
          // ),
          Positioned(
              right: MediaQuery.of(context).size.width * 0.2,
              left: MediaQuery.of(context).size.width * 0.2,
              top: MediaQuery.of(context).size.height *
                  0.35 *
                  ((400 - _Offset) / 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    banner.local_name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  Row(
                   
                    children: [
                      ...banner.tags.getRange(0, 3).map((e) => Text(
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
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return jj(
                            link: [
                              banner.url_480,
                              banner.url_720,
                              banner.url_1080
                            ],
                          );
                        }));
                      },
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
  const SectionWidget({super.key, required this.tag, this.section, required this.index});
  final Tag tag;
  final String? section;
  final  int index;
  @override
  State<SectionWidget> createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeController>(context, listen: false)
        .getEpisode(widget.tag.id,widget. index, sections: widget.section);
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
          child: widget.tag.shows!.isEmpty
              ? LaunchScreen()
              : Row(children: [
                  ...widget.tag.shows!.map((e) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EpisodeScreen(e!.id),
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.all(6),
                          width: MediaQuery.of(context).size.width * 0.367,
                          height: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: Offset(-1, 1),
                                color: Colors.black,
                                blurRadius: 3,
                                spreadRadius: 3)
                          ]),
                          child: Stack(
                            children: [
                              SizedBox.expand(
                                  child: NetworkImageChecker(
                                imageUrl: e!.image!,
                                fit: BoxFit.fitHeight,
                              )),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Container(),
                                    Text(
                                      e!.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                                blurRadius: 6,
                                                color: Colors.white
                                                    .withOpacity(0.4))
                                          ]),
                                    )
                                  ],
                                ),
                              ),
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
