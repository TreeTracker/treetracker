import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

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
  Completer<WebViewController> _controller = Completer<WebViewController>();
  var _url =
      'https://www.google.com/search?q=climate+change&sxsrf=ALeKk023TKv41n3NO1XoBHRlfNmlnYOiBg:1618406510689&source=lnms&tbm=nws&sa=X&ved=2ahUKEwjeu6-J6v3vAhValEsFHXceA0UQ_AUoAXoECAEQAw&biw=1366&bih=668';

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
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
