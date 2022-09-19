import 'package:flutter/material.dart';
import 'package:medical_app/pages/widgets/appbar.dart';
import 'package:medical_app/pages/widgets/drawer.dart';

class MessagePage extends StatefulWidget {
  final String accesstoken;
  const MessagePage({Key? key, required this.accesstoken}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(title: "Messages",),
      drawer: MainDrawer(accesstoken: widget.accesstoken),
    );
  }
}
