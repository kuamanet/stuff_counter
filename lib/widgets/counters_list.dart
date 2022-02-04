import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/list_counters.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/riverpod_providers.dart';
import 'package:kcounter/theme/spacing_constants.dart';
import 'package:kcounter/widgets/counter.dart';

class CountersList extends ConsumerWidget {
  const CountersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _getAction(ref, _buildList);
  }

  StreamBuilder _buildList(ListCounters action) {
    return StreamBuilder<List<CounterReadDto>>(
      stream: action.run(),
      builder: (context, countersSnapshot) {
        switch (countersSnapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (countersSnapshot.hasError) {
              // context.snack("Could not load counters list");
              print(countersSnapshot.error);
              print(countersSnapshot.stackTrace);
              return const SizedBox.shrink();
            }

            var counters = countersSnapshot.data?.map((e) => Counter(counter: e)) ?? [];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  CountersSpacing.midSpace,
                  CountersSpacing.bigSpace,
                  CountersSpacing.midSpace,
                  100,
                ),
                child: Wrap(
                  runSpacing: CountersSpacing.midSpace,
                  children: [
                    ...counters,
                  ],
                ),
              ),
            );
        }
      },
    );
  }

  FutureBuilder _getAction(WidgetRef ref, Function(ListCounters) onSuccess) {
    return FutureBuilder<ListCounters>(
        future: ref.read(listCounterActionProvider.future),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                // context.snack("Could not load list count actions");
                return const SizedBox.shrink();
              }

              return onSuccess(snapshot.data!);
          }
        });
  }
}
