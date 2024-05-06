import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seen/config/style/styles.dart';
import 'package:seen/controller/auth_controller.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/view/auth/login/login.dart';
import 'package:seen/view/contact/contact.dart';
import 'package:seen/view/profile/edit_profile.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  // Save changes
                  Get.to(ProfileEditView());
                },
                icon: Icon(Icons.edit),
              ),
            ],
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Hero(
                  tag: '1',
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(controller.user.value!.image),
                    radius: 60,
                  ),
                ),
                Container(
                  height: 20,
                ),
                Text(
                  'profile'.tr,
                  style: MyStyles.pageTitleStyle,
                ),
                Container(
                  height: 20,
                ),
                ProfileWidget(
                  title: 'name'.tr,
                  value: controller.user.value!.name,
                ),
                ProfileWidget(
                  title: 'email'.tr,
                  value: controller.user.value!.email,
                ),
                Expanded(child: Container()),
                ProfileButton(
                  iconColor: Color(0xff1CCE18),
                  title: 'contact_us'.tr,
                  svgIcon: 'assets/svg/contact.svg',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ContactView(),
                    ));
                  },
                ),
                Container(
                  height: 10,
                ),
                ProfileButton(
                  title: 'logout'.tr,
                  svgIcon: 'assets/svg/logout.svg',
                  onTap: () {
                    Get.offAndToNamed('/login');
                    controller.logout();
                  },
                ),
                Container(
                  height: 10,
                ),
                ProfileButton(
                  title: 'delete_account'.tr,
                  svgIcon: 'assets/svg/logout.svg',
                  iconColor: Colors.red,
                  onTap: () {
                    // Get.offAndToNamed('/login');
                    controller.deleteAccount();
                  },
                ),
                Container(
                  height: 10.h(context),
                )
              ],
            ),
          )),
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    this.onTap,
    required this.svgIcon,
    required this.title,
    this.iconColor,
  });

  final void Function()? onTap;
  final String svgIcon;
  final String title;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 40.w(context),
        height: 69,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgIcon,
              color: iconColor,
            ),
            Container(
              width: 10,
            ),
            Text(title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ))
          ],
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: MyStyles.buttonTitleWhiteStyle,
                overflow: TextOverflow.fade,
              ),
              Container(
                width: 20,
              ),
              Expanded(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
