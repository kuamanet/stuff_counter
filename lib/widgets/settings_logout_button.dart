import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counters_button.dart';

class SettingsLogoutButton extends ConsumerWidget {
  final void Function() onPressed;
  const SettingsLogoutButton({required this.onPressed, Key? key}) : super(key: key);

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
        onPressed: onPressed,
      );
    }
    return const SizedBox.shrink();
  }
}
