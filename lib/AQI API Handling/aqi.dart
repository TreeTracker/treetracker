import 'package:flutter/material.dart';

class Aqi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('AQI'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
