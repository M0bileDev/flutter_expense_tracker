import 'package:flutter/material.dart';
import 'package:expence_tracker/widgets/expenses.dart';

//💡 'k' means global varaibles, especially for styles
final kColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepOrange);

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
      ),
      home: Expenses(),
    ),
  );
}
