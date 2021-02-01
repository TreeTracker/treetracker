import 'dart:io';
import 'package:flutter/material.dart';
import 'package:treetracker/AQI%20API%20Handling/aqi.dart';
import 'auth.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      home: AppHomePage(),
    ),
  );
}

class AppHomePage extends StatefulWidget {
  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  // User _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        // _user = user;
      });
    });
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var ouruser = FirebaseAuth.instance.currentUser;
    while (ouruser == null) {
      return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: SizedBox(
            height: 75,
            width: 75,
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
              strokeWidth: 7,
            ),
          ),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('TreeTracker'),
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.camera_alt_rounded),
              onPressed: () {},
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.grey[900],
            child: ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.green,
                        backgroundImage:
                            NetworkImage(ouruser.photoURL.toString()),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Text(
                        ouruser.displayName,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  tileColor: Colors.grey[800],
                  focusColor: Colors.green,
                  leading: Icon(
                    Icons.help_center_rounded,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Help',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  tileColor: Colors.grey[800],
                  leading: Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  title: Text(
                    'About Us',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  tileColor: Colors.grey[800],
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Log out',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Auth()),
                    );
                  },
                ),
                ListTile(
                  tileColor: Colors.grey[800],
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Exit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    exit(0);
                  },
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              color: Colors.grey[900],
              height: 50,
              child: Greetings(),
            ),
            Card(
              child: Container(
                color: Colors.red[400],
                child: Text("My Trees"),
                height: 300,
              ),
            ),
            Card(
              child: Container(
                color: Colors.blue[400],
                child: Text("AQI"),
                height: 150,
              ),
            ),
            Card(
              child: Container(
                color: Colors.blue[400],
                child: Text("News"),
                height: 150,
              ),
            ),
            Card(
              child: Container(
                color: Colors.orange[300],
                child: Text("Climate Change"),
                height: 150,
              ),
            ),
            //New Cards Here
          ],
        ),
      ),
    );
  }
}

class Greetings extends StatefulWidget {
  @override
  _GreetingsState createState() => _GreetingsState();
}

class _GreetingsState extends State<Greetings> {
  @override
  Widget build(BuildContext context) {
    var hour = DateTime.now().hour;
    var greet;
    // var myIcon = 'Icons.ac_unit';
    if (hour < 12) {
      greet = 'Good morning';
    } else {
      if (hour < 16) {
        greet = 'Good afternoon';
      } else {
        greet = 'Good evening';
      }
    }
    return Row(
      children: <Widget>[
        SizedBox(
          width: 30,
        ),
        GetIcon(),
        SizedBox(
          width: 30,
        ),
        Text(
          greet,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ],
    );
  }
}

class GetIcon extends StatefulWidget {
  @override
  _GetIconState createState() => _GetIconState();
}

class _GetIconState extends State<GetIcon> {
  @override
  Widget build(BuildContext context) {
    var hour = DateTime.now().hour;
    var greet;
    if (hour < 12) {
      return Icon(
        Icons.wb_sunny,
        color: Colors.white,
      );
    } else {
      if (hour < 17) {
        return Icon(
          Icons.wb_cloudy,
          color: Colors.white,
        );
      } else {
        return Icon(
          Icons.bedtime,
          color: Colors.white,
        );
      }
    }
  }
}
