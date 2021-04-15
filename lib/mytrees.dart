// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MaterialApp(
    home: MyTrees(),
  ));
}

var postReference = Firestore.instance.collection('Trees');
var ouruser = FirebaseAuth.instance.currentUser;

class MyTrees extends StatefulWidget {
  @override
  _MyTreesState createState() => _MyTreesState();
}

class _MyTreesState extends State<MyTrees> {
  Stream<QuerySnapshot> _myTrees;

  @override
  void initState() {
    super.initState();

    _myTrees = Firestore.instance
        .collection('Trees')
        .document(ouruser.uid)
        .collection("userPosts")
        .snapshots();
  }

  showMaps() {
    return Container(
        child: Center(
      child: Text('Show Google Maps'),
    ));
  }

  testFunc() {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('LOL'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          // print(_myTrees);
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _myTrees,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Loading',
              ),
            );
          }
          final treeCount = snapshot.data.docs.length;
          final _data = snapshot.data.docs;
          return Column(
            children: [
              Flexible(
                flex: 3,
                child: showMaps(),
                // child: Center(
                //   child: Container(
                //     child: Text('Google Maps'),
                //   ),
              ),
              Flexible(
                flex: 2,
                child: ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (builder, index) {
                    final document = _data[index];
                    return ListTile(
                      onTap: () {
                        print(document.toString());
                        testFunc();
                      },
                      tileColor: Colors.grey[800],
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        backgroundImage: NetworkImage(document['url']),
                      ),
                      title: Text(
                        document['nickname'],
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      subtitle: Text(
                        document['lat'] + '  ' + document['long'],
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// class TreeList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: _data.length,
//       itemBuilder: (builder, index) {
//         final document = _data[index];
//         return ListTile(
//           title: Text(document['nickname']),
//           subtitle: Text(document['lat'] + '  ' + document['long']),
//         );
//       },
//     );
//   }
// }

// class GMaps extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
