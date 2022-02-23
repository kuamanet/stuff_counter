import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/navigation/app_route.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/screens/counter_chart_screen.dart';
import 'package:kcounter/screens/dashboard_screen.dart';
import 'package:kcounter/screens/save_counter_screen.dart';
import 'package:kcounter/screens/settings_screen.dart';

class AppNavigator extends ConsumerWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(routeProvider);
    return Navigator(
      pages: [
        const MaterialPage(child: DashboardScreen()),
        if (currentRoute.name == AppRouteName.create)
          const MaterialPage(child: SaveCounterScreen()),
        if (currentRoute.name == AppRouteName.graph)
          const MaterialPage(child: CounterChartScreen()),
        // update counter is reachable from the graph page
        if (currentRoute.name == AppRouteName.update) ...[
          const MaterialPage(child: CounterChartScreen()),
          const MaterialPage(
            child: SaveCounterScreen(),
            key: SaveCounterScreen.valueKey,
          ),
        ],
        if (currentRoute.name == AppRouteName.settings) const MaterialPage(child: SettingsScreen()),
      ],
      onPopPage: (route, result) {
        // this runs each time the user hits the back button
        // we need to sync our route state here.
        final page = route.settings as MaterialPage;
        final counter = ref.watch(routeProvider).currentCounter;
        if (page.key == SaveCounterScreen.valueKey && counter != null) {
          // we are coming back from an update counter
          ref.read(routeProvider.notifier).toGraphPage(counter);
        } else {
          ref.read(routeProvider.notifier).toDashboardPage();
        }

        return route.didPop(result);
      },
    );
  }
}
