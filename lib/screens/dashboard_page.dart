import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counters_icon_button.dart';
import 'package:kcounter/widgets/counters_list.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CountersIconButton(
        icon: Icons.add,
        padding: const EdgeInsets.all(CountersSpacing.padding300),
        onPressed: () {
          final router = ref.read(routeProvider.notifier);
          router.toCreatePage();
        },
      ),
      body: const CountersList(),
    );
  }
}
