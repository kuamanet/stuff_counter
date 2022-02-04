import 'package:flutter/material.dart';

extension ColorExtension on Color {
  String asCounterColor() {
    return value.toString();
  }

  static Color fromCounterColor(String counterColor) {
    final parsed = int.parse(counterColor);
    return Color(parsed);
  }
}
