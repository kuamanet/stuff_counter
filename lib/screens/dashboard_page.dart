import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/entities/counter_log.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/riverpod_providers.dart';
import 'package:kcounter/widgets/counter.dart';
import 'package:kcounter/widgets/counters_scaffold.dart';

// TODO remove after testing
final logs = [
  // february week
  CounterLog(createdAt: DateTime.parse("2021-02-02 12:00"), count: 1),
  CounterLog(createdAt: DateTime.parse("2021-02-02 13:00"), count: 1),
  // march week
  CounterLog(createdAt: DateTime.parse("2021-03-02 14:00"), count: 1),
  CounterLog(createdAt: DateTime.parse("2021-03-03 15:00"), count: 1),
  CounterLog(createdAt: DateTime.parse("2021-03-04 16:00"), count: 1),
  // march week
  CounterLog(createdAt: DateTime.parse("2021-03-08 17:00"), count: 1),
  CounterLog(createdAt: DateTime.parse("2021-03-09 18:00"), count: 1),
  CounterLog(createdAt: DateTime.parse("2021-03-10 19:00"), count: 1),
  // april week
  CounterLog(createdAt: DateTime.parse("2020-04-04 20:00"), count: 1),
  CounterLog(createdAt: DateTime.parse("2020-04-05 12:00"), count: 1),
];

class DashboardPage extends ConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: CountersScaffold(
        hideKeyboard: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Counter(
              counter: CounterReadDto(
                id: "a",
                name: "A simple counter",
                color: Colors.amber.shade400.asCounterColor(),
                count: 1400,
                history: logs,
              ),
            ),
            ElevatedButton(
              child: const Text("Create counter"),
              onPressed: () {
                final router = ref.read(routeProvider.notifier);
                router.toCreatePage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
