import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:seen/model/episode.dart';
import 'package:seen/model/season.dart';
import 'package:http/http.dart' as http;
import 'package:seen/model/show.dart';
import 'package:seen/utils/constant.dart';

class ShowController extends ChangeNotifier {
  Episode? banner;
  List<Season> seasons = [];
  List<List<Episode>> episode = [];
  Show? show;
  Future<void> getShow(id, {episode}) async {
    http.Response _res =
        await http.get(Uri.parse(getShowUrl(id, episode: episode)));
    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['success']) {
        banner = null;
        episode = null;
        notifyListeners();
        banner = Episode.fromJson(json['data']['first_episode']);
        show = Show.fromJson(json['data']['shows']);
        seasons = [];

        for (var element in json['data']['shows']['season']) {
          seasons.add(Season.fromJson(element));
          notifyListeners();
        }
      }
      notifyListeners();
    }
  }

  Future<void> getSeason(id, index) async {
    http.Response _res = await http.get(Uri.parse(getSeasonUrl(id)));
    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['success']) {
        episode.add([]);
        for (var element in json['data']['data']) {
          episode[index].add(Episode.fromJson(element));
        }
      }
      notifyListeners();
    }
  }
}
