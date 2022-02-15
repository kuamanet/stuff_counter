import 'package:flutter/foundation.dart';
import 'package:kcounter/counters_app.dart';
import 'package:kcounter/landing_app.dart';

void main() async {
  if (kIsWeb) {
    launchLandingApp();
  } else {
    await launchCountersApp();
  }
}
