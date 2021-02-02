import 'dart:io';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User _user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _user = user;
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
    return Scaffold(
      body: Container(
        color: Colors.grey[900],
        // child: Text(
        //   'LOL',
        // ),
      ),
      appBar: AppBar(
        title: Text('TreeTracker'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(
              Icons.help_center_rounded,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[600],
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.green,
                      backgroundImage:
                          NetworkImage(ouruser.photoURL.toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(ouruser.displayName),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.local_florist),
                title: Text('My Trees'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text('Climate Change'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.cloud),
                title: Text('AQI'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Aqi()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.language_rounded),
                title: Text('News'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: Text('About Us'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log out'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Auth()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Exit'),
                onTap: () {
                  exit(0);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {},
        label: Text(
          'Add New Tree',
          style: TextStyle(fontSize: 18),
        ),
        icon: Icon(Icons.nature_people),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
