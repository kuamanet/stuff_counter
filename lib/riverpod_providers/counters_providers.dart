import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/authentication/entities/authentication_entities.dart';
import 'package:kcounter/counters/actions/copy_counters.dart';
import 'package:kcounter/counters/actions/create_counter.dart';
import 'package:kcounter/counters/actions/decrease_counter.dart';
import 'package:kcounter/counters/actions/delete_counter.dart';
import 'package:kcounter/counters/actions/generate_random_color.dart';
import 'package:kcounter/counters/actions/get_counter.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/actions/increment_counter.dart';
import 'package:kcounter/counters/actions/list_counters.dart';
import 'package:kcounter/counters/actions/update_counter.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/counters/repositories/local_counters_repository.dart';
import 'package:kcounter/counters/repositories/realtime_counters_repository.dart';
import 'package:kcounter/extensions/counter_log.dart';
import 'package:kcounter/riverpod_providers/firestore_providers.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:localstore/localstore.dart';

final randomColorActionProvider = FutureProvider.autoDispose<Color>((_) async {
  final action = GenerateRandomColor();
  return await action.run();
});

final repositoryProvider = Provider<CountersRepository>((ref) {
  final authState = ref.watch(authProvider);

  final repository = authState.value?.state == AuthenticationState.signedIn
      ? RealTimeCountersRepository(FirebaseDatabase.instance, "${authState.value!.uid}/")
      : LocalCountersRepository(Localstore.instance);

  // refresh providers that depend on us
  Future.delayed(const Duration(milliseconds: 100), () {
    refreshCountersProviders(ref.container);
  });

  return repository;
});

final createCounterActionProvider = Provider<CreateCounter>((ref) {
  final countersRepository = ref.watch(repositoryProvider);

  return CreateCounter(countersRepository: countersRepository);
});

final updateCounterActionProvider = Provider<UpdateCounter>((ref) {
  final countersRepository = ref.watch(repositoryProvider);

  return UpdateCounter(countersRepository: countersRepository);
});

final readCounterActionProvider = Provider<GetCounter>((ref) {
  final countersRepository = ref.watch(repositoryProvider);

  return GetCounter(countersRepository: countersRepository);
});

final incrementCounterActionProvider = Provider<IncrementCounter>((ref) {
  final countersRepository = ref.watch(repositoryProvider);

  return IncrementCounter(countersRepository: countersRepository);
});

final decreaseCounterActionProvider = Provider<DecreaseCounter>((ref) {
  final countersRepository = ref.watch(repositoryProvider);

  return DecreaseCounter(countersRepository: countersRepository);
});

final listCounterActionProvider = Provider<ListCounters>((ref) {
  final countersRepository = ref.watch(repositoryProvider);
  return ListCounters(countersRepository: countersRepository);
});

final deleteCounterActionProvider = Provider<DeleteCounter>((ref) {
  final countersRepository = ref.watch(repositoryProvider);

  return DeleteCounter(countersRepository: countersRepository);
});

final counterLogsGrouperProvider =
    StateNotifierProvider<CounterLogsGrouper, Map<String, List<LineChartData>>>(
  (_) => CounterLogsGrouper(),
);

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

final localToRemoteActionProvider = FutureProvider<CopyCounters>((ref) async {
  final auth = await ref.read(authProvider.future);
  final source = LocalCountersRepository(Localstore.instance);
  final destination = RealTimeCountersRepository(FirebaseDatabase.instance, auth.uid!);

  return CopyCounters(from: source, to: destination);
});

final remoteToLocalActionProvider = FutureProvider<CopyCounters>((ref) async {
  final auth = await ref.read(authProvider.future);
  final source = RealTimeCountersRepository(FirebaseDatabase.instance, auth.uid!);
  final destination = LocalCountersRepository(Localstore.instance);

  return CopyCounters(from: source, to: destination);
});

// Since we are not using stream providers to provide actions in order to keep the ui more simple,
// we need to manually trigger the refresh of the actions when the repository changes between local and remote
void refreshCountersProviders(ProviderContainer container) {
  for (var provider in [
    deleteCounterActionProvider,
    listCounterActionProvider,
    decreaseCounterActionProvider,
    incrementCounterActionProvider,
    readCounterActionProvider,
    updateCounterActionProvider,
    createCounterActionProvider,
  ]) {
    container.refresh(provider);
  }
}
