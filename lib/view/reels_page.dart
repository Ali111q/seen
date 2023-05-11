import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/reels_controller.dart';
import 'package:seen/layout/reel_player.dart';
import 'package:seen/model/reel.dart';

class ReelsPage extends StatefulWidget {
  const ReelsPage({
    super.key,
  });

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ReelsController>(context, listen: false).getReelsCat();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...Provider.of<ReelsController>(context)
              .reelsCat
              .map((e) => ReelPgaeWidget(e))
        ],
      ),
    );
  }
}

class ReelPgaeWidget extends StatelessWidget {
  const ReelPgaeWidget(
    this.reel, {
    super.key,
  });
  final Reel reel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ReelSlideNavigator(reel.id, reel.local_name)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 3,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.46,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(reel.image),
                              fit: BoxFit.cover)),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 20,
                            child: ClipPath(
                              clipper: TrapeziumClipper(),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.width * 0.46,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          ClipPath(
                            clipper: TrapeziumClipper(),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.width * 0.46,
                              decoration: BoxDecoration(
                                color: Color(0xff082533),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      Text(
                                        reel.local_name,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Opacity(
                              opacity: 0.5,
                              child: SvgPicture.asset('assets/images/wtf.svg')),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(reel.local_title,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                              offset: Offset(3, 3),
                              color: Colors.black,
                              blurRadius: 1)
                        ])),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width * 0.3, 0);
    path.lineTo(size.width * 0.7, 0);
    path.lineTo(size.width * 0.3, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class ReelsPage extends StatelessWidget {
//   const ReelsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Coming Soon', style: TextStyle(color: Colors.white, fontSize: 40),),);
//   }
// }

