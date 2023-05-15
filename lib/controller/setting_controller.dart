import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:seen/model/setting.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class SettingController extends ChangeNotifier {
  Setting? setting;
  double version = 1.0;
  bool isUpdated = true;

  Future<void> getSetting() async {
    http.Response _res = await http.get(Uri.parse(settingUrl));
    if (_res.statusCode == 200) {
      var json = jsonDecode(_res.body);
      if (json['success']) {
        setting = Setting.fromJson(json['data']);
        if (double.parse(setting!.min_version) <= version) {
          isUpdated = false;
        }
        notifyListeners();
        return;
      }
    }
  }
}
