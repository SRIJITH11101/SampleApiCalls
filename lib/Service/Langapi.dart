import 'dart:convert';

import 'package:http/http.dart' as http;

class LangApi {
  Map<String, String> fromLang = {};
  Map<String, String> toLang = {};
  List<String> fromL = [];
  List<String> toL = [];

  Future getFromLang() async {
    var uri = 'https://api.babelonia.nl/site/home/source-category-list';
    var url = Uri.parse(uri);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var jsonData = jsonDecode(data);
      List<dynamic> details = jsonData['response'];
      int count = details.length;
      for (var i = 0; i < count; i++) {
        fromL.add(jsonData['response'][i]['name']);
        fromLang[jsonData['response'][i]['name']] =
            jsonData['response'][i]['_id'];
      }
      print(fromL);
      print(fromLang);
    }
    return response.body;
  }

  Future getToLang() async {
    var uri =
        'https://api.babelonia.nl/site/home/target-category-list?id=5fe3539dfcd01b7ed6c35dfb';
    var url = Uri.parse(uri);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var jsonData = jsonDecode(data);
      List<dynamic> details = jsonData['response'];
      int count = details.length;
      for (var i = 0; i < count; i++) {
        toL.add(jsonData['response'][i]['name']);
        toLang[jsonData['response'][i]['name']] =
            jsonData['response'][i]['_id'];
      }
      print(toL);
      print(toLang);
    }
    return response.body;
  }
}
