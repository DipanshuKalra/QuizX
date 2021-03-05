import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  List<Widget> userNames = [];
  List<Widget> scores = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getScores();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print('there is some error');
      print(e);
    }
  }

  void getScores() async {
    await _firestore
        .collection('Scores')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  userNames.add(
                    Text(
                      doc['email'],
                      style: TextStyle(
                          color: loggedInUser.email == doc['email']
                              ? Colors.blue
                              : Colors.black,
                          fontSize: 20.0),
                    ),
                  );
                  scores.add(
                    Text(
                      doc['score'].toString(),
                      style: TextStyle(
                          color: loggedInUser.email == doc['email']
                              ? Colors.blue
                              : Colors.black,
                          fontSize: 20.0),
                    ),
                  );
                });
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('LEADERBOARD'),
          centerTitle: true,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: userNames,
            ),
            Column(
              children: scores,
            ),
          ],
        ),
      ),
    );
  }
}
