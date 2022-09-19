import 'package:flutter/material.dart';
import 'package:medical_app/pages/widgets/appbar.dart';
import 'package:medical_app/pages/widgets/drawer.dart';

class AppointmentPage extends StatefulWidget {
  final String accesstoken;
  const AppointmentPage({Key? key, required this.accesstoken}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(title: "Appointments",),
      drawer: MainDrawer(accesstoken: widget.accesstoken),
    );
  }
}
