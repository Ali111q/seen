import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class SharedService {
  late SharedPreferences shared;
  Future<void> initialize() async {
    shared = await SharedPreferences.getInstance();
  }

  User? getUser() {
    if (shared.get('name') == null) {
      return null;
    }
    return User(
        name: shared.get('name') as String,
        token: shared.get('token') as String,
        email: shared.get('email') as String,
        image: shared.get('image') as String);
  }

  void saveUser(User user) {
    shared.setString('token', user.token);
    shared.setString('name', user.name);
    shared.setString('email', user.email);
    shared.setString('image', user.image);
  }
}
