import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: NewsWebView(),
  ));
}

class NewsWebView extends StatefulWidget {
  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  var _url = 'https://www.google.com/search?q=climate+change&tbm=nws';

  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        title: Text(
          'Climate Change News',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.green,
          ),
        ),
      ),
      body: WebView(
        initialUrl: _url,
      ),
    );
  }
}
