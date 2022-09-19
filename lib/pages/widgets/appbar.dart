import 'package:flutter/material.dart';
import 'package:medical_app/services/auth_service.dart';

class AppBarDesign extends StatefulWidget with PreferredSizeWidget {
  final String title;
  const AppBarDesign({Key? key, required this.title}) : super(key: key);

  @override
  State<AppBarDesign> createState() => _AppBarDesignState();
  
  @override
  Size get preferredSize => const Size.fromHeight(75);
}

class _AppBarDesignState extends State<AppBarDesign> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
