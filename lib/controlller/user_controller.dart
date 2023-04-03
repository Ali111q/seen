import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seen/utils/constant.dart';
import '../model/user.dart';
import '../services/shared_service.dart';

class UserController extends ChangeNotifier {
  SharedService _service = SharedService();
  User? user;
  bool isLogin = false;
  getUserFromShared() {
    user = _service.getUser();
    isLogin = user != null;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _service.initialize();
    print(email);
    http.Response _res = await http.post(Uri.parse(loginUrl),
        body: {'email': email, 'password': password},
        headers: {'Accept': 'application/json'});
    print(_res.statusCode);
    print(_res.body);
    if (_res.statusCode == 200) {
      var json = await jsonDecode(_res.body);
      if (json['success']) {
        user = User.fromJson(json['data']);
        if (user != null) {
          print(user!.toJson());
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
    print(_res.statusCode);
    print(_res.body);
    if (_res.statusCode == 200) {
      var json = await jsonDecode(_res.body);
      if (json['success']) {
        user = User.fromJson(json['data']);
        print(user!.email);
        _service.saveUser(user!);
      }
    }
    notifyListeners();
  }
}
