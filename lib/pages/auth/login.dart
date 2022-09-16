import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_app/pages/auth/register.dart';

import 'package:http/http.dart' as http;
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/pages/widgets/auth/button.dart';
import 'package:medical_app/services/auth_service.dart';
import 'package:medical_app/services/globals.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = '';
  String _password = '';

  Future<void> loginPressed() async {
    if (_username.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_username, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Get access token and pass it to the home page
        String accessToken = responseMap['access_token'];
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomePage(accesstoken: accessToken),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, 'enter all required fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Login Page"), automaticallyImplyLeading: false),
      body: ListView(children: [
        // 🎊

        // Username
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
            onChanged: (value) {
              _username = value;
            },
          ),
        ),

        // Password
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: TextField(
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            onChanged: (value) {
              _password = value;
            },
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        // Forgot Password
        TextButton(
          onPressed: () {
            //forgot password screen
          },
          child: const Text(
            'Forgot Password',
          ),
        ),

        // Login Button
        LoginRegButton(
          btnText: 'Sign In',
          onBtnPressed: () => loginPressed(),
        ),

        // Does not have an account?
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Does not have account?'),
            TextButton(
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () {
                //signup screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrationPage()),
                );
              },
            )
          ],
        ),

        // 🎊
      ]),
    );
  }
}
