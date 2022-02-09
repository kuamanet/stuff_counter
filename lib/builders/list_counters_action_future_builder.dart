import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kcounter/counters/actions/list_counters.dart';
import 'package:kcounter/counters/core/counter_logger.dart';
import 'package:kcounter/extensions/context.dart';

class ListCountersActionFutureBuilder extends FutureBuilder<ListCounters> {
  ListCountersActionFutureBuilder({
    Key? key,
    required Function(ListCounters) onSuccess,
    required Future<ListCounters> countersFuture,
  }) : super(
          key: key,
          future: countersFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  context.snack("Could not load list counts action");
                  CounterLogger.error(
                    "while loading list counters action",
                    snapshot.error,
                    snapshot.stackTrace,
                  );
                  return const SizedBox.shrink();
                }

                return onSuccess(snapshot.data!);
            }
          },
        );
}
