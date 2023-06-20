import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seen/model/ad.dart';
import 'package:seen/utils/constant.dart';

class AdsController extends ChangeNotifier {
  List<Ad> ads = [];
  Map<String, String> header = {'lang': window.locale.languageCode};
Future<void> _getCachedAds() async {
  ads.clear();
  Dio dio = Dio();
  DioCacheManager cacheManager = DioCacheManager(CacheConfig());
  dio.interceptors.add(cacheManager.interceptor);

  // Make the request and use the cached data if available
  Response<dynamic> response = await dio.get(
    getAdsUrl,
    options: buildCacheOptions(
      const Duration(days: 5),
      forceRefresh: false,
      
      subKey: 'ads-data', // Optional: Specify a subkey to differentiate cache entries
    ),
  );
  response.headers.add('lang', 'ar');


  if (response.statusCode == 200) {
    print(response.data);

    var json = response.data;
    if (json['success']) {
      for (var element in json['data']['data']) {
        ads.add(Ad.fromJson(element));
      }
      notifyListeners();
    }
  }
}

Future<void> getAds() async {
  await _getCachedAds();
  Dio dio = Dio();
  DioCacheManager cacheManager = DioCacheManager(CacheConfig());
  dio.interceptors.add(cacheManager.interceptor);

  // Make the request and use the cached data if available
  Response<dynamic> response = await dio.get(
    getAdsUrl,
    options: buildCacheOptions(
      const Duration(days: 5),
      forceRefresh: true,
      subKey: 'ads-data', // Optional: Specify a subkey to differentiate cache entries
    ),
  );
  response.headers.add('lang', 'ar');

  if (response.statusCode == 200) {
    print(response.data);

    var json = response.data;
    if (json['success']) {
      ads.clear();
      for (var element in json['data']['data']) {
        ads.add(Ad.fromJson(element));
      }
      notifyListeners();
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
