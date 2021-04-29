import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:treetracker/addtree.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as ImD;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:intl/intl.dart';

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
  File file;
  bool uploading = false;
  final name = DateTime.now();
  var postReference = Firestore.instance.collection('Trees');

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text(
        'Success',
        style: TextStyle(
          fontFamily: 'Ubuntu',
          color: Colors.green,
        ),
      ),
      // content: new Text('Your Tree was added'),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/smile.gif'),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Text(
              'You Just Updated the image of your Tree!',
              style: TextStyle(
                color: Colors.green,
                fontFamily: 'Ubuntu',
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.black,
          color: Colors.green,
          child: const Text(
            'Okay',
            style: TextStyle(
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
      ],
    );
  }

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
    file = null;

    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  Future captureImage() async {
    // Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 680,
      maxWidth: 970,
    );
    setState(() {
      this.file = imageFile;
    });
  }

  compressImage() async {
    final tDirectory = await getTemporaryDirectory();
    final path = tDirectory.path;
    ImD.Image mImageFile = ImD.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$name.jpg')
      ..writeAsBytesSync(ImD.encodeJpg(mImageFile, quality: 50));
    setState(() {
      file = compressedImageFile;
    });
  }

  saveToFireStore({String url}) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String currentDate = formatter.format(now);
    postReference
        .document(ouruser.uid)
        .collection("userPosts")
        .document(widget.postID)
        .collection('allImages')
        .document(name.toString())
        .setData({
      "image": url,
      "postDate": currentDate,
    });
  }

  controlUpload() async {
    setState(() {
      uploading = true;
    });
    await compressImage();
    String imageLocation = 'Trees/image$name.jpg';
    final Reference storageReference =
        FirebaseStorage().ref().child(imageLocation);
    final UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask;
    final ref = FirebaseStorage().ref().child(imageLocation);
    var imageString = await ref.getDownloadURL();
    saveToFireStore(url: imageString);
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildPopupDialog(context),
    );
    setState(() {
      uploading = false;
      file = null;
    });
  }

  uploadForm() {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        title: Text(
          'Upload',
          style: TextStyle(color: Colors.green),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: ListView(
        children: [
          uploading
              ? LinearProgressIndicator(
                  backgroundColor: Colors.green,
                )
              : Text(''),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(file),
                      fit: BoxFit.cover,
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
                onPressed: uploading ? null : () => controlUpload(),
                color: Colors.green,
                child: Text(
                  'Upload',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showImages() {
    return Scaffold(
      backgroundColor: Colors.grey[900],
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: captureImage,
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
      body: StreamBuilder<QuerySnapshot>(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? showImages() : uploadForm();
  }
}