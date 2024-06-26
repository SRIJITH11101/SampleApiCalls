import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_02/Constants/constant.dart';
import 'package:task_02/Service/Apicalls.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  ApiCalls calls = ApiCalls();
  List<String> id = [];
  List<String> icon = [];
  List<String> name = [];
  List<dynamic> details = [];
  int count = 0;
  bool waiting = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  void getDetails() async {
    dynamic data = await calls.getdetails();
    print(data);
    details = data['response'];
    count = details.length;
    for (var i = 0; i < details.length; i++) {
      id.add(data['response'][i]['_id']);
      icon.add(data['response'][i]['icon']);
      name.add(data['response'][i]['name']);
      setState(() {
        waiting = false;
      });
    }
    //id.add(data['response'][0]['_id']);
    // print(details);
    // print(details.length);
    // print(id);
    // print(icon);
    // print(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Display Screen')),
      ),
      body: Center(
          child: waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: SizedBox(
                          height: 500,
                          width: 50,
                          child: Image.network(
                              'https://angulars.babelonia.nl/${icon[index]}')),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Text('Id : ${id[index]}'),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                '${name[index]}',
                                style: bStyle,
                              )),
                        ],
                      ),
                    );
                  },
                )),
    );
  }
}
