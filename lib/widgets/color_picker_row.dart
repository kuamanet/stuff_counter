import 'package:flutter/material.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/color_selector.dart';

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
