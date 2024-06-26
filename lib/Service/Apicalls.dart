import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCalls {
  Future<dynamic> getdetails() async {
    var uri =
        'https://api.babelonia.nl/site/home/commonsubcategory?language=nl';
    var url = Uri.parse(uri);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      //print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
