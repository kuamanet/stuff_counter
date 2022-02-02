import 'package:flutter/material.dart';

abstract class Copyable<T> {
  @required
  T copyWith(/* Add named properties here; typically these are object fields.*/);
}
