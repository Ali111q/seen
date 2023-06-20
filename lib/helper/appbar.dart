import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_to_airplay/flutter_to_airplay.dart';
import 'package:provider/provider.dart';
import 'package:seen/layout/search.dart';

import '../controller/user_controller.dart';

class MyAppBar extends AppBar {
  final String titleText;

  MyAppBar(context, {required this.titleText})
      : super(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      if (Provider.of<UserController>(context, listen: false)
                              .user ==
                          null) {
                        Navigator.of(context).pushNamed('/login');
                      } else {
                        Navigator.of(context)
                            .pushNamed('/profile')
                            .then((value) {
                          Provider.of<UserController>(context, listen: false)
                              .getUserFromShared();
                        });
                      }
                    },
                    child:  Provider.of<UserController>(context).user != null? CircleAvatar(backgroundImage: NetworkImage( Provider.of<UserController>(context).user!.image), backgroundColor: Colors.transparent, ): SvgPicture.asset('assets/images/person.svg')),
                Container(
                  width: 20,
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ));
                    },
                    child: SvgPicture.asset('assets/images/search.svg')),
                Container(
                  width: 20,
                ),
                // if (Platform.isIOS)
                //   AirPlayRoutePickerView(
                //     tintColor: Colors.white,
                //     activeTintColor: Colors.white,
                //     backgroundColor: Colors.transparent,
                //     onClosePickerView: () {},
                //     onShowPickerView: () {},
                //   ),
              ],
            ),
            actions: [
              SvgPicture.asset('assets/images/seen_logo.svg'),
              Container(
                width: 10,
              )
            ]);
}
