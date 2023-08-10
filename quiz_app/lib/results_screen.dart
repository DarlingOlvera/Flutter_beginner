import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers});

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
    return SizedBox(
      width: double.infinity,
      child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('You answered X out of Y questions correctly'),
              const SizedBox(
                height: 40,
              ),
              const Text('List of answers and questions'),
              const SizedBox(
                height: 40,
              ),
              TextButton(onPressed: () {}, child: const Text('restart quiz'))
            ],
          )),
    );
  }
}
