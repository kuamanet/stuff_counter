import 'package:flutter/material.dart';
import 'package:kcounter/theme/spacing_constants.dart';

class CounterCardButton extends MaterialButton {
  CounterCardButton({
    required VoidCallback? onPressed,
    required Color background,
    required Color color,
    required IconData icon,
    double? elevation,
    double? size,
    Key? key,
  }) : super(
          key: key,
          onPressed: onPressed,
          shape: const CircleBorder(),
          elevation: elevation,
          textColor: color,
          color: background,
          padding: EdgeInsets.all(size ?? CountersSpacing.padding300),
          child: Icon(icon),
        );
}
