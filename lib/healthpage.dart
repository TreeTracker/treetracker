import 'package:flutter/material.dart';

void main() {
  runApp(Helppage());
}

class Helppage extends StatelessWidget {
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Help'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
