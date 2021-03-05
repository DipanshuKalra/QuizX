import 'package:flutter/material.dart';

class LoginRegisterButtons extends StatelessWidget {
  LoginRegisterButtons({this.onPress, this.textToDisplay});

  final String textToDisplay;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: MaterialButton(
        height: 50.0,
        elevation: 10.0,
        disabledElevation: 10.0,
        child: Text(
          textToDisplay,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onPress,
        color: Colors.blue,
      ),
    );
  }
}
