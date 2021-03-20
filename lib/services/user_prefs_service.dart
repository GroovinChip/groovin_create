import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefsService {
  UserPrefsService._();

  static Future<UserPrefsService> init() async {
    final service = UserPrefsService._();
    await service._init();
    return service;
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
    getDefaultSavePath();
    getDefaultPackage();
    getDefaultDescription();
    getShouldUseDefaultDescription();
  }

  SharedPreferences prefs;
  final prefsStream = BehaviorSubject<UserPrefs>.seeded(UserPrefs());

  Future<void> getDefaultSavePath() async {
    final path = prefs.getString('default_save_path');
    if (path == null && Platform.isMacOS) {
      final defaultDir = await path_provider.getDownloadsDirectory();
      prefsStream.value.defaultSavePath = defaultDir.path;
      await setDefaultSavePath(defaultDir.path);
      log('Set default save path to ${defaultDir.path}',
          name: 'Groovin Create');
    }

    prefsStream.value.defaultSavePath = path;
  }

  Future<void> setDefaultSavePath(String path) async {
    prefsStream.value.defaultSavePath = path;
    await prefs.setString('default_save_path', path);
  }

  void getDefaultPackage() {
    prefsStream.value.defaultPackage =
        prefs.getString('default_package') ?? 'com.example';
  }

  Future<void> setDefaultPackage(String package) async {
    prefsStream.value.defaultPackage = package;
    await prefs.setString('default_package', package);
  }

  void getDefaultDescription() {
    prefsStream.value.defaultDescription =
        prefs.getString('default_description') ?? 'A new Flutter project.';
  }

  Future<void> setDefaultDescription(String description) async {
    prefsStream.value.defaultDescription = description;
    await prefs.setString('default_description', description);
  }

  void getShouldUseDefaultDescription() {
    prefsStream.value.shouldUseDefaultDescription =
        prefs.getBool('should_use_default_description') ?? true;
  }

  Future<void> setShouldUseDefaultDescription(bool shouldUseDefaultDesc) async {
    prefsStream.value.shouldUseDefaultDescription = shouldUseDefaultDesc;
    await prefs.setBool('should_use_default_description', shouldUseDefaultDesc);
  }

  void close() {
    prefsStream.close();
  }
}

class UserPrefs {
  String defaultSavePath;
  String defaultPackage;
  String defaultDescription;
  bool shouldUseDefaultDescription;
}
