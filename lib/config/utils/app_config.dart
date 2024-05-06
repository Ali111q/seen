import 'package:get/get.dart';
import 'package:seen/main.dart';

class AppConfig {
  static String baseUrl = 'https://www.app-seen.com/api';
  static Map<String, String> headers = {
    'content-type': 'application/json-patch+json',
    'Authorization': 'Bearer ${prefs.getString('token')}' ?? '',
    'lang': Get.locale?.languageCode ?? 'en'
    
  };
}
