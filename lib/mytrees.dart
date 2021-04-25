import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treetracker/addtree.dart';
import 'viewimages.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

void main() {
  runApp(MaterialApp(
    home: MyTrees(),
  ));
}

var postReference = Firestore.instance.collection('Trees');

class MyTrees extends StatefulWidget {
  @override
  _MyTreesState createState() => _MyTreesState();
}

class _MyTreesState extends State<MyTrees> {
  Stream<QuerySnapshot> _myTrees;
  Marker marker;
  GoogleMapController _controller;
  final LatLng _center = const LatLng(19.0760, 72.8777);

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(myInterceptor);
    _myTrees = Firestore.instance
        .collection('Trees')
        .document(ouruser.uid)
        .collection("userPosts")
        .snapshots();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pop(); // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        // automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
              child: SizedBox(
                height: 75,
                width: 75,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.green,
                  strokeWidth: 7,
                ),
              ),
            );
          }
          final treeCount = snapshot.data.docs.length;
          print(treeCount);
          if (treeCount == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.grey[800],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        title: Text(
                          "Oops! It looks like you don't have any Trees.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 25,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.grey[800],
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[800],
                      child: ListTile(
                        subtitle: Text(
                          'Get started by clicking on the Add Tree Button',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Container(
                  child: Center(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddTree()),
                        );
                      },
                      color: Colors.green,
                      child: Text(
                        'Add Tree',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          final _data = snapshot.data.docs;
          // lati = double.parse(document['lat']);
          //             longi = double.parse(document['long']);
          return Column(
            children: [
              Flexible(
                flex: 3,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 8,
                  ),
                  // markers: Set.of((marker != null) ? [marker] : []),
                  markers: _data
                      .map(
                        (document) => Marker(
                          markerId: MarkerId(document['postID']),
                          position: LatLng(
                            double.parse(document['lat']),
                            double.parse(document['long']),
                          ),
                          infoWindow: InfoWindow(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ViewImages(
                                    nickname: document['nickname'],
                                    postID: document['postID'],
                                  ),
                                ),
                              );
                            },
                            title: document['nickname'],
                            snippet: document['lat'] + '  ' + document['long'],
                          ),
                        ),
                      )
                      .toSet(),
                ),
              ),
              // child: Center(
              //   child: Container(
              //     child: Text('Google Maps'),
              //   ),
              // ),
              Flexible(
                flex: 2,
                child: ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (builder, index) {
                    final document = _data[index];
                    // setState(() {
                    //   lati = double.parse(document['lat']);
                    //   longi = double.parse(document['long']);
                    //   marker = Marker(
                    //       position: LatLng(
                    //         lati,
                    //         longi,
                    //       ),
                    //       markerId: MarkerId(document['postID']),
                    //       icon: BitmapDescriptor.defaultMarker,
                    //       infoWindow: InfoWindow(
                    //         title: document['nickname'],
                    //       ));
                    // });
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewImages(
                              nickname: document['nickname'],
                              postID: document['postID'],
                            ),
                          ),
                        );
                      },
                      onLongPress: () async {
                        _controller.animateCamera(
                          CameraUpdate.newCameraPosition(
                            new CameraPosition(
                                bearing: 0,
                                target: LatLng(
                                  double.parse(document['lat']),
                                  double.parse(document['long']),
                                ),
                                tilt: 0,
                                zoom: 16.00),
                          ),
                        );
                      },
                      tileColor: Colors.grey[800],
                      trailing: CircleAvatar(
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

// class Tree {
//   final String nickname;
//   final String postID;

//   Tree(this.nickname, this.postID);
// }
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
