import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/core/counter_logger.dart';
import 'package:kcounter/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counters_button.dart';

class SettingsLogoutButton extends ConsumerWidget {
  const SettingsLogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(readLocalSettingsProvider);

    if (settings.value?.online == true && settings.value?.authenticated == true) {
      return CountersButton(
        text: "Logout",
        background: Colors.redAccent,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: CountersSpacing.padding300,
          horizontal: CountersSpacing.padding900,
        ),
        onPressed: () async {
          try {
            await ref.read(signOutProvider.future);
          } catch (error, stacktrace) {
            CounterLogger.error("While trying to sign out", error, stacktrace);
          }
        },
      );
    }
    return const SizedBox.shrink();
  }
}
