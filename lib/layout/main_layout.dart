import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/setting_controller.dart';
import 'package:seen/helper/appbar.dart';
import 'package:seen/helper/loading.dart';
import 'package:seen/view/ads_page.dart';
import 'package:seen/view/contact_us.dart';
import 'package:seen/view/sections_page.dart';
import '../controlller/user_controller.dart';
import '../utils/colors.dart' as myColors;
import '../view/home.dart';
import '../view/reels_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _HomeState();
}

class _HomeState extends State<MainLayout> {
  List pages = [
    MainScreen(),
    ReelsPage(),
    ContactUs(),
    SectionsPage(),
    AdsPage(),
  ];
  int _currentIndex = 0;
  Widget _currentPage = MainScreen();
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserController>(context, listen: false)
        .checkLogin()
        .then((value) {
      if (value) {
        Provider.of<UserController>(context, listen: false).getUserFromShared();
      }
    });

    Provider.of<SettingController>(context, listen: false).getSetting();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
          appBar: MyAppBar(context, titleText: 'titleText'),
          backgroundColor: Colors.transparent,
          body: _currentPage,
          bottomNavigationBar: CustomNavigationBar(
            currentIndex: _currentIndex,
            onTabTapped: (int index) {
              setState(() {
                _currentIndex = index;
                _currentPage = pages[index];
              });
            },
          )),
    );
  }
}

class CustomNavigationBar extends StatefulWidget {
  CustomNavigationBar(
      {Key? key, required this.currentIndex, required this.onTabTapped})
      : super(key: key);
  Function(int index) onTabTapped;
  int currentIndex;
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SizedBox(
      height: h * 0.11,
      child: Container(
        color: myColors.dark,
        child: Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNavBarItem(
                  iconPath: 'assets/images/seen.svg',
                  iconWidth: w * 0.095,
                  index: 0,
                  isSvg: true),
              buildNavBarItem(
                  iconPath: 'assets/images/bs.svg',
                  iconWidth: w * 0.075,
                  index: 1,
                  isSvg: true),
              buildNavBarItem(
                  iconPath: 'assets/images/call_us.png',
                  iconWidth: w * 0.095,
                  index: 2,
                  isSvg: false),
              buildNavBarItem(
                  iconPath: 'assets/images/sections.png',
                  iconWidth: w * 0.095,
                  index: 3,
                  isSvg: false),
              buildNavBarItem(
                  iconPath: 'assets/images/ads.png',
                  iconWidth: w * 0.095,
                  index: 4,
                  isSvg: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavBarItem({
    required String iconPath,
    required double iconWidth,
    required int index,
    required bool isSvg,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTabTapped(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: isSvg
              ? SvgPicture.asset(
                  iconPath,
                  width: iconWidth,
                  color: index == 0
                      ? null
                      : widget.currentIndex == index
                          ? Colors.white
                          : Colors.grey,
                )
              : ImageIcon(
                  AssetImage(
                    iconPath,
                  ),
                  color:
                      widget.currentIndex == index ? Colors.white : Colors.grey,
                ),
        ),
      ),
    );
  }
}
