import 'package:flutter/material.dart';
import 'package:treetracker/AQI%20API%20Handling/aqi.dart';

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
  Widget build(BuildContext context) {
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
            color: Colors.grey[600],
            child: ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      // CircleAvatar(
                      //   radius: 40,
                      //   backgroundColor: Colors.green,
                      //   backgroundImage:
                      //       NetworkImage(ouruser.photoURL.toString()),
                      // ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      // Text(ouruser.displayName),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.help_center_rounded),
                  title: Text('Help'),
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Auth()),
                    // );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Exit'),
                  onTap: () {
                    // exit(0);
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
