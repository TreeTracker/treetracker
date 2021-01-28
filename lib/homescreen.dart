import 'package:flutter/material.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  final appTitle = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('TreeTracker logo'),
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
              leading: Icon(Icons.chat),
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
