import 'package:flutter/material.dart';

import 'api.dart';

void main() {
  runApp(Aqi());
}

class Aqi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            automaticallyImplyLeading: true,
            title: Text(
              'AQI',
              style: TextStyle(
                color: Colors.green,
                fontFamily: 'Ubuntu',
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[800],
          ),
          body: ShowData(),
        ),
      ),
    );
  }
}
