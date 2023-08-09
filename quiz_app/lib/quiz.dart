import 'package:flutter/material.dart';
import 'package:quiz_app/first_view.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
          body: FirstView([
        Color.fromARGB(255, 32, 17, 59),
        Color.fromARGB(255, 185, 19, 179),
      ])),
    );
  }
}
