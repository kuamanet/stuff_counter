import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kcounter/counters/core/action.dart' as counters;

/// Generates a random color
/// This is used to prefill counter color field for the user
class GenerateRandomColor extends counters.Action<Color> {
  @override
  Future<Color> run() async {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
}
