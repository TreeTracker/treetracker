import 'package:flutter/material.dart';
import 'package:treetracker/auth.dart';

class BootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(),
        backgroundColor: Colors.grey[900],
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('assets/images/appLogo2.png')),
              Padding(
                padding: EdgeInsets.all(30),
              ),
              Text(
                'TreeTracker',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Ubuntu',
                  fontSize: 35,
                ),
              ),
              RaisedButton(
                child: Text('Continue'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
