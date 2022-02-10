import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/authentication/entities/authentication_entities.dart';
import 'package:kcounter/counters/core/counter_logger.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counters_button.dart';

class AuthenticationDialog extends ConsumerWidget {
  const AuthenticationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onPressed: () async {
              try {
                final action = ref.read(signInActionProvider);
                await action.run();
                Navigator.of(context).pop(AuthenticationResult.success);
              } catch (error, stacktrace) {
                CounterLogger.error("While trying to authenticate", error, stacktrace);
                Navigator.of(context).pop(AuthenticationResult.failure);
              }
            },
          ),
        ],
      ),
    );
  }
}
