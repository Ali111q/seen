import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seen/controller/setting_controller.dart';
import 'package:seen/model/setting.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    Setting? setting = Provider.of<SettingController>(context).setting;
    return Column(
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
              // height: MediaQuery.of(context).size.width * 0.6,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                // height: MediaQuery.of(context).size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'اجعل حالة اعلانك',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'font',
                            fontSize: 30),
                      ),
                      Text(
                        'على وضع',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'font',
                            fontSize: 22),
                      ),
                      SvgPicture.asset(
                        'assets/images/seen.svg',
                        width: 100,
                      ),
                      Text(
                        'اضمن انتشارك',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'font',
                            fontSize: 30),
                      ),
                      Text(
                        'تواصل معنا من خلال الارقام المثيتة ادناه او البريد الالكتروني',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'font',
                            fontSize: 18),
                      ),
                    ],
                  ),
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
                      setting!.asia == null
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Asia',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                Text(
                                  setting.asia!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )
                              ],
                            ),
                      setting.zain == null
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Zain',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                Text(
                                  setting.zain!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )
                              ],
                            ),
                      setting.korek == null
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Korek',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                Text(
                                  setting.korek!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )
                              ],
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
              child: setting.email == null
                  ? Container()
                  : Text(
                      setting.email!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
            ),
          ),
        )
      ],
    );
  }
}
