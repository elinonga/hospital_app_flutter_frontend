import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  final Dio _dio = Dio();

  // Registration
  static Future<http.Response> register(
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

    var body = json.encode(data);
    var url = Uri.parse("http://127.0.0.1:8000/registration/");

    http.Response response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print(response.body);
    return response;
  }

  // Login
  static Future<http.Response> login(String username, String password) async {
    Map data = {
      'username': username,
      'password': password,
    };

    var body = json.encode(data);
    var url = Uri.parse("http://127.0.0.1:8000/api/auth/login/");

    http.Response response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print(response.body);
    return response;
  }

  // GET USER PROFILE DATA
  Future<http.Response> getUserProfileData(String accesstoken) async {
    try {
      Response response = await _dio.get(
        'http://127.0.0.1:8000/api/auth/user/',
        queryParameters: {
          'access_token': accesstoken,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
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
  Future<Response> logout(String accessToken) async {
    try {
      Response response = await _dio.get(
        'http://127.0.0.1:8000/api/auth/logout/',
        queryParameters: {
          // 'api_key': 'ApiSecret.apiKey',
          'access_token': accessToken,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken'
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  // Logout
  // static Future<http.Response> logout() async {
  //   var url = Uri.parse("http://127.0.0.1:8000/api/auth/logout/");
  //   http.Response response =
  //       await http.post(url, headers: {"Content-Type": "application/json"});
  //   print(response.body);
  //   return response;
  // }
}
