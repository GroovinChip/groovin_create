import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:groovin_create/app.dart';
import 'package:groovin_create/services/user_prefs_service.dart';
import 'package:menubar/menubar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefsService = await UserPrefsService.init();
  /*final menu = Submenu(
    label: 'Preferences',
    children: [
      MenuItem(label: 'Test'),
    ],
  );
  setApplicationMenu([menu]);*/
  runApp(
    GroovinCreateApp(
      prefsService: prefsService,
    ),
  );
  doWhenWindowReady(() {
    final initialSize = Size(700, 500);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.title = 'Groovin Create';
    appWindow.show();
  });
}
