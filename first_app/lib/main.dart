import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart';

void main() {
  //MaterialApp is the root widget which helps to set up the app
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer([
          Color.fromARGB(255, 32, 17, 59),
          Color.fromARGB(255, 185, 19, 179),
        ]),
      ),
    ),
  );
}
