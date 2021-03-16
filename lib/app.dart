import 'package:flutter/material.dart';
import 'package:groovin_create/creator.dart';

class GroovinCreateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Groovin Create',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Creator(),
    );
  }
}
