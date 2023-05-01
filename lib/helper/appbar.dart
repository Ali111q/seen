import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../controlller/user_controller.dart';

class MyAppBar extends AppBar {
  final String titleText;

  MyAppBar(context,{required this.titleText})
      : super(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    if ( Provider.of<UserController>(context, listen: false).user == null) {
                    Navigator.of(context).pushNamed('/login');
                      
                    }else{
                    Navigator.of(context).pushNamed('/profile');}
                  },
                  child: SvgPicture.asset('assets/images/person.svg')),
                Container(
                  width: 20,
                ),
                SvgPicture.asset('assets/images/search.svg'),
                Container(
                  width: 20,
                ),
                SvgPicture.asset('assets/images/screen.svg')
              ],
            ),
            actions: [
              SvgPicture.asset('assets/images/seen_logo.svg'),
              Container(
                width: 10,
              )
            ]);
}
