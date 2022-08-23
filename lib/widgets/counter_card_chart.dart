import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/extensions/color.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:kcounter/widgets/counter_chart.dart';

class CounterCardChart extends ConsumerWidget {
  final CounterWithDailyReadDto counter;
  const CounterCardChart({
    required this.counter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ref.read(routeProvider.notifier).toGraphPage(counter);
      },
      child: Stack(
        children: [
          SizedBox(
            height: 100,
            child: CounterChart(
              color: ColorExtension.fromCounterColor(counter.color),
              counter: counter,
              mode: GroupMode.day,
              hideAxis: true,
            ),
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            // if we do not provide a child it will not catch user gestures
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}
