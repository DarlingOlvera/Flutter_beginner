import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 7, 34, 39));

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 64, 248, 255),
);

void main() {
  runApp(
    MaterialApp(
      //tema para el modo oscuro
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kDarkColorScheme.onPrimaryContainer,
            foregroundColor: kDarkColorScheme.onPrimary,
          ),
        ),
      ),
      //tema para el modo normal
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
      //controlar cuando se usa cada tema en la app
      //themeMode: ThemeMode.system, está por default
      home: const Expenses(),
    ),
  );
}
