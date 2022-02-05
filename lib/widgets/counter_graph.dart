import 'package:charts_flutter/flutter.dart' as chart;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/extensions/counter_log.dart';
import 'package:kcounter/riverpod_providers.dart';

class CounterGraph extends ConsumerStatefulWidget {
  final CounterReadDto counter;
  final GroupMode mode;
  final Color color;

  const CounterGraph({
    Key? key,
    required this.counter,
    required this.mode,
    required this.color,
  }) : super(key: key);

  @override
  ConsumerState<CounterGraph> createState() => _CounterGraphState();
}

class _CounterGraphState extends ConsumerState<CounterGraph> {
  @override
  void initState() {
    final grouper = ref.read(counterLogsGrouperProvider.notifier);

    print("Triggering grouping");
    grouper.group(CounterLogsGrouperParams(counter: widget.counter, mode: widget.mode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final groupedLogs = ref.watch(counterLogsGrouperProvider);
    print("${widget.counter.name} ${groupedLogs[widget.counter.id]?.length} logs");
    return chart.TimeSeriesChart(
      [
        chart.Series<LineChartData, DateTime>(
          colorFn: (_, __) => chart.ColorUtil.fromDartColor(widget.color),
          id: "history_graph",
          domainFn: (log, index) => log.date,
          measureFn: (log, index) => log.count,
          data: groupedLogs[widget.counter.id] ?? [],
        )
      ],
      animate: true,
      defaultInteractions: false,
      primaryMeasureAxis: const chart.NumericAxisSpec(renderSpec: chart.NoneRenderSpec()),
      domainAxis: const chart.DateTimeAxisSpec(renderSpec: chart.NoneRenderSpec()),
    );
  }
}
