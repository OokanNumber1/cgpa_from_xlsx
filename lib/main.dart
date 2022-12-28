import 'package:cgpa_from_xlsx/injector.dart';
import 'package:cgpa_from_xlsx/src/layers/presentation/screens/info_screen.dart';
import 'package:flutter/material.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CGPA from Spreadsheet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Andika",
      ),
      home: const InfoScreen(),
    );
  }
}
