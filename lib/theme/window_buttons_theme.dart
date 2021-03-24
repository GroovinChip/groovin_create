import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

/// Windows platform only!
final buttonColors = WindowButtonColors(
  iconNormal: Colors.white,
  mouseOver: Color.lerp(Colors.brown.shade800, Colors.black, .3),
  mouseDown: Color.lerp(Colors.brown.shade800, Colors.black, .7),
  iconMouseOver: Colors.white,
  iconMouseDown: Colors.white,
);