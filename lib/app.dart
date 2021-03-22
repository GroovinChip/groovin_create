import 'package:flutter/material.dart';
import 'package:groovin_create/pages/creator.dart';
import 'package:groovin_create/services/user_prefs_service.dart';
import 'package:groovin_create/theme/theme.dart';
import 'package:provider/provider.dart';

class GroovinCreateApp extends StatelessWidget {
  const GroovinCreateApp({
    Key? key,
    required this.prefsService,
  }) : super(key: key);

  final UserPrefsService prefsService;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserPrefsService>.value(value: prefsService),
      ],
      child: MaterialApp(
        title: 'Groovin Create',
        theme: ThemeData(
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
        ),
        home: Creator(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
