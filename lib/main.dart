import 'package:flutter/material.dart';
import 'package:task_02/Constants/constant.dart';
import 'package:task_02/Screens/display_screen.dart';
import 'package:task_02/Screens/display_screen2.dart';
import 'package:task_02/Service/Langapi.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Screen'),
        ),
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return TextButton(
                onPressed: () {
                  // LangApi().getFromLang();
                  // LangApi().getToLang();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondDisplayScreen()),
                  );
                },
                child: const Text(
                  'Click here for Fetching Details',
                  style: bStyle,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
