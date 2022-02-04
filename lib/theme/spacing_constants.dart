import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CountersSpacing {
  static const double midSpace = 32;
  static const double bigSpace = 140.0;
  static const double padding900 = 40.0;
  static const double padding300 = 16.0;
  static const double padding600 = 32.0;

  static Widget spacer({double? height}) {
    return SizedBox(
      height: height ?? midSpace,
    );
  }

  static EdgeInsets scaffoldEdgeInsets =
      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 72.0);

  static EdgeInsets edgeInsetAll({double value = padding900}) {
    return EdgeInsets.all(value);
  }
}
