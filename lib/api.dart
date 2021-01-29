import 'package:flutter/material.dart';

void main() {
  runApp(Aqi());
}

class Aqi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('AQI'),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
