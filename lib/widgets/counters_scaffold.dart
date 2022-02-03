import 'package:flutter/material.dart';
import 'package:stuff_counter/theme/spacing_constants.dart';

class CountersScaffold extends StatelessWidget {
  Widget? child;
  CountersScaffold({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(
          padding: CountersSpacing.scaffoldEdgeInsets,
          child: child,
        ),
      ),
    );
  }
}
