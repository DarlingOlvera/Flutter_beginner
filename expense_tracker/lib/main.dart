import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 7, 34, 39));

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(fontSize: 24),
              titleMedium: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              titleSmall: const TextStyle(fontSize: 14),
            ),
      ),
      home: const Expenses(),
    ),
  );
}
