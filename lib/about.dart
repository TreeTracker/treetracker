import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(About());
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,

      title: 'About Us',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static String myVideoId = 'epdKlguk3m4';
  var _url =
      'https://www.ijert.org/research/digital-tracking-for-urban-trees-and-plants-IJERTV10IS040310.pdf';
  var _instaUrl = 'https://instagram.com/tree.tracker';
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void _launchInstaURL() async => await canLaunch(_instaUrl)
      ? await launch(_instaUrl)
      : throw 'Could not launch $_url';
  // the full url: https://www.youtube.com/watch?v=PQSagzssvUQ&ab_channel=NASA
  // it's an interesting video from NASA on Youtube

  // Initiate the Youtube player controller
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: myVideoId,
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        tooltip: 'Follow Us On Instagram',
        onPressed: _launchInstaURL,
        child: Image(
          height: 35,
          width: 35,
          image: AssetImage(
            'assets/images/instagram.png',
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[800],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            tooltip: 'Back',
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'About Us',
            style: TextStyle(color: Colors.green, fontFamily: 'Ubuntu'),
          )),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Container(
            color: Colors.grey[900],
            child: YoutubePlayer(
              controller: _controller,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(50),
          ),
          Center(
            child: Text(
              'Digital Tracker for Urban Trees and Plants',
              textAlign: TextAlign.center,
              // overflower: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Container(
            child: Column(
              children: [
                RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'Read Our Paper',
                    style: TextStyle(
                        fontFamily: 'Ubuntu', color: Colors.grey[900]),
                  ),
                  onPressed: _launchURL,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
