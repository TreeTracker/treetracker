import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

void main() {
  runApp(Helppage());
}

class Helppage extends StatefulWidget {
  @override
  _HelppageState createState() => _HelppageState();
}

class _HelppageState extends State<Helppage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
        key: _scaffoldKey,
        backgroundColor: Colors.grey[900],
        body: Stack(children: [
          Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(65, 50, 65, 400),
                child: Image(
                  image: AssetImage('assets/images/tree2.png'),
                )),
          ),
          Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 400.0),
                child: RaisedButton(
                  child: Text('Copy To Clipboard'),
                  color: Colors.green,
                  onPressed: () {
                    Clipboard.setData(
                        new ClipboardData(text: "treetrackerorg@gmail.com"));
                    _scaffoldKey.currentState.showSnackBar(
                        new SnackBar(content: new Text('COPIED')));
                  },
                ),
              ),
            ),
          ),
          Container(
              child: Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'If you have any queries mail to us at treetrackerorg@gmail.com ',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          )),
        ]),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            tooltip: 'Back',
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Help',
            style: TextStyle(
              color: Colors.green,
              fontFamily: 'Ubuntu',
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[800],
        ),
      ),
    );
  }
}
