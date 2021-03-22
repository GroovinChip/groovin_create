import 'package:flutter/material.dart';

class Themes {
  static ThemeData get cookieTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.brown,
      accentColor: Colors.brown.shade300,
      canvasColor: Color.lerp(Colors.brown.shade800, Colors.black, .5),
      textTheme: TextTheme(
        headline5: TextStyle(
          color: Colors.white,
        ),
        subtitle1: TextStyle(
          color: Colors.white,
        ),
        subtitle2: TextStyle(
          color: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.brown.shade800,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.brown.shade200,
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Colors.brown.shade200,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          //shape: BeveledRectangleBorder(),
          //padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)
          visualDensity: VisualDensity.comfortable,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialBrown(),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}

/// A MaterialStateColor used for this app's CheckboxThemeData fillColor
class MaterialBrown extends MaterialStateColor {
  const MaterialBrown() : super(_defaultColor);

  static const int _defaultColor = 0xFF5D4037;

  @override
  Color resolve(Set<MaterialState> states) {
    return const Color(_defaultColor);
  }
}
