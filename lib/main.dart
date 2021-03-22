import 'dart:async';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:groovin_create/app.dart';
import 'package:groovin_create/services/user_prefs_service.dart';
import 'package:sentry/sentry.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() async {
    await Sentry.init(
      (options) {
        options.dsn =
            'https://15ecc0758f414f0a874ab9798dd03d67@o346291.ingest.sentry.io/5685508';
      },
      appRunner: () async {
        final prefsService = await UserPrefsService.init();
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
      },
    );
  }, (exception, stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}
