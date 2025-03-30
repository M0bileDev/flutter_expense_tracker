import 'package:flutter/material.dart';
import 'package:expence_tracker/widgets/expenses.dart';

//💡 'k' means global varaibles, especially for styles
final kColorScheme = ColorScheme.fromSeed(seedColor: Colors.white);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        //💡 Easiest and recommended way to configure colors
        //for MT, because MT then infer and apply colors to any styles
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primaryContainer,
          foregroundColor: kColorScheme.onPrimaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.all(8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: kColorScheme.onSecondaryContainer,
              ),
            ),
      ),
      home: Expenses(),
    ),
  );
}
