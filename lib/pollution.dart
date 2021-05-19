import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

main(List<String> args) {
  runApp(
    MaterialApp(
      home: AqiApp(),
    ),
  );
}

class AqiApp extends StatefulWidget {
  @override
  _AqiAppState createState() => _AqiAppState();
}

var response;
var Aqi, Pm, Status;
var status;

class _AqiAppState extends State<AqiApp> {
  void initState() {
    super.initState();
    Aqi = null;
    data();
  }

  var _currentCords;
  String _currentAddress = "";
  String lat = "";
  String long = "";

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentCords.latitude, _currentCords.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentCords = position;
      lat = position.latitude.toString();
      long = position.longitude.toString();
      print(lat);
      print(long);
    });
  }

  data() async {
    await _getCurrentLocation();
    _getAddressFromLatLng();
    var key = "";
    var url =
        "https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$long&appid=$key";
    try {
      var response = await http.get(url);
    } catch (e) {
      setState(() {
        Aqi = 500;
      });
    }
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var aqiInt = jsonResponse["list"][0]["main"]["aqi"];
      // var aqiInt = int.parse(aqi);
      var pm2_55 = jsonResponse["list"][0]["components"]["pm2_5"];
      var pm2_5 = pm2_55.toString();
      print(aqiInt);
      print(pm2_5);
      if (aqiInt == 1) {
        status = "Good";
      } else {
        if (aqiInt == 2) {
          status = "Fair";
        } else {
          if (aqiInt == 3) {
            status = "Moderate";
          } else {
            if (aqiInt == 4) {
              status = "Poor";
            } else {
              status = "Very Poor";
            }
          }
        }
      }
      setState(() {
        Aqi = aqiInt;
        Pm = pm2_5;
        Status = status;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
        Aqi = 500;
      });
    }
  }

  void _openLink() async {
    var _mainUrl = "https://en.wikipedia.org/wiki/Air_quality_index";
    if (await canLaunch(_mainUrl)) {
      await launch(_mainUrl);
    } else {
      throw 'Could not launch $_mainUrl';
    }
  }

  void _openReport() async {
    var _mainUrl = "https://github.com/TreeTracker/treetracker/issues";
    if (await canLaunch(_mainUrl)) {
      await launch(_mainUrl);
    } else {
      throw 'Could not launch $_mainUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          'AQI of Your City',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            color: Colors.green,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[900],
      body: Aqi == null
          ? Center(
              child: SizedBox(
                height: 55,
                width: 55,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
            )
          : Aqi == 500
              ? Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sync_problem,
                          color: Colors.white,
                          size: 100,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Oops!!! There was some Error. Please Try again Later',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        RaisedButton(
                          onPressed: () {
                            _openReport();
                          },
                          child: Text('Report'),
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                )
              : ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    Container(
                      child: Card(
                        color: Colors.grey[800],
                        child: ListTile(
                          leading: Icon(
                            Icons.location_city_rounded,
                            color: Colors.white,
                          ),
                          title: Text(
                            _currentAddress,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 19,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    Container(
                      child: Card(
                        color: Aqi == 1
                            ? Colors.green
                            : Aqi == 2
                                ? Colors.green[800]
                                : Aqi == 3
                                    ? Colors.orangeAccent
                                    : Aqi == 4
                                        ? Colors.orange
                                        : Colors.red,
                        child: ListTile(
                          leading: Icon(
                            Icons.api_rounded,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Aqi Rating:  ' + Status,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 19,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    Container(
                      child: Card(
                        color: Aqi == 1
                            ? Colors.green
                            : Aqi == 2
                                ? Colors.green[800]
                                : Aqi == 3
                                    ? Colors.orangeAccent
                                    : Aqi == 4
                                        ? Colors.orange
                                        : Colors.red,
                        child: ListTile(
                          leading: Icon(
                            Icons.add_to_queue_outlined,
                            color: Colors.white,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              ' Сoncentration of PM2.5 (Fine particles matter):  ' +
                                  Pm,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(40),
                    ),
                    Container(
                      child: Center(
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            _openLink();
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.help,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Text(
                                  'Know more About AQI',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}
