import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_02/Service/Langapi.dart';

class SecondDisplayScreen extends StatefulWidget {
  const SecondDisplayScreen({super.key});

  @override
  State<SecondDisplayScreen> createState() => _SecondDisplayScreenState();
}

class _SecondDisplayScreenState extends State<SecondDisplayScreen> {
  LangApi lng = LangApi();
  String? selectedFromLang = "Albanees";
  String? selectedToLang = "Chinees (Kantonees)";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLang();
  }

  void getLang() async {
    await lng.getFromLang();
    await lng.getToLang();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                      child: Expanded(
                        child: DropdownButton(
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
                              selectedFromLang = newValue;
                              print(selectedFromLang);
                            });
                          },
                        ),
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
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
