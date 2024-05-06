import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:seen/controller/home_controller.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/data/model/show.dart';
import 'package:seen/widgets/app_bar.dart';

import '../../controller/show_controller.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context,
        isSearch: true,
        onChanged: controller.changeSearchValue,
      ),
      body: Obx(
        () => ListView(
          children: [
            Container(
              height: 30,
            ),
            ...controller.searchItems
                .map((element) => SearchWidget(show: element))
          ],
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  final ShowController controller = Get.find();
  SearchWidget({
    super.key,
    required this.show,
  });
  final Show show;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.getShow(show.id);
        Get.toNamed('/show');
      },
      child: Container(
        // width: 60.w(context),
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                show.image!,
                width: 20.w(context),
                fit: BoxFit.cover,
                height: 25.w(context),
              ),
            ),
            Container(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(show.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    )),
                Container(
                  width: 70.w(context),
                  child: Text(show.description,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.6))),
                ),
                Container(height: 3),
                Text(show.year!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.6),
                      fontWeight: FontWeight.w700,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
