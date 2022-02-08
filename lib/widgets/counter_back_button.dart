import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/riverpod_providers.dart';
import 'package:kcounter/widgets/counters_icon_button.dart';

class CounterBackButton extends ConsumerWidget {
  const CounterBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CountersIconButton(
      color: Colors.white,
      background: Colors.black,
      icon: Icons.arrow_back,
      onPressed: () {
        final router = ref.read(routeProvider.notifier);
        router.toDashboardPage();
      },
    );
  }
}
