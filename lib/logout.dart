import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LogoutScreen(),
    );
  }
}

class LogoutScreen extends StatefulWidget {
  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      exit(0);
    });
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
              'Logged Out',
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
