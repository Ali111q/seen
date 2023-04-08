import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seen/layout/reel_player.dart';

class ReelsPage extends StatelessWidget {
  const ReelsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(10, (context) => ReelPgaeWidget()),
        ],
      ),
    );
  }
}

class ReelPgaeWidget extends StatelessWidget {
  const ReelPgaeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ReelsPlayerScreen()));
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
                              image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqcD7xw__J9Good7dMCtD74eNYUGVLME5H-yOX6Fgc5fGd1jGjX9tm12Dg5XPVru_3I3I&usqp=CAU'),
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
                                        'ياسر سامي',
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
                child: Text(
                    ' صتني بثصتين متنصيت ثتنص يوثصيتذنصث يناضثص ينتثصيب تنصث يضصتني ثتضنصي  ',
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
