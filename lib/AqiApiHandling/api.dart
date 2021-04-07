import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  var response;
  var jsonResponse;
  var url;
  var name;
  var sname;
  List colors = [
    Colors.red,
    Colors.pink,
    Colors.deepPurple,
    Colors.blue,
    Colors.blueAccent,
    Colors.indigo,
    Colors.redAccent,
  ];
  Random random = new Random();

  Future<List<Data>> _getData() async {
    var apiKey = 'e951f105-9114-4774-a578-518d03b76651';
    var cities = [
      'Delhi',
      'Mumbai',
      'Kolkata',
      'Chennai',
      'Lucknow',
      'Ahmedabad'
    ];
    var states = [
      'Delhi',
      'Maharashtra',
      'West-Bengal',
      'Tamil-Nadu',
      'Uttar-Pradesh',
      'Gujarat'
    ];
    var data;
    List<Data> myData = [];
    for (var i = 0; i <= 5; i++) {
      url = 'http://api.airvisual.com/v2/city?city=' +
          cities[i] +
          '&state=' +
          states[i] +
          '&country=india&key=' +
          apiKey;
      response = await http.get(url);
      if (response.statusCode == 200) {
        jsonResponse = convert.jsonDecode(response.body);
        data = jsonResponse["data"]["current"]["pollution"]["aqius"].toString();
        name = jsonResponse["data"]["city"];
        sname = jsonResponse["data"]["state"];
        Data presentData = Data(name, sname, data);
        myData.add(presentData);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
    print(myData);
    return (myData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: SizedBox(
                height: 75,
                width: 75,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.green,
                  strokeWidth: 7,
                ),
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  // color: colors[random.nextInt(7)],
                  color: Colors.grey[800],
                  child: Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.data[index].cityName,
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.green,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            Text(
                              snapshot.data[index].stateName,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                        Text(
                          snapshot.data[index].aqi,
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class Data {
  final String cityName;
  final String stateName;
  final String aqi;

  Data(this.cityName, this.stateName, this.aqi);
}
