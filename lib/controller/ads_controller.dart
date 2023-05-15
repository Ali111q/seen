import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seen/model/ad.dart';
import 'package:seen/utils/constant.dart';

class AdsController extends ChangeNotifier {
  List<Ad> ads = [];
  Map<String, String> header = {'lang': window.locale.languageCode};
  Future<void> getAds() async {
    ads = [];
    http.Response _res = await http.get(Uri.parse(getAdsUrl), headers: header);
    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['success']) {
        for (var element in json['data']['data']) {
          ads.add(Ad.fromJson(element));
          notifyListeners();
        }
      }
    }
  }

  Future<void> initialize(int e) async {
    // TODO: implement initialize
    await ads[e].intilize();
    notifyListeners();
  }

  Future<void> dispos(int index) async {
    await ads[index].dispos();
    notifyListeners();
  }
}
