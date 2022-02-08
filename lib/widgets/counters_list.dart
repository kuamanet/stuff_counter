import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/builders/counters_list_stream_builder.dart';
import 'package:kcounter/builders/list_counters_action_future_builder.dart';

class CountersList extends ConsumerWidget {
  const CountersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListCountersActionFutureBuilder(
      ref: ref,
      onSuccess: (action) => CountersListStreamBuilder(action: action),
    );
  }
}
