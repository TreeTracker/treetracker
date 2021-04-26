//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: Aqii(),
  ));
}

class Aqii extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AqiState();
  }
}

class _AqiState extends State<Aqii> {
  var c_name;
  var s_name;
  var aqi;
  var results;
  String city = "Mumbai";
  String state = "Maharashtra";
  var api = 'e951f105-9114-4774-a578-518d03b76651';
  String errorMessage;
  String input1;
  String input2;

  Future getAqi(urls) async {
    var url = 'http://api.airvisual.com/v2/city?city=' +
        city +
        '&state=' +
        state +
        '&country=india&key=' +
        api;
    http.Response response = await http.get(url);
    results = jsonDecode(response.body);

    try {
      setState(() {
        this.aqi = results["data"]["current"]["pollution"]["aqius"].toString();
        this.c_name = results["data"]["city"];
        this.s_name = results["data"]["state"];
      });
    } catch (exception) {
      setState(() {
        // errorMessage = "Sorry, incorrect data! try again ";
      });
    }

    if (urls == url) {
      http.Response response = await http.get(url);
      results = jsonDecode(response.body);
    } else {
      http.Response response = await http.get(urls);
      results = jsonDecode(response.body);
    }

    try {
      setState(() {
        this.aqi = results["data"]["current"]["pollution"]["aqius"].toString();
        this.c_name = results["data"]["city"];
        this.s_name = results["data"]["state"];
      });
    } catch (exception) {
      setState(() {
        // errorMessage =
        // "Sorry, we don't have data about this city. Try another one.";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getAqi(urls);
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pop(); // Do some stuff.
    return true;
  }

  var urlc;
  var urls;

  void onTextFieldSubmitted1(input1) async {
    // city = input1;
    urlc = 'http://api.airvisual.com/v2/city?city=' + input1;
  }

  void onTextFieldSubmitted2(input2) async {
    // state = input2;
    urls = urlc + '&state=' + input2 + '&country=india&key=' + api;
    await getAqi(urls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.grey[800],
        title: Text(
          'AQI',
          style: TextStyle(
            color: Colors.green,
            fontFamily: 'Ubuntu',
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            // height: MediaQuery.of(context).size.height / 1,
            // width: MediaQuery.of(context).size.width,
            // color: Colors.red,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    c_name != null ? c_name.toString() : "loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  s_name != null ? s_name.toString() : "loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    aqi != null ? aqi.toString() : "loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                TextField(
                  onSubmitted: (input1) {
                    onTextFieldSubmitted1(input1);
                  },
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  decoration: InputDecoration(
                    hintText: 'Enter City',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0, left: 32.0),
                  child: Text(errorMessage != null ? errorMessage : " ",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0)),
                ),
                TextField(
                  onSubmitted: (input2) {
                    onTextFieldSubmitted2(input2);
                  },
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  decoration: InputDecoration(
                    hintText: 'Enter state',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0, left: 32.0),
                  child: Text(errorMessage != null ? errorMessage : " ",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
