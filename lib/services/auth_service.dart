import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final Dio _dio = Dio();

  // get Token with Shared Preferences
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token!;
  }

  // Registration
  Future<dynamic> register(
    String fname,
    String lname,
    String email,
    String password1,
    String password2,
  ) async {
    Map data = {
      'first_name': fname,
      'last_name': lname,
      'email': email,
      'password1': password1,
      'password2': password2,
    };

    try {
      Response response = await _dio.post(
        'http://127.0.0.1:8000/api/v1/auth/register/',
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
  Future<dynamic> login(String email, String password) async {
    var auth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));

    try {
      Response response = await _dio.post(
        'http://127.0.0.1:8000/api/v1/auth/login/',
        data: {
          'email': email,
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
        'http://127.0.0.1:8000/api/v1/auth/user/',
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
        'http://127.0.0.1:8000/api/v1/auth/logout/',
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
