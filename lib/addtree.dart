import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(AddTree());
}

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
                top: 20,
              ),
              child: FlatButton(
                onPressed: captureImage,
                child: Text('Upload Image'),
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
      ..writeAsBytesSync(ImD.encodeJpg(mImageFile, quality: 90));
    setState(() {
      file = compressedImageFile;
    });
  }

  // Future<String> uploadImage(mImageFile) async {
  //   String imageLocation = 'Trees/image$postID.jpg';
  //   final Reference storageReference =
  //       FirebaseStorage().ref().child(imageLocation);
  //   final UploadTask uploadTask = storageReference.putFile(mImageFile);
  //   await uploadTask;

  //   final ref = FirebaseStorage().ref().child(imageLocation);
  //   var imageString = await ref.getDownloadURL();
  //   print(imageString);
  //   return imageString;
  // }

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
    print(imageString);
    // var imageurl = uploadImage(file);
  }

  displayUploadForm() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload'),
        actions: [
          FlatButton(
            child: Text('Upload'),
            onPressed: uploading ? null : () => controlUpload(),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
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
                controller: name,
                decoration: InputDecoration(
                  hintText: "Nickname",
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Container(
              width: 250,
              child: Text(lat),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Container(
              width: 250,
              child: Text(long),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          RaisedButton(
            onPressed: getCurrentLocation,
            child: Text(
              'Get Location',
            ),
          )
        ],
      ),
    );
  }

  removeImage() {
    setState(() {
      file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? displayUploadScreen() : displayUploadForm();
  }
}
