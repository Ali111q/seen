import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:seen/common/network/dio_cache_manager.dart';
import 'package:seen/config/interceptors/interceptor.dart';
import 'package:seen/config/utils/app_config.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    dio
      ..options.baseUrl = AppConfig.baseUrl
      ..options.headers = AppConfig.headers
      ..interceptors.add(CacheManager.manager)
      ..interceptors.add(MyInterceptor())
      ..interceptors.add(AwesomeDioInterceptor());
  }
}
