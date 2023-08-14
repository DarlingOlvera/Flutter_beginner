import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.onRestart});

  final void Function() onRestart;
  final List<String> chosenAnswers;

  //Methods

  //Map is a data-structure that maps values to keys
  List<Map<String, Object>> getData() {
    final List<Map<String, Object>> data = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      data.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      }); //Map<String, Object> = {key: value} where {} is dart sintax to create a Map
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getData();
    final totalQuestions = questions.length;
    //where es como la función filter de los arreglos en javascript
    //al igual que esa devuelve un nuevo iterable que es similar a una lista, con
    //los valores que cumplen la condición del filtro
    final correctQuestions = summaryData.where((element) {
      return element['user_answer'] == element['correct_answer'];
    }).length;
    return SizedBox(
      width: double.infinity,
      child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You answered $correctQuestions out of $totalQuestions questions correctly!',
                style: GoogleFonts.raleway(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(190, 249, 204, 245),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              QuestionsSummary(summaryData),
              const SizedBox(
                height: 40,
              ),
              TextButton.icon(
                  onPressed: onRestart,
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Restart Quiz'))
            ],
          )),
    );
  }
}
