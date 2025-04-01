import 'package:flutter/material.dart';
import 'package:expence_tracker/widgets/expenses.dart';
//import 'package:flutter/services.dart';

//💡 'k' means global varaibles, especially for styles
final kColorScheme = ColorScheme.fromSeed(seedColor: Colors.white);
final kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.black,
  brightness: Brightness.dark,
);

void main() {
  //💡 Used in conjunction with setPreferredOrientations. It has to bo turned on.
  //It has to make sure:
  //1) The Future function from .then is executed, orientation is locked
  //2) Then widget tree is rendered, and app is running
  //WidgetsFlutterBinding.ensureInitialized();

  //💡 prevent system from adjustment different orientations
  //that are not define in the list
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then(
  //   (fun) {

  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: EdgeInsets.all(16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
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
          margin: EdgeInsets.all(16),
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
      //💡 default -> themeMode: ThemeMode.system,
      home: Expenses(),
    ),
  );
}

//   );
// }
