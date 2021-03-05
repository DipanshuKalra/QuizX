import 'package:flutter/material.dart';
import 'package:quiz_adda/loginscreen.dart';
import 'package:quiz_adda/registrationscreen.dart';
import 'package:quiz_adda/components/loginregisterbutton.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 20.0,
                ),
                child: Image.asset(
                  'images/QLogo1.png',
                  height: 80.0,
                ),
              ),
            ),
            LoginRegisterButtons(
              textToDisplay: 'LOGIN',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
            LoginRegisterButtons(
              textToDisplay: 'REGISTER',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
