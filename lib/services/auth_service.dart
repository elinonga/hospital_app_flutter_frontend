import 'dart:convert';

import "package:http/http.dart" as http;

main() async {
  AuthService authService = AuthService();
  RegistrationResponse? registrationResponse = await authService.registration(
      "hekima", "ndagha789", "ndagha789", "hekima@gmail.com");
  if (registrationResponse != null) {
    if (registrationResponse.email != null) {
      registrationResponse.email!.forEach((element) {
        print(element);
      });
    }
    if (registrationResponse.username != null) {
      registrationResponse.username!.forEach((element) {
        print(element);
      });
    }
    if (registrationResponse.non_filed_errors != null) {
      registrationResponse.non_filed_errors!.forEach((element) {
        print(element);
      });
    }
    if (registrationResponse.password1 != null) {
      registrationResponse.password1!.forEach((element) {
        print(element);
      });
    }
    if (registrationResponse.key != null) {
      print(registrationResponse.key!);
    }
  }
}

class AuthService {
  final registrationUrl = Uri.parse("http://127.0.0.1:8000/registration/");

  Future<RegistrationResponse?> registration(
      String username, String password1, String password2, String email) async {
    var response = await http.post(registrationUrl, body: {
      "username": username,
      "password1": password1,
      "password2": password2,
      "email": email
    });
    print(response.body);
    return RegistrationResponse.fromJson(jsonDecode(response.body));
  }
}

class RegistrationResponse {
  List<dynamic>? non_filed_errors;
  List<dynamic>? password1;
  List<dynamic>? username;
  List<dynamic>? email;
  dynamic? key;

  RegistrationResponse(
    this.email,
    this.password1,
    this.username,
    this.key,
    this.non_filed_errors,
  );

  factory RegistrationResponse.fromJson(mapOfBody) {
    return RegistrationResponse(
      email: mapOfBody["email"],
      key: mapOfBody["key"],
      non_filed_errors: mapOfBody["non_filed_errors"],
      password1: mapOfBody["password1"],
      username: mapOfBody["username"],
    );
  }
}
