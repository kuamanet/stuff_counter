import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kcounter/extensions/color.dart';

void main() {
  test("it turns a color into its string value representation", () {
    const color = Colors.amber;
    final value = color.value;

    expect(value.toString(), color.asCounterColor());
  });
  test("it turns a color string value representation into a color instance", () {
    final color = Colors.amber.shade900;
    final parsedColor = ColorExtension.fromCounterColor(color.asCounterColor());

    expect(parsedColor, equals(color));
  });
}
