import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(
    MaterialApp(
      home: WeatherApp(),
    ),
  );
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  var Temp, minTemp, maxTemp, humid;

  @override
  void initState() {
    super.initState();
    Temp = null;
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
      print(lat);
      print(long);
      long = position.longitude.toString();
    });
  }

  data() async {
    await _getCurrentLocation();
    _getAddressFromLatLng();
    var key = "";
    var url =
        "https://api.openweathermap.org/data/2.5/find?lat=$lat&lon=$long&cnt=1&appid=$key";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var temp = jsonResponse["list"][0]["main"]["temp"] - 273.15;
      var min_temp = jsonResponse["list"][0]["main"]["temp_min"] - 273.15;
      var max_temp = jsonResponse["list"][0]["main"]["temp_max"] - 273.15;
      var humidity = jsonResponse["list"][0]["main"]["humidity"];
      var tempText = temp.toString();
      var minText = min_temp.toString();
      var maxText = max_temp.toString();
      var humidityText = humidity.toString();
      setState(() {
        Temp = tempText;
        minTemp = minText;
        maxTemp = maxText;
        humid = humidityText;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          'Weather of Your City',
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
      body: Temp == null
          ? Center(
              child: SizedBox(
                height: 55,
                width: 55,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.green,
                  strokeWidth: 5,
                ),
              ),
            )
          : ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(30),
                ),
                Container(
                  child: Center(
                    child: Icon(
                      Icons.cloud_outlined,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Container(
                  child: Center(
                    child: Text(
                      Temp + "°C",
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ),
                ),
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
                  child: Center(
                    child: Card(
                      color: Colors.green,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: 300,
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Minimum:   ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                              Text(
                                minTemp + "°C",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Maximum:   ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                              Text(
                                maxTemp + "°C",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Humidity:   ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                              Text(
                                humid + "%",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: 'Ubuntu',
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
