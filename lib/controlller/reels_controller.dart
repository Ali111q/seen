import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:seen/model/reel.dart';
import 'package:http/http.dart' as http;
import 'package:seen/utils/constant.dart';

import '../model/ad.dart';

class ReelsController extends ChangeNotifier {
  List<Ad> ads = [];
  List<Reel> reelsCat = [];
  List<ReelVideo> reelVideos = [];
  Future<void> getReelsCat() async {
    Map<String, String> header = {'lang': window.locale.languageCode};
    http.Response _res =
        await http.get(Uri.parse(reelsCatUrl), headers: header);
    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['success']) {
        reelsCat = [];
        for (var element in json['data']['data']) {
          reelsCat.add(Reel.fromJson(element));
          notifyListeners();
        }
     

      }
    }
  }

  Future<void> getReelsById(id) async {
    http.Response _res = await http.get(Uri.parse(getReelByIdUrl(id)));
    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['success']) {
        reelVideos = [];
        for (var element in json['data']['data']) {
          print('iosajd iosadj oais ');
           print(element['ads']);
          reelVideos.add(ReelVideo.fromJson(element));
          notifyListeners();
            for (var e in element['ads']) {
           
                   ads.add(Ad.fromJson(e));

          notifyListeners();
        }
        }
        
      }
    }
  }
}
