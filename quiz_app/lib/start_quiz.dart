import 'package:flutter/material.dart';

class StartQuiz extends StatefulWidget {
  const StartQuiz({super.key});

  @override
  State<StartQuiz> createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  //Methods
  void startQuiz() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/quiz-logo.png', width: 250),
        const SizedBox(
          height: 12.0,
        ),
        const Text(
          'Learn flutter the fun way!',
          style: TextStyle(
            fontSize: 25.0,
            color: Color.fromARGB(255, 249, 204, 245),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        ElevatedButton(
          onPressed: startQuiz,
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 40),
              backgroundColor: Colors.amberAccent[400],
              disabledBackgroundColor: Colors.amberAccent[300],
              textStyle: const TextStyle(fontSize: 22)),
          child: const Center(
            child: Text('Start Quiz'),
          ),
        )
      ],
    );
  }
}
