import 'package:flutter/material.dart';

void main() {
  runApp(AboutUs());
}

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Image(
            image: AssetImage('assets/images/tree2.png'),
          ),
        ),
        appBar: AppBar(
          title: Text('About Us'),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
