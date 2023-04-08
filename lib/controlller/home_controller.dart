import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:seen/model/episode.dart';
import 'package:http/http.dart' as http;
import '../model/ad.dart';
import '../utils/constant.dart';

import '../model/tag.dart';

class HomeController extends ChangeNotifier {
  List<Episode?> banner = [];
  List<Tag?> tags = [];
  List<Ad?> ads = [];
  Future<void> getHome() async {
    http.Response res = await http.get(Uri.parse(homeUrl));
    print(res.statusCode);

    if (res.statusCode == 200) {
      banner.clear();
      tags.clear();
      ads.clear();
      var json = jsonDecode(res.body);
      if (json['success']) {
        json['data']['banner'].forEach((e) {
          banner.add(Episode.fromJson(e));
        });
        json['data']['categories'].forEach((e) {
          tags.add(Tag.fromJson(e));
        });
        json['data']['ads'].forEach((e) {
          ads.add(Ad.fromJson(e));
        });
      }
    }
  }
}
