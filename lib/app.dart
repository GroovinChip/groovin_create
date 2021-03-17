import 'package:flutter/material.dart';
import 'package:groovin_create/creator.dart';

class GroovinCreateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Groovin Create',
      theme: ThemeData(
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Creator(),
      debugShowCheckedModeBanner: false,
    );
  }
}
