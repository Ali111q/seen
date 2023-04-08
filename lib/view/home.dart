import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/home_controller.dart';
import 'package:seen/model/ad.dart';
import 'package:seen/model/episode.dart';
import 'package:seen/model/tag.dart';
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
      body: CustomScrollView(
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
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
                  : Swiper(
                      itemBuilder: (context, index) {
                        return BannerItem(Offset: _Offset);
                      },
                      itemCount: 2,
                      autoplay: true,
                      duration: 500,
                    )),
          SliverList(
            delegate: SliverChildListDelegate([
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.09,
                    color: Colors.white,
                  ),
                ],
              ),
              SectionWidget()
            ]),
          ),
        ],
      ),
    );
  }
}

class BannerItem extends StatelessWidget {
  const BannerItem({
    super.key,
    required double Offset,
  }) : _Offset = Offset;

  final double _Offset;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        children: [
          Center(
            child: Image.network(
              'https://thumbs.dreamstime.com/b/aspect-ratio-beach-background-summer-concept-187699731.jpg',
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
                    'Us',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...['name', 'صخي'].map((e) => Text(
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
                    'الحلقة ١ الموسم ١',
                    style: TextStyle(color: Colors.white),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text('عرض الان'),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      )),
                ],
              ))
        ],
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'برامج seen',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          child: Row(children: [
            ...List.generate(
                20,
                (index) => Container(
                      margin: EdgeInsets.all(6),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                          color: index % 2 == 1
                              ? Colors.white
                              : Color.fromARGB(255, 85, 255, 0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(-1, 1),
                                color: Colors.black,
                                blurRadius: 3,
                                spreadRadius: 3)
                          ]),
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
