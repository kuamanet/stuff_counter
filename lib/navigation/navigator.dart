import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/navigation/app_route.dart';
import 'package:kcounter/riverpod_providers.dart';
import 'package:kcounter/screens/counter_chart_page.dart';
import 'package:kcounter/screens/create_counter_page.dart';
import 'package:kcounter/screens/dashboard_page.dart';

class AppNavigator extends ConsumerWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(routeProvider);
    return Navigator(
      pages: [
        const MaterialPage(child: DashboardPage()),
        if (currentRoute.name == AppRouteName.create)
          const MaterialPage(child: CreateCounterPage()),
        if (currentRoute.name == AppRouteName.graph) const MaterialPage(child: CounterChartPage())
      ],
      onPopPage: (route, result) {
        // this runs each time the user hits the back button
        // we need to sync our route state here.
        // since we have a simple 1 depth structure (home -> subpage)
        // if user is going back, he can only go to the dashboard
        ref.read(routeProvider.notifier).toDashboardPage();
        return route.didPop(result);
      },
    );
  }
}
