import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/authentication/entities/authentication_entities.dart';
import 'package:kcounter/builders/counters_list_stream_builder.dart';
import 'package:kcounter/builders/list_counters_action_future_builder.dart';
import 'package:kcounter/riverpod_providers.dart';

class CountersList extends ConsumerWidget {
  const CountersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Authentication> authentication = ref.watch(authProvider);

    return ListCountersActionFutureBuilder(
      countersFuture: ref.read(listCounterActionProvider.future),
      onSuccess: (action) => CountersListStreamBuilder(action: action, authState: authentication),
    );
  }
}
