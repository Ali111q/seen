import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:seen/model/episode.dart';
import 'package:seen/model/season.dart';
import 'package:http/http.dart' as http;
import 'package:seen/model/show.dart';
import 'package:seen/utils/constant.dart';

class ShowController extends ChangeNotifier {
  List<Show> searchList = [];
  Episode? banner;
  List<Season> seasons = [];
  int selectedEpisode = 0;
  Show? show;
  Future<void> getShow(id, { episode}) async {
    seasons = [];
    banner = null;
    notifyListeners();

    http.Response _res =
        await http.get(Uri.parse(getShowUrl(id, episode: episode)));

    if (_res.statusCode == 200) {
    
      var json = jsonDecode(_res.body);
      if (json['success']) {
        print(json);
        banner = Episode.fromJson(json['data']['first_episode']);
        show = Show.fromJson(json['data']['shows']);

        for (var element in json['data']['shows']['season']) {
          seasons.add(Season.fromJson(element));

          notifyListeners();
        }
      }
      if (banner != null) {
        selectedEpisode = banner!.id;
      }
      notifyListeners();
    }
  }

  Future<void> getSeason(id) async {
    http.Response _res = await http.get(Uri.parse(getSeasonUrl(id)));
    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['success']) {
        seasons.firstWhere((e) => e.id == id).clearEpisodes();
        for (var element in json['data']['data']) {
          seasons
              .firstWhere((e) => e!.id == id)
              .addEpisode(Episode.fromJson(element));
          notifyListeners();
        }
      }
      notifyListeners();
    }
  }

  Future<void> search(String? search) async {
    searchList.clear();
    notifyListeners();
    http.Response _res = await http.get(Uri.parse(searchUrl(search)));
    if (_res.statusCode == 200) {
      searchList.clear();
      notifyListeners();

      var json = await jsonDecode(_res.body);
      if (json['success']) {
        for (var element in json['data']['data']) {
          searchList.add(Show.fromJson(element));
        }
      }
      notifyListeners();
    }
  }
}
