import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(AddTree());
}

var ouruser = FirebaseAuth.instance.currentUser;
var postReference = Firestore.instance.collection('Trees');

class AddTree extends StatefulWidget {
  @override
  _AddTreeState createState() => _AddTreeState();
}

class _AddTreeState extends State<AddTree> {
  File file;
  final Reference storageReference =
      FirebaseStorage().ref().child("TreePictures");
  bool uploading = false;
  String postID = Uuid().v4();
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();

  void initState() {
    super.initState();
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

  displayUploadScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        // automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Add Tree',
          style: TextStyle(
            color: Colors.green,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: Container(
        color: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_a_photo,
              size: 200,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 50,
              ),
            ),
            Container(
              child: Center(
                child: RaisedButton(
                  onPressed: captureImage,
                  child: Text('Click Picture'),
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String lat = "";
  String long = "";
  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude.toString();
      long = position.longitude.toString();
    });
  }

  compressImage() async {
    final tDirectory = await getTemporaryDirectory();
    final path = tDirectory.path;
    ImD.Image mImageFile = ImD.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postID.jpg')
      ..writeAsBytesSync(ImD.encodeJpg(mImageFile, quality: 50));
    setState(() {
      file = compressedImageFile;
    });
  }

  saveToFireStore({String url, String lati, String longi, String nickname}) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String currentDate = formatter.format(now);
    postReference
        .document(ouruser.uid)
        .collection("userPosts")
        .document(postID)
        .setData({
      "postID": postID,
      "userID": ouruser.uid,
      "postDate": currentDate,
      "userName": ouruser.displayName,
      "nickname": nickname,
      "lat": lati,
      "long": longi,
      "url": url,
      // "image1": url,
    });
    postReference
        .document(ouruser.uid)
        .collection("userPosts")
        .document(postID)
        .collection('allImages')
        .document('1')
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
    String imageLocation = 'Trees/image$postID.jpg';
    final Reference storageReference =
        FirebaseStorage().ref().child(imageLocation);
    final UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask;

    final ref = FirebaseStorage().ref().child(imageLocation);
    var imageString = await ref.getDownloadURL();
    // print(lat);
    // print(long);
    // print(imageString);
    // print(ouruser.displayName);
    saveToFireStore(
        url: imageString, lati: lat, longi: long, nickname: name.text);

    showDialog(
      context: context,
      builder: (BuildContext context) => _buildPopupDialog(context),
    );
    name.clear();
    setState(() {
      file = null;
      uploading = false;
      postID = Uuid().v4();
      lat = '';
      long = '';
    });
  }

  displayUploadForm() {
    getCurrentLocation();
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.grey[800],
        title: Text(
          'Upload',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
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
          ListTile(
            title: Container(
              width: 250,
              child: TextField(
                cursorColor: Colors.green,
                controller: name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[700],
                  focusColor: Colors.green,
                  hoverColor: Colors.green,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.nature_people),
                  labelText: "Nickname",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            title: Container(
              width: 250,
              child: Text(
                lat,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            title: Container(
              width: 250,
              child: Text(
                long,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Ubuntu',
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
          )
        ],
      ),
    );
  }

  clearPostInfo() {
    name.clear();
    setState(() {
      file = null;
      lat = "";
      long = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? displayUploadScreen() : displayUploadForm();
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text(
        'Hooray!!',
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
            Image.asset('assets/images/tenor.gif'),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Text(
              'You Just Added a Tree!',
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
}
