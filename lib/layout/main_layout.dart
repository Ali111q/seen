import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/controller/home_controller.dart';
import 'package:seen/controller/setting_controller.dart';
import 'package:seen/helper/appbar.dart';
import 'package:seen/helper/loading.dart';
import 'package:seen/view/ads_page.dart';
import 'package:seen/view/contact_us.dart';
import 'package:seen/view/sections_page.dart';
import '../controller/user_controller.dart';
import '../utils/colors.dart' as myColors;
import '../view/home.dart';
import '../view/reels_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _HomeState();
}

class _HomeState extends State<MainLayout> with WidgetsBindingObserver {
  List<Widget> pages = [
    MainScreen(),
    ReelsPage(),
    ContactUs(),
    SectionsPage(),
    AdsPage(),
  ].reversed.toList();
  int _currentIndex = 4;
  Widget _currentPage = MainScreen();
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top]);
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
    Provider.of<HomeController>(context, listen: false).getHome();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    Provider.of<SettingController>(context, listen: false).getSetting();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
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
          extendBodyBehindAppBar: _currentIndex == 4
              ? Provider.of<HomeController>(context).bannerOpen
              : false,
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

//     return SizedBox(

//       child: Container(
//         color: Color(0xff161616),
//  height: h * 0.085,

//         child: Padding(
//           padding: const EdgeInsets.only(top: 15.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               buildNavBarItem(
//                   iconPath: 'assets/images/ads.svg',
//                   iconWidth: w * 0.1,
//                   index: 4,
//                   isSvg: true,
//                   selectedSvg: 'assets/images/ads_selected.svg'
//                   ),
//               buildNavBarItem(
//                   iconPath: 'assets/images/sections.svg',
//                   iconWidth: w * 0.1,
//                   index: 3,
//                   isSvg: true),
//               buildNavBarItem(
//                   iconPath: 'assets/images/call.svg',
//                   iconWidth: w * 0.80,
//                   index: 2,
//                   isSvg: true),
//               buildNavBarItem(
//                   iconPath: 'assets/images/reel.svg',
//                   iconWidth: w * 0.80,
//                   index: 1,
//                   isSvg: true),
//               buildNavBarItem(
//                   iconPath: 'assets/images/seen.png',
//                   iconWidth: w * 0.14,
//                   index: 0,

//                   isSvg: false),
//             ],
//           ),
//         ),
//       ),
//     );

    return Theme(
      data: ThemeData(
          splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: BottomNavigationBar(
          backgroundColor: Color(0xff161616),
          onTap: (e) {
            widget.onTabTapped(e);
          },
          useLegacyColorScheme: false,
          // selectedItemColor: Colors.green,
          enableFeedback: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.currentIndex,
          selectedIconTheme: IconThemeData(color: Colors.white),
          // iconSize: 16,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Color(0xff161616),
              icon: SvgPicture.asset('assets/images/ads.svg'),
              label: '',
              activeIcon: SvgPicture.asset(
                'assets/images/ads_selected.svg',

              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xff161616),
              icon: SvgPicture.asset(
                'assets/images/section.svg',
                  width: 30,
              ),
              label: '',
              activeIcon: SvgPicture.asset(
                'assets/images/section.svg',
                color: Colors.white,
                width: 30,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xff161616),
              icon: SvgPicture.asset('assets/images/call.svg'),
              label: '',
              activeIcon: SvgPicture.asset(
                'assets/images/call.svg',
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xff161616),
              icon: SvgPicture.asset('assets/images/reel.svg'),
              label: '',
              activeIcon: SvgPicture.asset(
                'assets/images/reel.svg',
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
                backgroundColor: Color(0xff161616),
                icon: Image.asset(
                  'assets/images/seen.png',
                  height: 27,
                ),
                label: '')
          ]),
    );
  }

  Widget buildNavBarItem(
      {required String iconPath,
      required double iconWidth,
      required int index,
      required bool isSvg,
      String? selectedSvg}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.16,
      child: GestureDetector(
        onTap: () => widget.onTabTapped(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: isSvg
              ? SvgPicture.asset(
                  selectedSvg != null
                      ? widget.currentIndex == index
                          ? selectedSvg
                          : iconPath
                      : iconPath,
                  width: iconWidth,
                  color: selectedSvg == null
                      ? index == 0
                          ? null
                          : widget.currentIndex == index
                              ? Colors.white
                              : Colors.grey
                      : null,
                )
              : Image(
                  image: AssetImage(
                    iconPath,
                  ),
                  // color:
                  //     widget.currentIndex == index ? Colors.white : Colors.grey,
                ),
        ),
      ),
    );
  }
}
