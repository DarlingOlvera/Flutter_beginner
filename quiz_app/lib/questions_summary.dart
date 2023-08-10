import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: summaryData.map((element) {
        return Row(children: [
          Text(((element['question-index'] as int) + 1).toString()),
        ]);
      }).toList(),
    );
  }
}
