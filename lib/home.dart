import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treetracker/about.dart';
import 'package:treetracker/aboutus.dart';
import 'package:treetracker/climatechange.dart';
import 'package:treetracker/help.dart';
import 'package:treetracker/mytrees.dart';
import 'package:treetracker/news.dart';
import 'package:treetracker/temperature.dart';
import 'addtree.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'pollution.dart';

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
    // BackButtonInterceptor.add(myInterceptor);
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {});
    });
  }

  Widget _buildExitDiolog(BuildContext context) {
    return new AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text(
        'Exit',
        style: TextStyle(
          fontFamily: 'Ubuntu',
          color: Colors.green,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Text(
            'Are You Sure You Want to Exit?',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.brown,
                child: Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  exit(0);
                },
                color: Colors.green,
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildHelpDiolog(BuildContext context) {
    return new AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text(
        'Help',
        style: TextStyle(
          fontFamily: 'Ubuntu',
          color: Colors.green,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Image(
            image: AssetImage('assets/images/tree2.png'),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Text(
            'If You have any problems mail to us at treetrackerorg@gmail.com',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.brown,
                child: Text(
                  'Okay',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Clipboard.setData(
                      new ClipboardData(text: "treetrackerorg@gmail.com"));
                  _scaffoldKey.currentState.showSnackBar(
                      new SnackBar(content: new Text('E-Mail Copied')));
                  Navigator.pop(context);
                },
                color: Colors.green,
                child: Text(
                  'Copy EMail',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildUserDiolog(BuildContext context) {
    return new AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text(
        ouruser.displayName,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.green,
          fontFamily: 'Ubuntu',
        ),
      ),
      content: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(6),
          ),
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: 45,
            backgroundImage: NetworkImage(ouruser.photoURL),
          ),
          Padding(
            padding: EdgeInsets.all(6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Auth()),
                  );
                },
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubunutu',
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(6),
          ),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime currentBackPressTime;
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
              strokeWidth: 6,
            ),
          ),
        ),
      );
    }
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          _scaffoldKey.currentState.showSnackBar(
              new SnackBar(content: new Text('Press Back Again to Exit')));
          return Future.value(false);
        }
        exit(0);
      },
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton.extended(
          heroTag: null,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTree()),
            );
          },
          backgroundColor: Colors.grey[800],
          icon: Icon(
            Icons.add_a_photo,
            color: Colors.green,
          ),
          label: Text(
            'New Tree',
            style: TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.green,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(
            'TreeTracker',
            style: TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.green,
            ),
          ),
          backgroundColor: Colors.grey[800],
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.info_circle,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
          actions: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildUserDiolog(context),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipOval(
                  child: Image(
                    image: Image.network(ouruser.photoURL).image,
                  ),
                ),
              ),
            ),
          ],
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyTrees()),
                  );
                },
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
                                fontFamily: 'Ubuntu',
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WeatherApp()),
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
                                    fontFamily: 'Ubuntu',
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
                        MaterialPageRoute(builder: (context) => AqiApp()),
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
                                    fontFamily: 'Ubuntu',
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
              ],
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
                    MaterialPageRoute(builder: (context) => NewsWebView()),
                  );
                },
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
                                fontFamily: 'Ubuntu',
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Card(
                  color: Colors.grey[800],
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25),
                  ),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutUs()),
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
                                'assets/images/goals.jpg',
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
                                // Text(
                                //   'Goals',
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //     fontSize: 25,
                                //     fontFamily: 'Ubuntu',
                                //     fontWeight: FontWeight.bold,
                                //     // backgroundColor: Colors.white24,
                                //     // color: Colors.white,
                                //   ),
                                // ),
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
                        MaterialPageRoute(builder: (context) => Helppage()),
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
                                'assets/images/help.jpg',
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
                                // Text(
                                //   'Help',
                                //   textAlign: TextAlign.right,
                                //   style: TextStyle(
                                //     fontFamily: 'Ubuntu',
                                //     fontSize: 25,
                                //     fontWeight: FontWeight.bold,
                                //     // backgroundColor: Colors.white24,
                                //     // color: Colors.white,
                                //   ),
                                // ),
                                SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClimateChange()),
                  );
                },
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
                                    fontFamily: 'Ubuntu',
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
