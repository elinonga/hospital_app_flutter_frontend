import 'dart:convert';
import 'package:http/http.dart' as http;

// Registration AuthService
class AuthServices {
  static Future<http.Response> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String confirmPassword,
    String username,
  ) async {
    Map data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'username': username,
    };

    var body = json.encode(data);
    var url = Uri.parse("http://127.0.0.1:8000/registration/");
    

    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"}, 
      body: body
      );

    print(response.body);
    return response;

    }
}