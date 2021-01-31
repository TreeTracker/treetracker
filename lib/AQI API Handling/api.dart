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

class Show extends StatelessWidget {
  @override
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
  var data = [];
  // var i =1;
  var apiKey = 'e951f105-9114-4774-a578-518d03b76651';
  var response;
  var jsonResponse;
  Future<void> getData() async {
    var url = '';
    for (var i = 0; i < 5; i++) {
      url = 'http://api.airvisual.com/v2/city?city=' +
          cities[i] +
          '&state=' +
          states[i] +
          '&country=india&key=' +
          apiKey;
      response = await http.get(url);
      jsonResponse = convert.jsonDecode(response.body);
      data[i] = jsonResponse["data"]["current"]["pollution"]["aqius"];
    }
  }

  Widget build(BuildContext context) {
    getData();
    return ListView(
      children: [],
    );
  }
}
