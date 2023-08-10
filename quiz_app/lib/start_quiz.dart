import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartQuiz extends StatelessWidget {
  const StartQuiz(this.initQuiz, {super.key});

  final void Function() initQuiz;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/quiz-logo.png',
            width: 250,
            color: const Color.fromARGB(
                100, 255, 255, 255) //el primer valor es la opacidad
            ),
        const SizedBox(
          height: 40.0,
        ),
        Text(
          'Learn flutter the fun way!',
          style: GoogleFonts.raleway(
            fontSize: 22.0,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 249, 204, 245),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        ElevatedButton.icon(
            onPressed: initQuiz,
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 40),
                backgroundColor: Colors.amberAccent[400],
                textStyle: const TextStyle(fontSize: 18)),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Start Quiz'))
      ],
    );
  }
}
