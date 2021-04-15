// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  final LatLng _center = const LatLng(19.0760, 72.8777);
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
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 12,
                  ),
                ),
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
                      onTap: () {},
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
