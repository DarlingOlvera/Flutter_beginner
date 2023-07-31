import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  //text es la variable/parametro que se desea recibir y usar en la clase
  const StyledText(this.text, {super.key});

  //declaracion de la variable, debe tener el mismo nombre que en el constructor
  //si se usa el this. para ligar ambas cosas
  //importante tambien declarar el tipo de la variable
  final String text;

  @override
  Widget build(context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 25.0,
        color: Colors.white,
      ),
    );
  }
}
