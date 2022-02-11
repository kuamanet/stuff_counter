import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/create_counter.dart';
import 'package:kcounter/counters/actions/delete_counter.dart';
import 'package:kcounter/counters/actions/generate_random_color.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/actions/increment_counter.dart';
import 'package:kcounter/counters/actions/list_counters.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/counters/repositories/realtime_counters_repository.dart';
import 'package:kcounter/extensions/counter_log.dart';
import 'package:kcounter/riverpod_providers/firestore_providers.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';

final randomColorActionProvider = FutureProvider.autoDispose<Color>((_) async {
  final action = GenerateRandomColor();
  return await action.run();
});

final repositoryProvider = FutureProvider<CountersRepository>((ref) async {
  // wait for firebase initialization before reading a firebase database instance
  await ref.watch(firebaseProvider.future);

  return RealTimeCountersRepository(FirebaseDatabase.instance, "counters/");
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

final deleteCounterActionProvider = FutureProvider<DeleteCounter>((ref) async {
  final countersRepository = await ref.watch(repositoryProvider.future);

  return DeleteCounter(countersRepository: countersRepository);
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
