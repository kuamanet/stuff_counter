import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/create_counter.dart';
import 'package:kcounter/counters/actions/generate_random_color.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/actions/increment_counter.dart';
import 'package:kcounter/counters/actions/list_counters.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_log.dart';
import 'package:kcounter/counters/repositories/realtime_counters_repository.dart';
import 'package:kcounter/firebase_options.dart';

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
  final action = GenerateRandomColor();
  yield await action.run();
});

final firebaseProvider = FutureProvider<FirebaseApp>((_) async {
  return await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
});

final repositoryProvider = FutureProvider<CountersRepository>((ref) async {
  // wait for firebase initialization before reading a firebase database instance
  await ref.watch(firebaseProvider.future);

  return RealTimeCountersRepository(FirebaseDatabase.instance);
});

final createCounterActionProvider = FutureProvider<CreateCounter>((ref) async {
  final countersRepository = await ref.watch(repositoryProvider.future);

  return CreateCounter(countersRepository: countersRepository);
});

final incrementCounterActionProvider = FutureProvider<IncrementCounter>((ref) async {
  final countersRepository = await ref.watch(repositoryProvider.future);

  return IncrementCounter(countersRepository: countersRepository);
});

final listCounterActionProvider = FutureProvider<ListCounters>((ref) async {
  final countersRepository = await ref.watch(repositoryProvider.future);

  return ListCounters(countersRepository: countersRepository);
});

final counterLogsGrouperProvider =
    StateNotifierProvider<CounterLogsGrouper, List<List<CounterLog>>>((_) => CounterLogsGrouper());

class CounterLogsGrouper extends StateNotifier<List<List<CounterLog>>> {
  CounterLogsGrouper() : super([]);
  void group(GroupCounterLogsParams params) async {
    final action = GroupCounterLogs();
    state = await action.run(params);
  }
}
