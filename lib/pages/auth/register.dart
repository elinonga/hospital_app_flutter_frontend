import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_app/pages/auth/login.dart';

import 'package:http/http.dart' as http;
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/services/auth_service.dart';
import 'package:medical_app/pages/widgets/auth/button.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String firstName = '';
  String lastName = '';
  String username = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
        automaticallyImplyLeading: false,
      ),
      body: ListView(children: [
        // 🎊

        // Username
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'User Name',
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
            controller: firstNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'First Name',
            ),
            onChanged: (value) {
                firstName = value;
            },
          ),
        ),

        // Last Name
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: lastNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Last Name',
            ),
            onChanged: (value) {
                lastName = value;
            },
          ),
        ),

        // Email
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: emailController,
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
            controller: passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            onChanged: (value) {
                password = value;
            },
          ),
        ),

        // Confirm Password
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: TextField(
            obscureText: true,
            controller: confirmPasswordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Confirm Password',
            ),
            onChanged: (value) {
                confirmPassword = value;
            },
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        // Register Button
        LoginRegButton(
          btnText: 'Create Account',
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
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            )
          ],
        ),

        // 🎊
      ]),
    );
  }


  // Method to create account
  createAccount() async {
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Passwords do not match'),
            content: const Text('Please confirm your password'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {  
      // if passwords match create account
      bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
      if (emailValid) {
        // create account
        http.Response response =
          await AuthServices.register(firstName, lastName, email, 
          password, confirmPassword, username);

        if (response.statusCode == 200) {
          // if account created successfully
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['success']) {
            // if account created successfully
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const HomePage(),
              ));
          } else {
            // if account not created successfully
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Account not created'),
                  content: Text(responseData['message']),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        } else {
          // if account not created successfully
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Account not created'),
                content: const Text('Please try again'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Email'),
              content: const Text('Please enter a valid email'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

}
