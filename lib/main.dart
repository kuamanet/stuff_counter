import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stuff_counter/screens/create_counter_page.dart';
import 'package:stuff_counter/screens/dashboard_page.dart';

import 'firebase_options.dart';

enum AppRoute { dashboard, create, graph }

final routeProvider = StateProvider((_) => AppRoute.create, name: "app_route");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
    child: CountersApp(),
  ));
}

class CountersApp extends ConsumerWidget {
  const CountersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(routeProvider);
    return MaterialApp(
      home: Navigator(
        pages: [
          const MaterialPage(child: DashboardPage()),
          if (currentRoute == AppRoute.create) const MaterialPage(child: CreateCounterPage())
        ],
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      ),
    );
  }
}
