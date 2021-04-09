import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    title: "Camera App",
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  File _image;
  Position _currentPosition;

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      body: ListView(
        children: [
          Container(
            child: _image == null
                ? Text("Image is not Loaded",
                    style: TextStyle(color: Colors.black, fontSize: 20))
                : enableUpload(),
          ),
          TextField(
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          ListTile(
            leading: Icon(
              Icons.person_pin_circle,
              color: Colors.black,
              size: 36,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          if (_currentPosition != null)
            Text(
              "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          FlatButton(
            onPressed: () {
              _getCurrentLocation();
              print(_getCurrentLocation());
            },
            child: Text("Find Location"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Increment',
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: [
          Image.file(_image, height: 300.0, width: 300.0),
          RaisedButton(
              elevation: 7.0,
              child: Text("Upload"),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                Reference ref =
                    FirebaseStorage.instance.ref().child('harsh.jpg');
                ref.putFile(_image);

                return "";
              }),
        ],
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
