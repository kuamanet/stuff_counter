import 'package:flutter/material.dart';

class ZeroCounters extends StatelessWidget {
  const ZeroCounters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "You didn't count anything...",
        style: TextStyle(
          color: Colors.black26,
          fontSize: 34,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
