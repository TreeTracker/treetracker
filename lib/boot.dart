import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treetracker/auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:treetracker/home.dart';
import 'package:treetracker/login.dart';

import 'homescreen.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BootScreen(),
    );
  }
}

class BootScreen extends StatefulWidget {
  @override
  _BootScreenState createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen> {
  User _user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _user = user;
      });
    });
    if (_user == null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginApp())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AppHomePage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[900],
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/tree2.png'),
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Text(
              'TreeTracker',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ubuntu',
                fontSize: 25,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40),
            ),
            SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                backgroundColor: Colors.brown,
                strokeWidth: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
