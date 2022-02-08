import 'package:flutter/material.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counters_button.dart';

enum AuthenticationResult { success, failure }

class AuthenticationDialog extends StatelessWidget {
  const AuthenticationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Authentication",
            style: Theme.of(context).textTheme.headline5,
          ),
          CountersSpacing.spacer(),
          Text(
            "In order to store counters online, it is compulsory to authenticate",
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.black26,
                ),
          ),
          CountersSpacing.spacer(),
          CountersButton(
            text: "Google",
            icon: "assets/images/google_logo.svg",
            padding: const EdgeInsets.symmetric(
              vertical: CountersSpacing.padding300,
              horizontal: CountersSpacing.padding900,
            ),
            onPressed: () {
              // TODO await authentication
              Navigator.of(context).pop(AuthenticationResult.success);
            },
          ),
        ],
      ),
    );
  }
}
