import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:fluttor_app/config/config.dart';
import 'package:fluttor_app/utils/validator.dart';

class ApiClient {
  final Dio _dio = Dio();

  /*Future<dynamic> registerUser(Map<String, dynamic>? data) async {
    try {
      Response response = await _dio.post(
          'https://api.loginradius.com/identity/v2/auth/register',
          data: data,
          //queryParameters: {'apikey': ApiSecret.apiKey},
          options: Options(headers: {'X-LoginRadius-Sott': ApiSecret.sott}));
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }*/

  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        '${Config.api}api/user/login',
        options: Options(headers: {
          'content-Type': "application/json",
        }),
        data: jsonEncode({
          'Email': email,
          'Password': password
        })
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> postRequest( String url, Map data) async {
    try {
      var user = await Validator.loginUserData();
      var token = user['token'] ?? '';
      Response response = await _dio.post(
          '${Config.api}${url}',
          options: Options(headers: {
            'content-Type': "application/json",
            'token': token
          }),
          data: jsonEncode(data)
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> registration(Map data) async {
    try {
      Response response = await _dio.post(
          '${Config.api}api/user',
          options: Options(headers: {
            'content-Type': "application/json",
          }),
          data: jsonEncode(data)
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

}