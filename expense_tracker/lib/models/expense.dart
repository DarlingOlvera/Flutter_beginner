//model of an expense
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuid = Uuid();
final formatter = DateFormat.yMd();

//enum es una keybord para crear custom types en dart
//traducción: leisure = ocio
//lo que se encuentra dentro de las llaves son los valores soportados por el tipo categoría
enum Category { food, leisure, home, suscriptions, others }

const categoryIcons = {
  Category.food: Icons.fastfood_rounded,
  Category.leisure: Icons.casino_rounded,
  Category.home: Icons.home_rounded,
  Category.suscriptions: Icons.play_arrow_rounded,
  Category.others: Icons.monetization_on
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //como computed property
  String get formattedDate {
    return formatter.format(date);
  }
}
