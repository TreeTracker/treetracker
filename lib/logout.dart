import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(Logout());
}

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
            Flexible(
              flex: 1,
              child: Image.asset(
                'assets/images/tree2.png',
                height: 160,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              "Signing Out",
              style: TextStyle(
                color: Colors.green.shade500,
                fontSize: 25,
                fontFamily: 'Ubuntu',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40),
            ),
            SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                // backgroundColor: Colors.brown,
                strokeWidth: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
