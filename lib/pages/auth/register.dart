import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_app/pages/auth/login.dart';

import 'package:http/http.dart' as http;
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/services/auth_service.dart';
import 'package:medical_app/pages/widgets/auth/button.dart';
import 'package:medical_app/services/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final AuthServices _apiClient = AuthServices();

  bool isLoading = false;

  String first_name = '';
  String last_name = '';
  String username = '';
  String email = '';
  String password1 = '';
  String password2 = '';

  // Method to create account
  Future<void> createAccount() async {
    setState(() {
      isLoading = true;
    });
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      // create account
      dynamic response = await _apiClient.register(
        first_name,
        last_name,
        email,
        password1,
        password2,
        username,
      );

      if (response['ErrorCode'] == null) {
        // Get access token and pass it to the home page
        String accessToken = response['access_token'];

        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', accessToken);
        localStorage.setString('user', jsonEncode(response['user']));

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomePage(accesstoken: accessToken),
            ));
      } else {
        errorSnackBar(context, response.values.first[0]);
      }
    } else {
      errorSnackBar(context, 'email not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(children: [
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
                    username = value;
                  },
                ),
              ),

              // First Name
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  ),
                  onChanged: (value) {
                    first_name = value;
                  },
                ),
              ),

              // Last Name
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                  onChanged: (value) {
                    last_name = value;
                  },
                ),
              ),

              // Email
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    email = value;
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
                    password1 = value;
                  },
                ),
              ),

              // Confirm Password
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                  onChanged: (value) {
                    password2 = value;
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Register Button
              LoginRegButton(
                btnText: 'Register',
                onBtnPressed: () => createAccount(),
              ),

              // Has an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Already have account?'),
                  TextButton(
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      //sign in screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
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
