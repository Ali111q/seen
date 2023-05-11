import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/ads_controller.dart';
import 'package:seen/reel_test.dart';
import 'package:seen/view/launch_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../model/ad.dart';

// class AdsPage extends StatefulWidget {
//   const AdsPage({super.key});

//   @override
//   State<AdsPage> createState() => _AdsPageState();
// }

// class _AdsPageState extends State<AdsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           AdWidget(),
//           AdWidget(),
//         ],
//       ),
//     );
//   }
// }

class AdWidget extends StatefulWidget {
  Ad ad;
  AdWidget({
    required this.ad,
    super.key,
  });
  @override
  State<AdWidget> createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  ValueNotifier<double> progressNotifier = ValueNotifier<double>(0.0);

  bool isPlaying = true;
  bool isInitialized = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.ad.isPlaying.listen((event) {
      setState(() {
        isPlaying = event;
      });
        print(event);

    });
    widget.ad.position.listen((event) {

     setState(() {
       progressNotifier.value = event;
     });
    });
    widget.ad.isInitialized.listen((event) { 
      setState(() {
        isInitialized = event;
      });
        print(event);

    });
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.ad.dispos();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.ad.local_title,
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.ad.local_description,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (isInitialized) {
            isPlaying ? widget.ad.pause() : widget.ad.play();
            }
          },
          child: Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.6,
            child: Stack(
              children: [
              if (isInitialized) VideoPlayer(widget.ad.controller) else Image.network(widget.ad.thumbnail!),
                if(isInitialized) Positioned(child:VideoProgressIndicator(widget.ad.controller, allowScrubbing: false,),),
                isPlaying
                    ? Container()
                    : Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: 40,
                        ),
                      ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
             if(widget.ad.website != null || widget.ad.instagram != null) GestureDetector( onTap: (){
              launchUrl(Uri.parse(widget.ad.website??widget.ad.instagram??''));
             }, child: SvgPicture.asset('assets/images/website.svg')),
              Container(
                width: 20,
              ),
            if(widget.ad.lat != null&& widget.ad.lng != null)  GestureDetector(
              onTap: (){
                launchUrl(Uri.parse('https://www.google.com/maps/search/?api=1&query=${widget.ad.lat},${widget.ad.lng}'));
              },
              child: SvgPicture.asset('assets/images/marker.svg')),
              Spacer(),
              Text(
                widget.ad.local_sub_title,
                style: TextStyle(color: Colors.white, fontSize: 26),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class AdsPage extends StatefulWidget {
  const AdsPage({super.key});

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AdsController>(context, listen: false).getAds();
  }

  @override
  Widget build(BuildContext context) {
    List<Ad> ads = Provider.of<AdsController>(context).ads;
    return ads.isEmpty
        ? LaunchScreen()
        : adsPage(
            items: [
              ...ads.map((e) => AdWidget(
                    ad: e,
                  ))
            ],
            models: ads,
          );
  }
}

class adsPage extends ReelsScroll {
  adsPage({required super.items, required this.models});
  List<Ad> models;
  @override
  void initState() {
    // TODO: implement initState
    if (models[super.index].file_type == 'video') {
      models[super.index].intilize();
    }
  }

  @override
  Future<void> dispose(int index, context) async {
    if (models[super.index].file_type == 'video') {
      await Provider.of<AdsController>(context).dispos(index);
    }
  }

  @override
  Future<void> initialize(int e, context) async {
    // TODO: implement initialize
    await Provider.of<AdsController>(context).initialize(e);
  }
}
