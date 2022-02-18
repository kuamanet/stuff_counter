import 'package:charts_flutter/flutter.dart' as chart;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/extensions/counter_log.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';

class CounterChart extends ConsumerStatefulWidget {
  final CounterReadDto counter;
  final GroupMode mode;
  final Color color;
  final bool? hideAxis;
  final String? id;

  const CounterChart(
      {Key? key,
      required this.counter,
      required this.mode,
      required this.color,
      this.hideAxis,
      this.id})
      : super(key: key);

  @override
  ConsumerState<CounterChart> createState() => _CounterChartState();
}

class _CounterChartState extends ConsumerState<CounterChart> {
  @override
  void initState() {
    final grouper = ref.read(counterLogsGrouperProvider.notifier);

    grouper.group(CounterLogsGrouperParams(counter: widget.counter, mode: widget.mode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final groupedLogs = ref.watch(counterLogsGrouperProvider);

    return chart.TimeSeriesChart(
      [
        // TODO how to set line width / can it be rounded on the edges?
        chart.Series<LineChartData, DateTime>(
          colorFn: (_, __) => chart.ColorUtil.fromDartColor(widget.color),
          id: "history_graph",
          domainFn: (log, index) =>
              log.date, // todo check mode and format date: the month, the week, the day
          measureFn: (log, index) => log.count,
          data: groupedLogs[widget.id ?? widget.counter.id] ?? [],
        )
      ],
      animate: true,
      defaultInteractions: !(widget.hideAxis == true),
      primaryMeasureAxis: (widget.hideAxis == true)
          ? const chart.NumericAxisSpec(renderSpec: chart.NoneRenderSpec())
          : null,
      domainAxis: (widget.hideAxis == true)
          ? const chart.DateTimeAxisSpec(renderSpec: chart.NoneRenderSpec())
          : null,
    );
  }
}
