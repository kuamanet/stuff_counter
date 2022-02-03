import 'package:flutter/material.dart';
import 'package:stuff_counter/theme/spacing_constants.dart';
import 'package:stuff_counter/widgets/color_selector.dart';

Widget colorPickerRow({required ValueChanged<Color> onColorChanged}) {
  return Row(
    children: [
      const Text("Color"),
      const SizedBox(
        width: CountersSpacing.padding300,
      ),
      ColorSelector(
        onColorChanged: onColorChanged,
      ),
    ],
  );
}
