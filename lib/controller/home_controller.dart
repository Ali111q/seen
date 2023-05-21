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

  Future<void> _getCashedHome() async {
            banner.clear();
        ads.clear();
        tags.clear();
    Dio dio = Dio();
    DioCacheManager cacheManager = DioCacheManager(CacheConfig());
    dio.interceptors.add(cacheManager.interceptor);

    // Make the request and use the cached data if available
    Response<dynamic> response = await dio.get(
      homeUrl,
      options: buildCacheOptions(
        const Duration(days: 5),
        forceRefresh: false,
        subKey:
            'home-data', // Optional: Specify a subkey to differentiate cache entries
      ),
    );

    if (response.statusCode == 200) {
      print(response.data);

      var json = response.data;
      if (json['success']) {
        homeError = false;


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
      } else {
        homeError = true;
        notifyListeners();
      }
    }
  }

  Future<void> getHome() async {
   

    await _getCashedHome();
    Dio dio = Dio();
    DioCacheManager cacheManager = DioCacheManager(CacheConfig());
    dio.interceptors.add(cacheManager.interceptor);

    // Make the request and use the cached data if available
    Response<dynamic> response = await dio.get(
      homeUrl,
      options: buildCacheOptions(
        const Duration(days: 5),
        forceRefresh: true,
        subKey:
            'home-data', // Optional: Specify a subkey to differentiate cache entries
      ),
    );

    if (response.statusCode == 200) {
      print(response.data);

      var json = response.data;
      if (json['success']) {
        homeError = false;
            banner.clear();
        ads.clear();
        tags.clear();
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
      } else {
        homeError = true;
        notifyListeners();
      }
    }
  }
Future<void> getCachedEpisode(id, int index, {sections}) async {
  Dio dio = Dio();
  DioCacheManager cacheManager = DioCacheManager(CacheConfig());
  dio.interceptors.add(cacheManager.interceptor);
  Options options = buildCacheOptions(
    const Duration(days: 5),
    forceRefresh: false,
    subKey: 'episode-data', // Optional: Specify a subkey to differentiate cache entries
  );
  dio.options.headers = header;

  try {
    // Make the request and use the cached data if available
    Response<dynamic> response = await dio.get(
      getEpisodeUrl(id),
      options: options,
    );

    if (response.statusCode == 200) {
      var json = response.data;
      if (json['success']) {
        if (sections == null) {
          tags[index]!.clearShow();
        } else {
          catTags[index]!.clearShow();
        }

        for (var element in json['data']['data']) {
          print(element);
          if (sections == null) {
            tags[index]!.addShow(Show.fromJson(element));
          } else {
            catTags[index].addShow(Show.fromJson(element));
          }
        }

        notifyListeners();
      }
    }
  } catch (e) {}
}

Future<void> getEpisode(id, int index, {sections}) async {
  await getCachedEpisode(id, index, sections: sections);

  Dio dio = Dio();
  DioCacheManager cacheManager = DioCacheManager(CacheConfig());
  dio.interceptors.add(cacheManager.interceptor);
  Options options = buildCacheOptions(
    const Duration(days: 5),
    forceRefresh: true,
    subKey: 'episode-data', // Optional: Specify a subkey to differentiate cache entries
  );
  dio.options.headers = header;

  try {
    // Make the request and force a refresh to get the latest data
    Response<dynamic> response = await dio.get(
      getEpisodeUrl(id),
      options: options,
    );

    if (response.statusCode == 200) {
      var json = response.data;
      if (json['success']) {
        if (sections == null) {
          tags[index]!.clearShow();
        } else {
          catTags[index]!.clearShow();
        }

        for (var element in json['data']['data']) {
          print(element);
          if (sections == null) {
            tags[index]!.addShow(Show.fromJson(element));
          } else {
            catTags[index].addShow(Show.fromJson(element));
          }
        }

        notifyListeners();
      }
    }
  } catch (e) {}
}


  Future<void> getAdInVideo() async {
    // for (var element in tags) {
    //   element!.clearShow();
    // }
    // episode = null;

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
    // for (var element in tags) {
    //   element!.clearShow();
    // }
    // episode = null;
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
