import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:seen/model/episode.dart';
import 'package:http/http.dart' as http;
import 'package:seen/model/show.dart';
import '../model/ad.dart';
import '../utils/constant.dart';

import '../model/tag.dart';

class HomeController extends ChangeNotifier {
  bool homeError = false;
  List<Episode?> banner = [];
  List<Tag?> tags = [];
  List<Ad?> ads = [];
  Ad? adInVideo;
  List? episode;
  List<Tag> catTags = [];
  Map<String, String> header = {'lang': window.locale.languageCode};
  // Future<void> getHome() async {
  //   http.Response res = await http.get(Uri.parse(homeUrl), headers: header);
  //   print(res.statusCode);

  //   if (res.statusCode == 200) {
  //     try {
  //       homeError = false ;
  //       notifyListeners();
  //         banner.clear();
  //     ads.clear();
  //     var json = jsonDecode(res.body);
  //     if (json['success']) {
  //       json['data']['banner'].forEach((e) {
  //         banner.add(Episode.fromJson(e));
  //       });
  //       if (tags.isEmpty) {
  //         json['data']['categories'].forEach((e) {
  //           tags.add(Tag.fromJson(e));
  //         });
  //       }

  //       json['data']['ads'].forEach((e) {
  //         ads.add(Ad.fromJson(e));
  //       });
  //       notifyListeners();
  //       return;

  //     }
  //      homeError = true;
  //   notifyListeners();
  //   return;
  //     } catch (e) {
  //           homeError = true;
  //   notifyListeners();
  //   return;
  //     }

  //   }

  // }

  Future<void> getHome() async {
    Dio dio = Dio();
    DioCacheManager cacheManager = DioCacheManager(CacheConfig());
    Options options =
        buildCacheOptions(const Duration(days: 5), forceRefresh: true);
    dio.interceptors.add(cacheManager.interceptor);
    Response res = await dio.get(
      homeUrl,
      options: options,
    );
    if (res.statusCode == 200) {
      print(res.data);

      var json = res.data;
      if (json['success']) {
        homeError = false;
        banner.clear();
        ads.clear();

        json['data']['banner'].forEach((e) {
          banner.add(Episode.fromJson(e));
        });

        if (tags.isEmpty) {
          json['data']['categories'].forEach((e) {
            tags.add(Tag.fromJson(e));
          });
        }

        json['data']['ads'].forEach((e) {
          ads.add(Ad.fromJson(e));
        });

        notifyListeners();
        return;
      }
    }

    notifyListeners();
  }

  Future<void> getEpisode(id, {sections}) async {
    for (var element in tags) {
      element!.clearShow();
    }
    episode = null;

    Dio dio = Dio();
    DioCacheManager cacheManager = DioCacheManager(CacheConfig());
    Options options =
        buildCacheOptions(const Duration(days: 5), forceRefresh: true);
    dio.interceptors.add(cacheManager.interceptor);
    dio.options.headers = header;

    try {
      Response _res = await dio.get(getEpisodeUrl(id));

      if (_res.statusCode == 200) {
        var json = _res.data;
        if (json['success']) {
          for (var element in json['data']['data']) {
            if (sections == null) {
              tags
                  .firstWhere((element) => element!.id == id)!
                  .addShow(Show.fromJson(element));
            } else {
              catTags
                  .firstWhere((element) => element!.id == id)!
                  .addShow(Show.fromJson(element));
            }
            notifyListeners();
          }
        }
      }
    } catch (e) {}
  }

  Future<void> getAdInVideo() async {
    for (var element in tags) {
      element!.clearShow();
    }
    episode = null;

    Dio dio = Dio();
    DioCacheManager cacheManager = DioCacheManager(CacheConfig());
    Options options =
        buildCacheOptions(const Duration(days: 5), forceRefresh: true);
    dio.interceptors.add(cacheManager.interceptor);
    dio.options.headers = header;

    try {
      Response _res = await dio.get(addInVideoUrl);

      if (_res.statusCode == 200) {
        var json = _res.data;
        if (json['success']) {
          adInVideo = Ad.fromJson(json['data']);
        }
      }
    } catch (e) {}
  }

  Future<void> getCats() async {
    for (var element in tags) {
      element!.clearShow();
    }
    episode = null;
    Dio dio = Dio();
    DioCacheManager cacheManager = DioCacheManager(CacheConfig());
    Options options =
        buildCacheOptions(const Duration(days: 5), forceRefresh: true);
    dio.interceptors.add(cacheManager.interceptor);
    try {
      final response =
          await dio.get(getCatsUrl, options: Options(headers: header));

      if (response.statusCode == 200) {
        var json = response.data;
        if (json['success']) {
          catTags = [];
          for (var element in json['data']) {
            catTags.add(Tag.fromJson(element));
          }
          notifyListeners();
        }
      }
    } catch (e) {
      // Handle any error that occurred during the request
    }
  }
}
