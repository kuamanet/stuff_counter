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
    final router = ref.read(routeProvider.notifier);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CountersIconButton(
        icon: Icons.add,
        padding: const EdgeInsets.all(CountersSpacing.padding300),
        onPressed: () {
          router.toCreatePage();
        },
      ),
      body: Stack(
        children: [
          const CountersList(),
          Positioned(
            right: CountersSpacing.smallSpace,
            top: CountersSpacing.midSpace,
            child: CountersIconButton(
              disableDepth: true,
              icon: Icons.more_vert,
              onPressed: () {
                router.toSettingsPage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
