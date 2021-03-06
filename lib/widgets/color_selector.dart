import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/core/counter_logger.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/extensions/context.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';

class ColorSelector extends StatefulWidget {
  final ValueChanged<Color> onColorChanged;
  final double height;
  final double width;
  final String? color;

  const ColorSelector({
    required this.onColorChanged,
    this.height = 40,
    this.width = 40,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final resolvedColor = _resolveColor(ref);
        resolvedColor.whenData((value) => widget.onColorChanged(value));

        return GestureDetector(
          onTap: () {
            _changeColor(context, resolvedColor);
          },
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color ?? resolvedColor.value,
            ),
          ),
        );
      },
    );
  }

  AsyncValue<Color> _resolveColor(WidgetRef ref) {
    if (widget.color != null && color == null) {
      return AsyncValue.data(ColorExtension.fromCounterColor(widget.color!));
    }

    if (color != null) {
      return AsyncValue.data(color!);
    }

    return ref.watch(randomColorActionProvider);
  }

  void _changeColor(BuildContext context, AsyncValue<Color> futureColor) {
    futureColor.when(
        data: (color) => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Pick a color!'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: color,
                    onColorChanged: (Color changedColor) {
                      setState(() {
                        this.color = changedColor;
                      });
                      widget.onColorChanged(changedColor);
                    },
                    labelTypes: const [],
                    pickerAreaHeightPercent: 0.8,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }),
        error: (error, stacktrace) {
          context.snack("Could no initialize component");
          CounterLogger.error("While loading random color action", error, stacktrace);
        },
        loading: () => const AsyncValue.loading());
  }
}
