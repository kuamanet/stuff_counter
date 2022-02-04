import 'package:flutter/material.dart';

extension SnackbarExtension on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snack(String message) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
