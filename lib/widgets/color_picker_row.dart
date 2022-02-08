import 'package:flutter/material.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/color_selector.dart';
class ColorPickerRow extends StatelessWidget {
  final ValueChanged<Color> onColorChanged;

  const ColorPickerRow({required this.onColorChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
