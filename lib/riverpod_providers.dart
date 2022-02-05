import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/create_counter.dart';
import 'package:kcounter/counters/actions/generate_random_color.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/actions/increment_counter.dart';
import 'package:kcounter/counters/actions/list_counters.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/counters/repositories/realtime_counters_repository.dart';
import 'package:kcounter/extensions/counter_log.dart';
import 'package:kcounter/firebase_options.dart';

import 'navigation/app_route.dart';

final routeProvider =
    StateNotifierProvider.autoDispose<AppRouteNotifier, AppRoute>((_) => AppRouteNotifier());

class AppRouteNotifier extends StateNotifier<AppRoute> {
  AppRouteNotifier() : super(const AppRoute(name: AppRouteName.dashboard));
  void toCreatePage() => state = const AppRoute(name: AppRouteName.create);
  void toDashboardPage() => state = const AppRoute(name: AppRouteName.dashboard);
  void toGraphPage(CounterReadDto counter) => state = AppRoute(
        name: AppRouteName.graph,
        currentCounter: counter,
      );
}

final randomColorActionProvider = StreamProvider.autoDispose<Color>((_) async* {
  final action = GenerateRandomColor();
  yield await action.run();
});

final firebaseProvider = FutureProvider<FirebaseApp>((_) async {
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

  return app;
});

final repositoryProvider = FutureProvider<CountersRepository>((ref) async {
  // wait for firebase initialization before reading a firebase database instance
  await ref.watch(firebaseProvider.future);

  return RealTimeCountersRepository(FirebaseDatabase.instance);
});

final createCounterActionProvider = FutureProvider.autoDispose<CreateCounter>((ref) async {
  final countersRepository = await ref.watch(repositoryProvider.future);

  return CreateCounter(countersRepository: countersRepository);
});

final incrementCounterActionProvider = FutureProvider.autoDispose<IncrementCounter>((ref) async {
  final countersRepository = await ref.watch(repositoryProvider.future);

  return IncrementCounter(countersRepository: countersRepository);
});

final listCounterActionProvider = FutureProvider<ListCounters>((ref) async {
  final countersRepository = await ref.watch(repositoryProvider.future);

  return ListCounters(countersRepository: countersRepository);
});

final counterLogsGrouperProvider =
    StateNotifierProvider<CounterLogsGrouper, Map<String, List<LineChartData>>>(
        (_) => CounterLogsGrouper());

class CounterLogsGrouperParams {
  final CounterReadDto counter;
  final GroupMode mode;
  final String? id;

  const CounterLogsGrouperParams({
    required this.counter,
    required this.mode,
    this.id,
  });
}

class CounterLogsGrouper extends StateNotifier<Map<String, List<LineChartData>>> {
  CounterLogsGrouper() : super({});
  void group(CounterLogsGrouperParams params) async {
    final action = GroupCounterLogs();
    final counterId = params.id ?? params.counter.id;
    final mode = params.mode;
    // final logs = params.counter.history;
    final groupedLogs =
        await action.run(GroupCounterLogsParams(logs: params.counter.history, groupMode: mode));
    state[counterId] = groupedLogs.asGraphData;
    state = Map.of(state);
  }
}
