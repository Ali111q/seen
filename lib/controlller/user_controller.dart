import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seen/utils/constant.dart';
import '../model/user.dart';
import '../services/shared_service.dart';

class UserController extends ChangeNotifier {
  SharedService _service = SharedService();
  User? user;
  bool isLogin = false;
  Future<void> getUserFromShared() async {
    await _service.initialize();
    user = _service.getUser();
    isLogin = user != null;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _service.initialize();
    http.Response _res = await http.post(Uri.parse(loginUrl),
        body: {'email': email, 'password': password},
        headers: {'Accept': 'application/json'});
    if (_res.statusCode == 200) {
      var json = await jsonDecode(_res.body);
      if (json['success']) {
        user = User.fromJson(json['data']);
        if (user != null) {
          _service.saveUser(user!);
        }
      }
    }
    notifyListeners();
  }

  Future<void> register(String email, String name, String password) async {
    _service.initialize();

    http.Response _res = await http.post(Uri.parse(registerUrl), body: {
      'email': email,
      'password': password,
      'name': name,
    }, headers: {
      'Accept': 'application/json'
    });
    if (_res.statusCode == 200) {
      var json = await jsonDecode(_res.body);
      if (json['success']) {
        user = User.fromJson(json['data']);
        _service.saveUser(user!);
      }
    }
    notifyListeners();
  }

  Future<bool> checkLogin() async {
    if (user != null) {
      _service.initialize();
      http.Response _res = await http.get(Uri.parse(loginCheckUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user!.token}'
      });

      if (_res.statusCode == 200) {
        var json = await jsonDecode(_res.body);

        if (json['success']) {
          return true;
        }
        _service.clear();
        notifyListeners();
        return false;
      }
      if (_res.statusCode == 500) {
        return true;
      }
      _service.clear();
      notifyListeners();
      return false;
    }

    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    if (user != null) {
      _service.initialize();
      http.Response _res = await http.get(Uri.parse(logoutUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user!.token}'
      });
      if (_res.statusCode == 200) {
        var json = await jsonDecode(_res.body);

        if (json['success']) {
          _service.clear();
          notifyListeners();
        }
        _service.clear();
        notifyListeners();
      }
      _service.clear();
      notifyListeners();
    }
    _service.clear();
    notifyListeners();
  }
}
