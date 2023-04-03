import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seen/helper/appbar.dart';
import 'package:seen/view/ad_page.dart';
import '../utils/colors.dart' as myColors;
import '../view/home.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _HomeState();
}

class _HomeState extends State<MainLayout> {
  List pages = [
    HomePage(),
    Container(),
    Container(),
    Container(),
    AdPage(),
  ];
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
        appBar: MyAppBar(titleText: 'titleText'),
        backgroundColor: Colors.transparent,
        body: pages[_currentIndex],
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
