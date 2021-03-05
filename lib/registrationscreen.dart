import 'package:flutter/material.dart';
import 'package:quiz_adda/components/loginregisterbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_adda/quizscreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

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
            textToDisplay: 'REGISTER',
            onPress: () async {
              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                if (newUser != null) {
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
