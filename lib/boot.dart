import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:treetracker/home.dart';
import 'package:treetracker/login.dart';

// import 'homescreen.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BootScreen(),
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
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
            Flexible(
              flex: 1,
              child: Image.asset(
                'assets/images/tree2.png',
                height: 160,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text("Tree Tracker",
                style: TextStyle(
                  color: Colors.green.shade500,
                  fontSize: 40,
                  fontFamily: 'Ubuntu',
                )),
          ],
        ),
      ),
    );
  }
}
