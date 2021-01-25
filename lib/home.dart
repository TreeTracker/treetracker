import 'package:flutter/material.dart';
import 'package:treetracker/auth.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RaisedButton(
          child: Text('Logout'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Auth()),
            );
          },
        ),
      ),
    );
  }
}
