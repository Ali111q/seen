import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seen/config/style/colors.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  
  String location;
  ScaffoldWithNavBar({super.key, required this.child, required this.location});

  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _currentIndex = 0;

  static List<MyCustomBottomNavBarItem> tabs = [
    MyCustomBottomNavBarItem(
      icon: SvgPicture.asset('assets/svg/home.svg'),
      label: 'HOME',
      initialLocation: '/home',
    ),
    MyCustomBottomNavBarItem(
      icon: SvgPicture.asset(
        'assets/svg/reels.svg',
      ),
      label: 'reels',
      initialLocation: '/reels',
    ),
    MyCustomBottomNavBarItem(
      icon: SvgPicture.asset(
        'assets/svg/stream.svg',
      ),
      label: 'stream',
      initialLocation: '/stream',
    ),
    MyCustomBottomNavBarItem(
      icon: SvgPicture.asset('assets/svg/radio.svg'),
      label: 'radio',
      initialLocation: '/contact',
    ),
    MyCustomBottomNavBarItem(
      icon: SvgPicture.asset('assets/svg/ads.svg'),
      label: 'ads',
      initialLocation: '/ads',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    // const labelStyle = TextStyle(fontFamily: 'Roboto');
    return Scaffold(
      extendBody: true,
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        // selectedLabelStyle: labelStyle,
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
        // unselectedLabelStyle: labelStyle,
        selectedItemColor: MyColors.swatch,
        selectedFontSize: 12,
        iconSize: 25,
        selectedIconTheme: IconThemeData(color: MyColors.swatch),
        unselectedIconTheme:
            IconThemeData(color: MyColors.swatch.withOpacity(0.2)),
        unselectedItemColor: MyColors.swatch.withOpacity(0.5),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _goOtherTab(context, index);
        },
        currentIndex: widget.location == '/reels'
            ? 1
            : widget.location == '/home'
                ? 0
                : widget.location == '/stream'
                    ? 2
                    : widget.location == '/ads'
                        ? 3
                        : 4,
        items: tabs,
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;

    setState(() {
      _currentIndex = index;
    });

    router.go(location);
  }
}

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const MyCustomBottomNavBarItem(
      {required this.initialLocation,
      required Widget icon,
      String? label,
      Widget? activeIcon})
      : super(icon: icon, label: label, activeIcon: activeIcon ?? icon);
}
