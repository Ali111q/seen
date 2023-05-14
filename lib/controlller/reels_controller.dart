import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:seen/model/reel.dart';
import 'package:http/http.dart' as http;
import 'package:seen/utils/constant.dart';

import '../model/ad.dart';
import '../model/user.dart';

class ReelsController extends ChangeNotifier {
  List<Reel> reelsCat = [];
  List<ReelVideo> reelVideos = [];
  List<Comment> comments = [];
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

  Future<void> getReelsById(id, {String? token}) async {
    http.Response _res = await http.get(Uri.parse(getReelByIdUrl(id)),
        headers: {
          'Authorization': 'Bearer ${token}',
          "Accept": 'application/json'
        });
    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['success']) {
        reelVideos = [];
        for (var element in json['data']['data']) {
          reelVideos.add(ReelVideo.fromJson(element));
        }
        notifyListeners();
      }
    }
  }

  Future<void> getComments(id) async {
    http.Response _res = await http.get(Uri.parse(CommentsUrl(id)));
    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['success']) {
        comments = [];
        for (var element in json['data']) {
          comments.add(Comment.fromJson(element));
        }
        notifyListeners();
      }
    }
  }

  Future<void> view(id) async {
    http.Response _res = await http.get(Uri.parse(viewUrl(id)));
    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
    }
  }

  Future<void> postCommetn(id, String comment, User user) async {
    comments.add(Comment(
        comment: comment, id: 0, image: user.image, userName: user.name));
    http.Response _res = await http.post(Uri.parse(commentUrl), body: {
      'comment': comment,
      'reel_id': id
    }, headers: {
      'Authorization': 'Bearer ${user.token}',
      "Accept": 'application/json'
    });
    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['success']) {}
    }
    notifyListeners();
  }

  Future<void> like(id, token) async {
    http.Response _res = await http.get(
        Uri.parse(
          likeUrl(id),
        ),
        headers: {
          'Authorization': 'Bearer ${token}',
          "Accept": 'application/json'
        });

    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
    }
  }
}
