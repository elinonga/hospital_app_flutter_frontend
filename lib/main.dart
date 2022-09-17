import 'package:flutter/material.dart';
import 'package:medical_app/main_screen.dart';
import 'package:medical_app/pages/auth/login.dart';
import 'package:medical_app/pages/auth/register.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meddler - Clinic Mobile App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const LoginPage(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  // final String accesstoken;
  const CheckAuth({Key? key}) : super(key: key);

  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  late String accesstoken;

  bool isAuth = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = HomePage(accesstoken: accesstoken);
    } else {
      child = LoginPage();
    }
    return Scaffold(
      body: child,
    );
  }
}
