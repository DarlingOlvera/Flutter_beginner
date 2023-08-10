import 'package:flutter/material.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/start_quiz.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  //se pueden almacenar widgets en variables, ya que al final los widgets también son objetos
  //el signo de interrogación es similar al uso que tiene en javascript, en este caso
  //es porque no es seguro que el widget esté listo apenas inicie la función y esté iniciado en null

  /*  Widget? activeScreen;

  @override
  void initState() {
    //general initialization work
    activeScreen = StartQuiz(switchScreen);
    super.initState();
  } */

  //otra forma de abordar el conditional rendering de arriba sin hacer uso de initState()
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(context) {
    //diferente aproach que el ternario
    Widget screenWidget = StartQuiz(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = const QuestionsScreen();
    }

    return MaterialApp(
        home: Scaffold(
            body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 202, 15, 90),
            Color.fromARGB(255, 84, 20, 149)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        /* child: activeScreen == 'start-screen'
            ? StartQuiz(switchScreen)
            : const QuestionsScreen(), */
        child: screenWidget,
      ),
    )));
  }
}
