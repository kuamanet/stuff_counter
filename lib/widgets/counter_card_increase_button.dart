import 'package:flutter/material.dart';
import 'package:kcounter/theme/spacing_constants.dart';

class CounterCardIncreaseButton extends MaterialButton {
  const CounterCardIncreaseButton({required VoidCallback? onPressed, Key? key})
      : super(
          key: key,
          onPressed: onPressed,
          shape: const CircleBorder(),
          textColor: Colors.white,
          color: Colors.black,
          padding: const EdgeInsets.all(CountersSpacing.padding300),
          child: const Icon(Icons.arrow_upward),
        );
}
