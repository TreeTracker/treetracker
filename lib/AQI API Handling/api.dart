import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void aqiOfCities(List<String> arguments) async {
  var url = '';
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
