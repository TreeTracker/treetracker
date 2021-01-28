import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.grey,
          body: Center(
            child: Image(
              image: AssetImage('lib/images/logo.png'),
            ),
          ),
          appBar: AppBar(
            title: Text('About Us'),
            backgroundColor: Colors.lightGreen,
          ),
        ),
      ),
    );
