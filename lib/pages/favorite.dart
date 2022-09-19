import 'package:flutter/material.dart';
import 'package:medical_app/pages/widgets/appbar.dart';
import 'package:medical_app/pages/widgets/drawer.dart';

class Favorite extends StatefulWidget {
  final String accesstoken;
  const Favorite({Key? key, required this.accesstoken}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(title: "Favorite",),
      drawer: MainDrawer(accesstoken: widget.accesstoken,),
    );
  }
}
