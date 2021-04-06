import 'dart:io';
import 'package:flutter/material.dart';
import 'AqiApiHandling/aqi.dart';
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
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {});
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add_a_photo_rounded,
          ),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(
            'TreeTracker',
            style: TextStyle(
              fontFamily: 'Ubuntu',
            ),
          ),
          backgroundColor: Colors.green,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.help_outline_rounded),
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
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.grey[900],
              alignment: Alignment.center,
              height: 50,
              child: Greetings(),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(19),
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/map.jpg',
                            width: 5000,
                            height: 5000,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'My Trees',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.white24,
                                // color: Colors.white,
                              ),
                            ),
                            SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Card(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25),
                  ),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {},
                    child: Container(
                      width: (MediaQuery.of(context).size.width / 2) - 35,
                      height: 200,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                'assets/images/weather.jpg',
                                width: 5000,
                                height: 5000,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Weather',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    // backgroundColor: Colors.white24,
                                    // color: Colors.white,
                                  ),
                                ),
                                SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25),
                  ),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Aqi()),
                      );
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width / 2) - 35,
                      height: 200,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                'assets/images/aqi.jpg',
                                width: 5000,
                                height: 5000,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //   width: 100,
                                // ),
                                Text(
                                  'AQI',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    // backgroundColor: Colors.white24,
                                    // color: Colors.white,
                                  ),
                                ),
                                SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // child: Text(
                      //   'AQI',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontSize: 25,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
            Card(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25),
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/news.jpg',
                            width: 5000,
                            height: 5000,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'News',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                // backgroundColor: Colors.white24,
                                // color: Colors.white,
                              ),
                            ),
                            SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // child: Text(
                  //   'News',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 25,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25),
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/climate4.jpeg',
                            width: 5000,
                            height: 5000,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Climate Change',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    // backgroundColor: Colors.white24,
                                    // color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // child: Text(
                  //   'Climate Change',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 25,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GetIcon(),
        SizedBox(
          width: 10,
        ),
        Text(
          greet,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontFamily: 'Ubuntu',
          ),
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
