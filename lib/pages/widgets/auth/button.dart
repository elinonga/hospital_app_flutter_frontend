import 'package:flutter/material.dart';

class LoginRegButton extends StatelessWidget {
  const LoginRegButton({
    Key? key, 
  required this.btnText, 
  required this.onBtnPressed}) : super(key: key);

  final String btnText;
  final Function onBtnPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.black,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: () {
          onBtnPressed();
        },
        minWidth: 320,
        height: 60,
        child: Text(
          btnText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
