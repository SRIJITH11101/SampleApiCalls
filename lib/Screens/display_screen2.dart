import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_02/Constants/constant.dart';
import 'package:task_02/Service/Langapi.dart';

class SecondDisplayScreen extends StatefulWidget {
  const SecondDisplayScreen({super.key});

  @override
  State<SecondDisplayScreen> createState() => _SecondDisplayScreenState();
}

class _SecondDisplayScreenState extends State<SecondDisplayScreen> {
  LangApi lng = LangApi();
  String? selectedFromLang;
  String? selectedToLang;
  int showList = 1;
  bool fromLangFetched = false;
  bool toLangFetched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLang();
  }

  void getLang() async {
    await lng.getFromLang(context);
    //await lng.getToLang(selectedFromLang!);
    //selectedToLang = lng.toL[0];

    setState(() {
      fromLangFetched = true;
      showList = 0;
    });
  }

  void getToLang() async {
    lng.toL = [];
    selectedToLang = null;
    print(lng.toL);
    String selectedFromLangId = lng.fromLang[selectedFromLang]!;
    await lng.getToLang(context, selectedFromLangId);
    //selectedToLang = lng.toL[0];
    setState(() {
      toLangFetched = true;
      showList = 0;
    });
  }

  void getCategory() async {
    lng.slug.clear();
    lng.comSlug.clear();
    String selectedFromLangId = lng.fromLang[selectedFromLang]!;
    String selectedToLangId = lng.toLang[selectedToLang]!;
    await lng.getSlug(context, selectedFromLangId, selectedToLangId);
    setState(() {
      if (lng.id.isEmpty) {
        showList = 3;
      } else {
        showList = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Language Display',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Select From Language'),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: DropdownButton(
                          hint: Text('Select From Language'),
                          isExpanded: true,
                          // Initial Value
                          value: selectedFromLang,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          // Array list of items
                          items: lng.fromL.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),

                          onChanged: (String? newValue) {
                            setState(() {
                              //print(newValue);
                              toLangFetched = false;
                              showList = 1;
                              selectedFromLang = newValue;

                              getToLang();
                              print(selectedFromLang);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Select To Language'),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: DropdownButton(
                          hint: Text('Select To Language'),
                          isExpanded: true,
                          // Initial Value
                          value: selectedToLang,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          // Array list of items
                          items: lng.toL.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),

                          onChanged: (String? newValue) {
                            setState(() {
                              //print(newValue);
                              selectedToLang = newValue;
                              print(selectedToLang);
                              lng.icon.clear();
                              lng.name.clear();
                              lng.id.clear();
                              showList = 1;
                              getCategory();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // TextButton(
              //   onPressed: () {
              //     setState(() {
              //       lng.icon.clear();
              //       lng.name.clear();
              //       lng.id.clear();
              //       showList = 1;
              //       getCategory();
              //     });
              //   },
              //   child: Text('Fetch the Sub-Category'),
              // ),

              showList == 1
                  ? CircularProgressIndicator()
                  : showList == 2
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: lng.finalCount,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: SizedBox(
                                  height: 500,
                                  width: 50,
                                  child: Image.network(
                                      'https://angulars.babelonia.nl/${lng.icon[index]}')),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Text('Id : ${id[index]}'),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        lng.name[index],
                                        style: bStyle,
                                      )),
                                ],
                              ),
                            );
                          },
                        )
                      : showList == 3
                          ? Text(
                              'No data Available',
                              style: TextStyle(fontSize: 15),
                            )
                          : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
