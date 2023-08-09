import 'package:flutter/material.dart';
import 'package:quiz_app/start_quiz.dart';

class FirstView extends StatelessWidget {
  const FirstView(this.colorList, {super.key});

  final List<Color> colorList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colorList,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(child: StartQuiz()),
    );
  }
}
