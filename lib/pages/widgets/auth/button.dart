import 'package:flutter/material.dart';

class LoginRegButton extends StatelessWidget {
  const LoginRegButton(
      {Key? key, required this.btnText, required this.onBtnPressed})
      : super(key: key);

  final String btnText;
  final Function onBtnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: ElevatedButton(
          child: Text(btnText),
          onPressed: () {
            onBtnPressed();
          },
        ));
  }
}
