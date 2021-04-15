import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyTrees(),
  ));
}

class MyTrees extends StatefulWidget {
  @override
  _MyTreesState createState() => _MyTreesState();
}

class _MyTreesState extends State<MyTrees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'MyTrees',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
