import 'dart:async';
import 'dart:convert';

import 'package:seen/common/helper/api_helper.dart';
import 'package:seen/data/model/user.dart';

class UserApi extends ApiHelper<User> {
  Future<User?> login({required email, required password}) async {
    return await super.post('/login',
        jsonEncode({'email': email, 'password': password}), User.fromJson);
  }

  Future<User?> social({required email, required name, String? userId}) async {
    return await super.post(
        '/login-social',
        jsonEncode({
          if (email != null) 'email': email,
          if (name != null) 'name': name,
          'secret': 'bbFtwwndiOdoz59Kd6W7fPh6neKdQh4A',
          if (userId != null) 'user_id': userId
        }),
        User.fromJson);
  }

  Future<User?> register(
      {required name, required email, required password, String? image}) async {
    return await super.post(
        '/register',
        jsonEncode({
          'password': password,
          'email': email,
          'name': name,
          'image': image
        }),
        User.fromJson);
  }

  Future updateUser() async {}
  Future deleteAccount() async {
    await super.delete('/user-delete');
  }
}
