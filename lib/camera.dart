import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
      body: Center(
        child: _image == null ? Text("Image is not Loaded") : enableUpload(),
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
}
