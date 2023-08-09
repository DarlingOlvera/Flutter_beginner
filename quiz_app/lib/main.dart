import 'package:flutter/material.dart';
import 'package:quiz_app/first_view.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
        body: FirstView([
      Color.fromARGB(255, 32, 17, 59),
      Color.fromARGB(255, 185, 19, 179),
    ])),
  ));
}
