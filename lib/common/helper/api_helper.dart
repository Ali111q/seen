import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:seen/common/network/dio_client.dart';
import 'package:tuple/tuple.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiHelper<T> {
  final DioClient _dioClient = DioClient(Dio());

  Future<T?> post(String endPoint, Object body,
      T Function(Map<String, dynamic> json) tFromJson) async {
    try {
      Response res = await _dioClient.dio.post(
        endPoint,
        data: body,
      );
      T data = _fromJson<T>(res.data['data'], tFromJson);
      return data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> postWithoutRes(String endPoint, Object body) async {
    try {
      Response res = await _dioClient.dio.post(
        endPoint,
        data: body,
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<T?> get(
      String endPoint, T Function(Map<String, dynamic> json) tFromJson) async {
    try {
      Response res = await _dioClient.dio.get(endPoint);
      T data = _fromJson<T>(res.data['data'], tFromJson);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getWithoutRes(
    String endPoint,
  ) async {
    try {
      Response res = await _dioClient.dio.get(endPoint);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>?> getItems(
      String endPoint, T Function(Map<String, dynamic> json) tFromJson,
      {Map<String, dynamic>? query,
      String? path,
      bool doubleData = false}) async {
    try {
      Response res = await _dioClient.dio
          .get('$endPoint/${path ?? ''}', queryParameters: query);
      print(res);
      List<T> data = _fromJsonList<T>(
          doubleData ? res.data['data']['data'] : res.data['data'], tFromJson);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  T _fromJson<T>(
      dynamic json, T Function(Map<String, dynamic> json) tFromJson) {
    return tFromJson(json);
  }

  List<T> _fromJsonList<T>(
      List<dynamic> jsonList, T Function(Map<String, dynamic> json) tFromJson) {
    return jsonList.map((item) => _fromJson<T>(item, tFromJson)).toList();
  }

  Future<Tuple2<bool, dynamic>> postFormData({
    required String api,
    Map<String, dynamic>? queryParameters,
    FormData? data,
  }) async {
    try {
      Response<dynamic> response = await _dioClient.dio
          .post(api, queryParameters: queryParameters, data: data);
      return Tuple2(true, response.data);
    } catch (e) {
      Logger().e("Error in POST (FormData) request: $e");
      return Tuple2(false, null);
    }
  }

  Future<bool> update(String endpoint, String id, dynamic data) async {
    try {
      Response<dynamic> response =
          await _dioClient.dio.put('$endpoint/$id', data: jsonEncode(data));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String endpoint, {String? id}) async {
    try {
      Response<dynamic> response = await _dioClient.dio.post(
        '$endpoint/${id ?? ''}',
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
