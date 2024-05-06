import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:seen/config/style/colors.dart';
import 'package:seen/config/style/styles.dart';
import 'package:seen/controller/auth_controller.dart';
import 'package:seen/core/extension.dart';

import '../../widgets/dots.dart';

class OnBoardingView extends StatelessWidget {
  OnBoardingView({super.key});
  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Swiper(
            onIndexChanged: controller.changeIndex,
            itemCount: 4,
            autoplay: true,
            loop: false,
            itemBuilder: (context, index) => Container(
              height: 100.h(context),
              width: 100.w(context),
              child: Image.asset(
                controller.onBoardingImages[index],
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 40.h(context),
              width: 100.w(context),
              decoration: BoxDecoration(gradient: MyColors.onBoardingGradient),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Dots(
                    itemsCount: controller.onBoardingImages.length,
                    index: controller.onBoardingIndex.value,
                  ),
                ),
              ),
              OnBoardingButton(
                outlined: false,
                title: 'login'.tr,
                onTap: () {
                  Get.toNamed('/login');
                },
              ),
              OnBoardingButton(
                onTap: () {
                  Get.toNamed('/register');
                },
                outlined: true,
                title: 'register'.tr,
              ),
              Container(
                height: 20,
              )
            ],
          )
        ],
      ),
    );
  }
}

class OnBoardingButton extends StatelessWidget {
  OnBoardingButton(
      {super.key, required this.outlined, required this.title, this.onTap});
  final bool outlined;
  final String title;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 8.h(context),
        width: 80.w(context),
        decoration: BoxDecoration(
          color: outlined ? MyColors.backGround : MyColors.swatch,
          border: Border.all(color: MyColors.swatch, width: 2),
          borderRadius: BorderRadius.circular(MyStyles.fieldBorderRadius),
        ),
        child: Center(
          child: Text(
            title,
            style: outlined
                ? TextStyle(
                    color: MyColors.swatch,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)
                : MyStyles.buttonTitleStyle,
          ),
        ),
      ),
    );
  }
}
