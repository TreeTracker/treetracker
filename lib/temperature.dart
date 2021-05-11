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
      var intTemp = temp.toInt();
      var tempText = intTemp.toString();
      setState(() {
        Temp = tempText;
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
                  padding: EdgeInsets.all(100),
                ),
                Container(
                  child: Center(
                    child: Text(
                      _currentAddress,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 30,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
