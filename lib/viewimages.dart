import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:treetracker/addtree.dart';

main() {
  runApp(
    MaterialApp(
      home: ViewImages(),
    ),
  );
}

class ViewImages extends StatefulWidget {
  final postID;
  final nickname;

  const ViewImages({Key key, this.postID, this.nickname}) : super(key: key);
  @override
  _ViewImagesState createState() => _ViewImagesState();
}

class _ViewImagesState extends State<ViewImages> {
  Stream<QuerySnapshot> _myTreePhotos;
  @override
  void initState() {
    super.initState();
    _myTreePhotos = Firestore.instance
        .collection('Trees')
        .document(ouruser.uid)
        .collection("userPosts")
        .document(widget.postID)
        .collection('allImages')
        .snapshots();
  }

  showImages() {
    return StreamBuilder<QuerySnapshot>(
      stream: _myTreePhotos,
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
        final _data = snapshot.data.docs;
        print(_data);
        return ListView.builder(
            itemCount: _data.length,
            itemBuilder: (builder, index) {
              final document = _data[index];
              print(document["image"]);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.grey[800],
                    child: (Image.network(document["image"])),
                  ),
                ),
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(
          Icons.add_a_photo,
          color: Colors.green,
        ),
        backgroundColor: Colors.grey[800],
        label: Text(
          'Add New Image',
          style: TextStyle(
            color: Colors.green,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          widget.nickname,
          style: TextStyle(
            color: Colors.green,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: showImages(),
    );
  }
}
