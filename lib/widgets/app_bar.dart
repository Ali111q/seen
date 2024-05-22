import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:go_router/go_router.dart';
import 'package:seen/controller/auth_controller.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/view/search/search.dart';

import '../config/style/colors.dart';
import '../config/style/styles.dart';
import 'logo.dart';

AppBar MyAppBar(BuildContext context,
    {required isSearch, void Function(String)? onChanged, String? backRoute}) {
  FocusNode focusNode = FocusNode();
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: MyColors.backGround,
    elevation: 0,
    leading: onChanged != null
        ? null
        : backRoute != null
            ? IconButton(
                onPressed: () {
                  if (backRoute == 'no') {
                    Navigator.of(context).pop();
                  } else {
                    Get.back();
                  }
                },
                icon: Icon(Icons.arrow_back_ios))
            : Logo(
                width: 18.w(context),
              ),
    title: !isSearch
        ? null
        : Container(
            height: 40,
            child: TextField(
              style: TextStyle(fontSize: 17),
              focusNode: focusNode,
              onChanged: onChanged,
              textAlignVertical: TextAlignVertical.center,
              onTap: () {
                if (onChanged == null) {
                  focusNode.unfocus();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchView(),
                  ));
                }
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  prefixIcon: Icon(Icons.search),
                  fillColor: MyColors.swatch,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius:
                          BorderRadius.circular(MyStyles.buttonBorderRadius)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius:
                          BorderRadius.circular(MyStyles.buttonBorderRadius))),
            ),
          ),
    actions: [Hero(tag: '1', child: AppBarCircleAvatar())],
  );
}

class AppBarCircleAvatar extends StatelessWidget {
  AppBarCircleAvatar({
    super.key,
  });

  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.toNamed('/profile');
        },
        child: CircleAvatar(
          radius: 27,
          backgroundImage: NetworkImage(controller.user.value!.image),
        ));
  }
}
