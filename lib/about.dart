import 'package:flutter/material.dart';

void main() {
  runApp(About());
}

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            color: Colors.green,
            fontFamily: 'Ubuntu',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}
