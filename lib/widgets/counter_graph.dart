import 'package:charts_flutter/flutter.dart' as chart;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/entities/counter_log.dart';
import 'package:kcounter/extensions/counter_log.dart';
import 'package:kcounter/riverpod_providers.dart';

class CounterGraph extends ConsumerWidget {
  final List<CounterLog> logs;
  final GroupMode mode;
  final Color color;

  const CounterGraph({
    Key? key,
    required this.logs,
    required this.mode,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grouper = ref.read(counterLogsGrouperProvider.notifier);

    if (!grouper.mounted) {
      return const SizedBox.shrink();
    }
    grouper.group(GroupCounterLogsParams(logs: logs, groupMode: mode));

    return chart.TimeSeriesChart(
      [
        chart.Series<LineChartData, DateTime>(
          colorFn: (_, __) => chart.ColorUtil.fromDartColor(color),
          id: "history_graph",
          domainFn: (log, index) => log.date,
          measureFn: (log, index) => log.count,
          data: grouper.state.asGraphData,
        )
      ],
      animate: true,
      primaryMeasureAxis: const chart.NumericAxisSpec(renderSpec: chart.NoneRenderSpec()),
      domainAxis: const chart.DateTimeAxisSpec(renderSpec: chart.NoneRenderSpec()),
    );
  }
}
