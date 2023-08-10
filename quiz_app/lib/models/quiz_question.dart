class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    //Es necesario crear una copia de la lista original si no se quiere que esta
    //sea modificada directamente por shuffle

    //.of crea una nueva lista basada en otra lista que se pasa como parametro
    final shuffledList = List.of(answers);
    //.shuffle revuelve la posicion de los valores de la lista que lo use
    shuffledList.shuffle();

    return shuffledList;
  }
}
