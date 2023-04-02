import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart' as myColors;

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _HomeState();
}

class _HomeState extends State<MainLayout> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [myColors.firstBackGround, myColors.sceondBackGround],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(33),
                color: Color(0xff789FA0),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/chart.png',
                          ),
                          fit: BoxFit.fill)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.6,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(33),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Text(
                      'اتصل بنا',
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: Color(0xff0A3249),
                        borderRadius: BorderRadius.circular(33),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Text('data'), Text('data')],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Text('data'), Text('data')],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Text('data'), Text('data')],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Material(
              borderRadius: BorderRadius.circular(33),
              elevation: 3,
              color: Color(0xff0A3249),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.2,
                child: Center(
                  child: Text(
                    'seen.A.D@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: h * 0.1,
          child: BottomNavigationBar(
            iconSize: w * 0.065,
            backgroundColor: myColors.dark,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/seen.svg'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/bs.svg'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/call_us.png',
                  width: 25,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/sections.png'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/ads.png',
                  width: 30,
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
