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

  Show? show;
  Future<void> getShow(id, {episode}) async {
    seasons = [];
    banner = null;
    episode = null;
    notifyListeners();

    http.Response _res =
        await http.get(Uri.parse(getShowUrl(id, episode: episode)));

    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['success']) {
        banner = Episode.fromJson(json['data']['first_episode']);
        show = Show.fromJson(json['data']['shows']);

        for (var element in json['data']['shows']['season']) {
          seasons.add(Season.fromJson(element));

          notifyListeners();
        }
      }
      notifyListeners();
    }
  }

  Future<void> getSeason(id) async {
    http.Response _res = await http.get(Uri.parse(getSeasonUrl(id)));
    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['success']) {
        seasons.firstWhere((e) => e!.id == id).clearEpisodes();
        for (var element in json['data']['data']) {
          seasons
              .firstWhere((e) => e!.id == id)
              .addEpisode(Episode.fromJson(element));
        }
      }
      notifyListeners();
    }
  }
}
