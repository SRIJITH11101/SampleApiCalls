import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_02/Service/Apicalls.dart';
import 'package:task_02/Widgets/snackbar.dart';

class LangApi {
  ApiCalls apicls = ApiCalls();
  Map<String, String> fromLang = {};
  Map<String, String> toLang = {};
  List<String> fromL = [];
  List<String> toL = [];
  List<String> slug = [];
  List<String> comSlug = [];
  List<String> id = [];
  List<String> icon = [];
  List<String> name = [];
  int finalCount = 0;

  Future getFromLang(BuildContext context) async {
    var uri = 'https://api.babelonia.nl/site/home/source-category-list';
    var url = Uri.parse(uri);
    try {
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
    } catch (e) {
      showsSnackbar(context: context, content: e.toString());
    }
  }

  Future getToLang(BuildContext context, String fromLang) async {
    var uri =
        'https://api.babelonia.nl/site/home/target-category-list?id=${fromLang}';
    var url = Uri.parse(uri);

    try {
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
    } catch (e) {
      showsSnackbar(context: context, content: e.toString());
    }
  }

  Future getSlug(BuildContext context, String fromLang, String toLang) async {
    var uri =
        'https://api.babelonia.nl/site/home/sub-category-list?langone=${fromLang}&langtwo=${toLang}';
    var url = Uri.parse(uri);
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = response.body;
        var jsonData = jsonDecode(data);
        var comJsonData = await apicls.getdetails();
        List<dynamic> comDetails = comJsonData['response'];
        List<dynamic> details = jsonData['response'];
        int count = details.length;
        for (var i = 0; i < count; i++) {
          slug.add(jsonData['response'][i]['slug']);
        }
        print(slug);
        int comCount = comDetails.length;
        for (var i = 0; i < comCount; i++) {
          comSlug.add(comJsonData['response'][i]['slug']);
        }
        print(comSlug);
        for (var i = 0; i < comCount; i++) {
          for (var j = 0; j < count; j++) {
            if (slug[j].contains(comSlug[i])) {
              id.add(comJsonData['response'][i]['_id']);
              icon.add(comJsonData['response'][i]['icon']);
              name.add(comJsonData['response'][i]['name']);
            }
          }
        }
        finalCount = id.length;
        print(id);
      }
      return response.body;
    } catch (e) {
      showsSnackbar(context: context, content: e.toString());
    }
  }
}
