import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/list_counters.dart';
import 'package:kcounter/extensions/context.dart';
import 'package:kcounter/riverpod_providers.dart';

class ListCountersActionFutureBuilder extends FutureBuilder<ListCounters> {
  final Function(ListCounters) onSuccess;
  final WidgetRef ref;

  ListCountersActionFutureBuilder({Key? key, required this.onSuccess, required this.ref})
      : super(
          key: key,
          future: ref.read(listCounterActionProvider.future),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  // TODO log
                  context.snack("Could not load list count actions");
                  return const SizedBox.shrink();
                }

                return onSuccess(snapshot.data!);
            }
          },
        );
}
