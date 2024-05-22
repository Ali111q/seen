import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:seen/config/style/colors.dart';
import 'package:seen/config/style/styles.dart';
import 'package:seen/controller/home_controller.dart';
import 'package:seen/core/extension.dart';

import 'package:seen/widgets/app_bar.dart';
import 'package:svg_flutter/svg.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ContactView extends StatelessWidget {
  ContactView({super.key});
  HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, isSearch: false, backRoute: 'no'),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 3.h(context),
            ),
            Container(
              height: 3.h(context),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    // color: Colors.white,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff900201), Color(0xff170077)],
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/contact.svg',
                          color: MyColors.swatch,
                        ),
                        Container(
                          width: 10,
                        ),
                        Text("شارك أعلانك على تطبيق Seen",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                    ),
                    Container(
                      height: 20,
                    ),
                    Text(
                        "أضمن انتشارك وتواصل معنا من خلال الأرقام المثبتة ادناه اومن خلال البريد الالكتروني",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                    Container(
                      height: 70,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/contact.svg",
                          width: 19,
                          height: 19,
                          color: Colors.white,
                        ),
                        Container(
                          width: 10,
                        ),
                        Text("أتصل بنا",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ))
                      ],
                    ),
                    Container(
                      height: 20,
                    ),
                    ContactWidget(
                      logo: 'assets/png/asiacell.png',
                      phone: controller.setting.value?.asia ?? '07737503949',
                      image: 'assets/svg/asiacell.svg',
                    ),
                    Container(
                      height: 20,
                    ),
                    ContactWidget(
                      logo: 'assets/png/zain.png',
                      phone: controller.setting.value?.zain ?? '07737503949',
                      image: 'assets/svg/asiacell.svg',
                    ),
                    Container(
                      height: 70,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/email.svg',
                          width: 20,
                          height: 30,
                          color: Colors.white,
                        ),
                        Container(
                          width: 10,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      controller.setting.value?.email ?? 'Seen.A.D@gmail.com',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  const ContactWidget(
      {super.key,
      required this.phone,
      required this.image,
      required this.logo});
  final String phone;
  final String image;
  final String logo;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1.h(context)),
      width: 80.w(context),
      height: 20.w(context),
      decoration: BoxDecoration(
        color: MyColors.swatch.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(logo),
          Container(
            child: SvgPicture.asset(image),
            width: 15.w(context),
            height: 15.w(context),
          ),
          Container(),
          Text(
            phone,
            style: TextStyle(
                color: MyColors.swatch,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SvgPicture.asset(
            'assets/svg/contact.svg',
          )
        ],
      ),
    );
  }
}
