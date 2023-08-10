import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var questionIndex = 0;

  void answerQuestion() {
    //questionIndex = questionIndex + 1;
    //questionIndex += 1;
    setState(() {
      questionIndex++; //solo incrementa de uno en uno
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[questionIndex];

    //another aproach instead of center as a wrapper
    return SizedBox(
      //special value that takes as much space as posible
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.raleway(
                  color: const Color.fromARGB(150, 255, 255, 255),
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            //replace old values in the list with new items based on the old ones
            //y como children es una lista que no espera otra lista o iterable como hijo
            //se transforma ese iterable en componentes independientes separados por coma
            // utilizando el spread operator
            ...currentQuestion.getShuffledAnswers().map((item) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: AnswerButton(item, answerQuestion));
            })
          ],
        ),
      ),
    );
  }
}
