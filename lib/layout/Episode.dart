import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
  late ScrollController _scrollController;
  bool _showAlternativeWidget = false;
  double _Offset = 1;
  int index = 0;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(length: 2, vsync: this);
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
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [myColors.firstBackGround, myColors.sceondBackGround],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
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
                          'Home',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
                  :Container()
                  //  BannerItem(Offset: _Offset),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'مشاهدة الاعلان',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset('assets/images/youtube.svg')
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // HomeAdd(),
                ],
              ),
              TabBar(
                indicatorColor: Colors.white,
                onTap: (value) {
                  setState(() {
                    index = value;
                  });
                },
                controller: _tabController,
                tabs: [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                ],
              ),
              EpisodeWidget(),
              EpisodeWidget(),
              EpisodeWidget(),
              EpisodeWidget(),
              EpisodeWidget(),
            ])),
          ],
        ),
      ),
    );
  }
}

class EpisodeWidget extends StatelessWidget {
  const EpisodeWidget({
    super.key,
  });

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
                      'الحلقة 1',
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      width: 5,
                    ),
                    Text(
                      'Us',
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
                    Text(
                      'data',
                      style: TextStyle(color: Color(0xff707070)),
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(
                      'data',
                      style: TextStyle(color: Color(0xff707070)),
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(
                      'data',
                      style: TextStyle(color: Color(0xff707070)),
                    ),
                  ],
                ),
                Container(
                  height: 15,
                ),
                Text(
                  ' iuew fioew jdfoiew jdoi ejwiufh weuifh ieodioejw iufdh weiudh wn edhjwe d ujweduiwediuew',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.16,
            child: Image.network(
                'https://thumbs.dreamstime.com/b/aspect-ratio-beach-background-summer-concept-187699731.jpg'),
          ),
        ],
      ),
    );
  }
}
