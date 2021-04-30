import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

void main() {
  runApp(AboutUs());
}

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            tooltip: 'Back',
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Our Goal',
            style: TextStyle(
              color: Colors.green,
              fontFamily: 'Ubuntu',
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[800],
        ),
        body: ListView(
          children: [
            // Image(
            //   image: AssetImage('assets/images/tree2.png'),
            // ),
            Container(
              child: Card(
                child: ListTile(
                  tileColor: Colors.grey[800],
                  subtitle: Text(
                    "As deforestation has ramped up, Earth’s climate has changed significantly. Warmer, more adverse climate conditions are creating more difficult growing conditions for forest ecosystems.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
            ),
            Image(
              image: AssetImage('assets/images/aboutpic.jpg'),
            ),
            Container(
              child: Card(
                child: ListTile(
                  tileColor: Colors.grey[800],
                  title: Text(
                    "The Problem",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 25,
                      color: Colors.green,
                    ),
                  ),
                  subtitle: Text(
                    "In the modern era, we lack a connection with trees and nature in general. One billion hectares of trees cut down in just 40 years, that's the entire size of Europe. Following the current upwards trend of deforestation, half of all forests will be gone by 2100.Trees play the most crucial role in carbon sequestration besides oceans. This project aims to form a connection with trees making us liable for their growth and hence have a personalized hand in reducing climate change.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
            ),
            Image(
              image: AssetImage('assets/images/solutions.jpg'),
            ),
            Container(
              child: Card(
                child: ListTile(
                  tileColor: Colors.grey[800],
                  title: Text(
                    "Our Solution",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 25,
                      color: Colors.green,
                    ),
                  ),
                  subtitle: Text(
                    "This is an app-based project. Which will be able to capture images of trees using the phone’s camera. After capturing the image, the user will be able to give that tree a pet or nickname and then the app will store that in Firebase. Along with that, it will also store the location or the PlusCode of the area where the image has been captured. User has to update the picture of the tree to track the growth of the trees. This way the user will be given updates about the trees and the importance of forests, updates on climate change, etc. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Card(
                child: ListTile(
                  tileColor: Colors.grey[800],
                  title: Text(
                    "Purpose",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 25,
                      color: Colors.green,
                    ),
                  ),
                  subtitle: Text(
                    "This app’s main purpose is to make humans(users) more aware of modern-day problems like climate change, deforestation, etc., and bring them one step closer to nature.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
