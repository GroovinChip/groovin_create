import 'package:flutter/material.dart';
import 'package:groovin_create/services/user_prefs_service.dart';
import 'package:provider/provider.dart';

mixin Provided<T extends StatefulWidget> on State<T> {
  UserPrefsService _prefsService;

  UserPrefsService get prefsService =>
      _prefsService ??= Provider.of<UserPrefsService>(context, listen: false);
}
