import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:seen/model/reel.dart';
import 'package:http/http.dart' as http;
import 'package:seen/utils/constant.dart';

import '../model/ad.dart';
import '../model/user.dart';

class ReelsController extends ChangeNotifier {
  int count = 0;
  List<Reel> reelsCat = [];
  List<ReelVideo> reelVideos = [];
  List<Comment> comments = [];
  Future<void> getReelsCat() async {
    Map<String, String> header = {'lang': window.locale.languageCode};
    Dio dio = Dio();
    DioCacheManager cacheManager = DioCacheManager(CacheConfig());
    Options options =
        buildCacheOptions(const Duration(days: 5), forceRefresh: true);
    dio.interceptors.add(cacheManager.interceptor);
    try {
      final response =
          await dio.get(reelsCatUrl, options: Options(headers: header));

      if (response.statusCode == 200) {
        var json = response.data;
        if (json['success']) {
          reelsCat = [];
          for (var element in json['data']['data']) {
            reelsCat.add(Reel.fromJson(element));
            notifyListeners();
          }
        }
      }
    } catch (e) {
      // Handle any error that occurred during the request
    }
  }

  Future<void> getReelsById(id, {String? token}) async {
    Dio dio = Dio();
    DioCacheManager cacheManager = DioCacheManager(CacheConfig());
    Options options =
        buildCacheOptions(const Duration(days: 5), forceRefresh: true);
    dio.interceptors.add(cacheManager.interceptor);
    try {
      final response = await dio.get(
        getReelByIdUrl(id),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        var json = response.data;
        if (json['success']) {
          reelVideos = [];
          count = json['data']['total'];
          for (var element in json['data']['data']) {
            print(element);
            reelVideos.add(ReelVideo.fromJson(element));
          }
          notifyListeners();
        }
      }
    } catch (e) {
      // Handle any error that occurred during the request
    }
  }

  Future<void> getComments(id) async {
    Dio dio = Dio();
    DioCacheManager cacheManager = DioCacheManager(CacheConfig());
    Options options =
        buildCacheOptions(const Duration(days: 5), forceRefresh: true);
    dio.interceptors.add(cacheManager.interceptor);
    try {
      final response = await dio.get(CommentsUrl(id));

      if (response.statusCode == 200) {
        var json = response.data;
        if (json['success']) {
          comments = [];
          for (var element in json['data']) {
            comments.add(Comment.fromJson(element));
          }
          notifyListeners();
        }
      }
    } catch (e) {
      // Handle any error that occurred during the request
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
