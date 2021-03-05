import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_adda/leaderboard.dart';

String email;

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _firestore = FirebaseFirestore.instance;
  int questionNumber = 0;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState() {
    getCurrentUser();
    email = loggedInUser.email;
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.leaderboard),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LeaderBoard()));
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            questions[questionNumber],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
            child: MaterialButton(
              elevation: 10.0,
              height: 50.0,
              child: Text(
                'TRUE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
              color: Colors.green,
              onPressed: () {
                userAnswers.add(1);
                setState(() {
                  if (questionNumber < 5) {
                    questionNumber++;
                  } else {
                    int score = 0;
                    for (int i = 0; i < 6; i++) {
                      if (userAnswers[i] == answerKey[i]) {
                        score++;
                      }
                    }
                    _firestore.collection('Scores').doc('$email').set({
                      'email': loggedInUser.email,
                      'score': score,
                    });

                    Alert(
                      context: context,
                      type: AlertType.success,
                      title: "SCORE",
                      desc: "$score",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              questionNumber = 0;
                              userAnswers = [];
                              Navigator.pop(context);
                            });
                          },
                          width: 120,
                        )
                      ],
                    ).show();
                  }
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
            child: MaterialButton(
              elevation: 10.0,
              height: 50.0,
              child: Text(
                'FALSE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
              color: Colors.red,
              onPressed: () {
                userAnswers.add(0);
                setState(() {
                  if (questionNumber < 5) {
                    questionNumber++;
                  } else {
                    int score = 0;
                    for (int i = 0; i < 6; i++) {
                      if (userAnswers[i] == answerKey[i]) {
                        score++;
                      }
                    }

                    _firestore.collection('Scores').doc('$email').set({
                      'email': loggedInUser.email,
                      'score': score,
                    });

                    Alert(
                      context: context,
                      type: AlertType.success,
                      title: "SCORE",
                      desc: "$score",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              questionNumber = 0;
                              userAnswers = [];
                              Navigator.pop(context);
                            });
                          },
                          width: 120,
                        )
                      ],
                    ).show();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

//all about quiz

List answerKey = [0, 1, 1, 0, 0, 0];

List userAnswers = [];

List questions = [
  'Everyone in India follows Hinduism',
  'Rajasthan is the largest state in India',
  'Goa is the smallest state in India',
  'Everyone in India has a name called Rajesh',
  'Dog is the least loved animal in India',
  'Everyone in India is a vegetarian',
];
