import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seen/controller/navbar_controller.dart';
import 'package:seen/main.dart';
import 'package:seen/widgets/app_bar.dart';
import 'package:svg_flutter/svg_flutter.dart';

class MainLayoutView extends StatelessWidget {
  MainLayoutView({super.key});
  NavbarController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.pages[controller.index.value],
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.green.withOpacity(0.7),
            // fixedColor: Colors.black,
            selectedItemColor: Colors.black,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.index.value,
            onTap: controller.changeIndex,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/svg/home.svg'), label: 'Home'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/svg/reels.svg'),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/svg/stream.svg'),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/svg/radio.svg'),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/svg/ads.svg'), label: 'Home'),
            ]),
      ),
    );
  }
}
