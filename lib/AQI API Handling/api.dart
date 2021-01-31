import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';

// void main(List<String> arguments) async {
//   var url = '';
//   var response = await http.get(url);
//   if (response.statusCode == 200) {
//     var jsonResponse = convert.jsonDecode(response.body);
//     print(jsonResponse["data"]["current"]["pollution"]["aqius"]);
//     return;
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }

// class Show extends StatelessWidget {
//   @override
//   Future<void> getData() async {}

//   Widget build(BuildContext context) {
//     getData();
//     print(data);
//     return
//   }
// }

class ShowData extends StatefulWidget {
  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  // var i =1;

  var response;
  var jsonResponse;
  var url;
  var name;
  var sname;

  Future<List<Data>> _getData() async {
    var apiKey = '';
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
    for (var i = 0; i < 5; i++) {
      url = 'http://api.airvisual.com/v2/city?city=' +
          cities[i] +
          '&state=' +
          states[i] +
          '&country=india&key=' +
          apiKey;
      // url =
      //     "http://api.airvisual.com/v2/city?city=mumbai&state=maharashtra&country=india&key=e951f105-9114-4774-a578-518d03b76651";
      response = await http.get(url);
      if (response.statusCode == 200) {
        print('got Response');
        jsonResponse = convert.jsonDecode(response.body);
        print('got JSON');
        data = jsonResponse["data"]["current"]["pollution"]["aqius"].toString();
        name = jsonResponse["data"]["city"];
        sname = jsonResponse["data"]["state"];
        print('got Data');
        Data presentData = Data(name, sname, data);
        print(presentData);
        myData.add(presentData);
        print('got Data2');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
    print(myData);
    return (myData);
  }

// var url = '';
//     for (var i = 0; i < 5; i++) {
//       url = 'http://api.airvisual.com/v2/city?city=' +
//           cities[i] +
//           '&state=' +
//           states[i] +
//           '&country=india&key=' +
//           apiKey;
//       response = await http.get(url);
//       jsonResponse = convert.jsonDecode(response.body);
//       data[i] =
//           jsonResponse["data"]["current"]["pollution"]["aqius"].toString();
//       print(data[i]);
//     }
//     print(data);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text('Loading'),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(snapshot.data[index].cityName),
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
  final String AQI;

  Data(this.cityName, this.stateName, this.AQI);
}

// class Show extends StatelessWidget {
//   var url =
//       'http://api.airvisual.com/v2/city?city=mumbai&state=maharashtra&country=india&key=e951f105-9114-4774-a578-518d03b76651';
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: http.get(url),
//     );
//   }
// }

// class ShowData extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
