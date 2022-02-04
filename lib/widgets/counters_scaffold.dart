import 'package:flutter/material.dart';
import 'package:kcounter/theme/spacing_constants.dart';

class CountersScaffold extends StatelessWidget {
  Widget? child;
  bool? hideKeyboard = true;
  CountersScaffold({Key? key, this.child, this.hideKeyboard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hideKeyboard == true) {
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
    return Scaffold(
      body: Padding(
        padding: CountersSpacing.scaffoldEdgeInsets,
        child: child,
      ),
    );
  }
}
