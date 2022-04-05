import 'package:flutter/material.dart';
import 'package:phonebook/pages/home.dart';

void main() {
  runApp(const PhonebookApp());
}

class PhonebookApp extends StatefulWidget {
  const PhonebookApp({Key? key}) : super(key: key);

  @override
  _PhonebookAppState createState() => _PhonebookAppState();
}

class _PhonebookAppState extends State<PhonebookApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
