import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:seen/model/episode.dart';
import 'package:http/http.dart' as http;
import 'package:seen/model/show.dart';
import '../model/ad.dart';
import '../utils/constant.dart';

import '../model/tag.dart';

class HomeController extends ChangeNotifier {
  List<Episode?> banner = [];
  List<Tag?> tags = [];
  List<Ad?> ads = [];
  List? episode;
  Map<String, String> header = {'lang': window.locale.languageCode};
  Future<void> getHome() async {
    http.Response res = await http.get(Uri.parse(homeUrl), headers: header);
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
      notifyListeners();
    }
  }

  Future<void> getEpisode(id) async {
    episode = null;
    http.Response _res =
        await http.get(Uri.parse(getEpisodeUrl(id)), headers: header);
if (_res.statusCode == 200) {
  var json = jsonDecode(_res.body);
  if (json['success']) {
    print(json['data']);
for (var element in json['data']['data']) {
    tags.firstWhere((element) => element!.id == id)!.addShow(Show.fromJson(element));
  
}

  }
}

  }
}
