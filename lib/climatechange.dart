import 'package:flutter/material.dart';

void main() {
  runApp(ClimateChange());
}

class ClimateChange extends StatefulWidget {
  ClimateChange({Key key}) : super(key: key);

  @override
  _ClimateChangeState createState() => _ClimateChangeState();
}

class _ClimateChangeState extends State<ClimateChange> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: Colors.grey[800],
            child: Icon(
              Icons.navigate_before,
              color: Colors.green,
            ),
          ),
          backgroundColor: Colors.grey[900],
          body: ListView(
            children: [
              Image(
                image: AssetImage(
                  'assets/images/climate.jpg',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
