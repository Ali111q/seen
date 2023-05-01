import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/model/reel.dart';
import 'package:video_player/video_player.dart';

import '../controlller/reels_controller.dart';
import '../model/ad.dart';

class ReelsPlayerScreen extends StatefulWidget {
  const ReelsPlayerScreen({super.key, required this.reel});
  final ReelVideo reel;
  @override
  State<ReelsPlayerScreen> createState() => _ReelsPlayerScreenState();
}

class _ReelsPlayerScreenState extends State<ReelsPlayerScreen> {
  bool isPause = false;

  late VideoPlayerController _controller ;
  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(
      widget.reel.url,
      videoPlayerOptions: VideoPlayerOptions(),
      );
    super.initState();
    _controller.initialize().then((value) {
      setState(() {});
    });
    _controller.play();
    _controller.setLooping(true);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {  
    List<Ad> ad =  Provider.of<ReelsController>(context).ads;
    return 
     
       Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (isPause) {
                _controller.play();
                setState(() {
                  isPause = false;
                });
              } else {
                _controller.pause();
                setState(() {
                  isPause = true;
                });
              }
            },
            child: Center(
              child: Container(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller))
                      : Container()),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.03,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                      ),
                      SvgPicture.asset('assets/images/seen_logo.svg'),
                    ],
                  ),
                ),
              )),
          isPause
              ? Center(
                  child: GestureDetector(
                  onTap: () {
                    if (isPause) {
                      _controller.play();
                      setState(() {
                        isPause = false;
                      });
                    } else {
                      _controller.pause();
                      setState(() {
                        isPause = true;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.8),
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.play_arrow,
                      size: 50,
                    ),
                  ),
                ))
              : Container(),
          Positioned(
              bottom: 10,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            ReelAction(
                              image: 'assets/images/like.svg',
                              count: '40 k',
                            ),
                            ReelAction(
                              image: 'assets/images/dislike.svg',
                              count: '20 k',
                            ),
                            ReelAction(
                              image: 'assets/images/seen_colorsless.svg',
                              count: '20 k',
                            ),
                            ReelAction(
                              image: 'assets/images/comment.svg',
                              count: '20 k',
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           widget.reel.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'font',
                                fontSize: 21),
                          ),
                          Container(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.width * 0.07,
                            color: Colors.white,
                            child:ad.isEmpty? Container(child: Text('oliksj'),): Image.network(ad[0].file, fit: BoxFit.cover,),
                            
                          ),
                          Container(
                            height: 30,
                          ),
                        
                        ],
                      ),
                    ),
                  ],
                ),
              ))
        ],
      )
    ;
  }
}

class ReelAction extends StatelessWidget {
  const ReelAction({
    super.key,
    required this.image,
    required this.count,
  });
  final String image;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SvgPicture.asset(image),
          Container(
            height: 5,
          ),
          Text(
            count,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}


class ReelSlideNavigator extends StatefulWidget {


  ReelSlideNavigator(this.id);
  final int id ;
  
  @override
  _ReelSlideNavigatorState createState() => _ReelSlideNavigatorState();
}

class _ReelSlideNavigatorState extends State<ReelSlideNavigator> {
  final PageController _controller = PageController(viewportFraction: 0.8);

  int _currentPageIndex = 0;

  @override
  void initState() {
     Provider.of<ReelsController>(context, listen: false).getReelsById(widget.id);
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
    List<ReelVideo> reels =Provider.of<ReelsController>(context).reelVideos;
    return Scaffold(
  backgroundColor: Colors.black,
       resizeToAvoidBottomInset: false,
      body: reels.length==0?Center(child: CircularProgressIndicator()): SizedBox.expand(
        child: PageView.builder(
          pageSnapping: true,
                    padEnds: false,
          itemCount: reels.length,
          itemBuilder:(context, index) =>SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(child: ReelsPlayerScreen(reel: reels[index]))) ,
          scrollDirection: Axis.vertical,
          controller: _controller,
        ),
      ),
    );
  }
}