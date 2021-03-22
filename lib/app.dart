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
        theme: Themes.cookieTheme,
        home: Creator(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
