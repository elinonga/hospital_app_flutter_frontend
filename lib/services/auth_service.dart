import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  final Dio _dio = Dio();

  // Registration
  Future<dynamic> register(
    String first_name,
    String last_name,
    String email,
    String password1,
    String password2,
    String username,
  ) async {
    Map data = {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password1': password1,
      'password2': password2,
      'username': username,
    };

    try {
      Response response = await _dio.post(
        'http://127.0.0.1:8000/registration/',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  // Login
  Future<dynamic> login(String username, String password) async {
    var auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    try {
      Response response = await _dio.post(
        'http://127.0.0.1:8000/api/auth/login/',
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {
            'Authorization': auth,
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      print(e.response!.data);
      print(e.response!.statusCode);
      return e.response!.data;
    }
  }

  // GET USER PROFILE DATA
  Future<dynamic> getUserProfileData(String accesstoken) async {
    try {
      Response response = await _dio.get(
        'http://127.0.0.1:8000/api/auth/user/',
        queryParameters: {
          'access_token': accesstoken,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accesstoken',
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  // IMPLEMENT USER LOGOUT
  Future<dynamic> logout(String accessToken) async {
    try {
      Response response = await _dio.get(
        'http://127.0.0.1:8000/api/auth/logout/',
        queryParameters: {
          // 'api_key': 'ApiSecret.apiKey',
          'access_token': accessToken,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}
