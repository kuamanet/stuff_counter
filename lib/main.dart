import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/create_counter.dart';
import 'package:kcounter/counters/actions/generate_random_color.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/repositories/realtime_counters_repository.dart';
import 'package:kcounter/screens/create_counter_page.dart';
import 'package:kcounter/screens/dashboard_page.dart';

import 'firebase_options.dart';

enum AppRoute { dashboard, create, graph }

final routeProvider =
    StateNotifierProvider.autoDispose<AppRouteNotifier, AppRoute>((_) => AppRouteNotifier());

class AppRouteNotifier extends StateNotifier<AppRoute> {
  AppRouteNotifier() : super(AppRoute.dashboard);
  void toCreatePage() => state = AppRoute.create;
  void toDashboardPage() => state = AppRoute.dashboard;
  void toGraphPage() => state = AppRoute.graph;
}

final randomColorActionProvider = StreamProvider.autoDispose<Color>((_) async* {
  // TODO should return a different value each time is run, to be verified when we navigate from and to the create page
  final action = GenerateRandomColor();
  yield await action.run();
});

// final firebaseProvider = FutureProvider<FirebaseApp>((_) async {
//   return await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// });

final repositoryProvider = FutureProvider<CountersRepository>((ref) async {
  // wait for firebase initialization before reading a firebase database instance
  // await ref.watch(firebaseProvider.future);

  return RealTimeCountersRepository(FirebaseDatabase.instance);
});

final createCounterActionProvider = FutureProvider<CreateCounter>((ref) async {
  final countersRepository = await ref.watch(repositoryProvider.future);

  return CreateCounter(countersRepository: countersRepository);
});

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
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Counters',
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        baseColor: Colors.white,
        lightSource: LightSource.topLeft,
        depth: 10,
        accentColor: Colors.white,
      ),
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
