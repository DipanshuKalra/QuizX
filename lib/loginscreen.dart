import 'package:flutter/material.dart';
import 'package:quiz_adda/components/loginregisterbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_adda/quizscreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Hero(
              tag: 'logo',
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 20.0,
                ),
                child: Image.asset(
                  'images/QLogo1.png',
                  height: 200.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: 'Enter your email',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: TextField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: 'Enter your password',
              ),
            ),
          ),
          LoginRegisterButtons(
            textToDisplay: 'LOGIN',
            onPress: () async {
              try {
                final signedInUser = await _auth.signInWithEmailAndPassword(
                    email: email, password: password);
                if (signedInUser != null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuizScreen()));
                }
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }
}
