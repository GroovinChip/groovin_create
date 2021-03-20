import 'package:flutter/material.dart';

/// A MaterialStateColor used for this app's CheckboxThemeData fillColor
class MaterialBrown extends MaterialStateColor {
  const MaterialBrown() : super(_defaultColor);

  static const int _defaultColor = 0xFF5D4037;

  @override
  Color resolve(Set<MaterialState> states) {
    return const Color(_defaultColor);
  }
}
