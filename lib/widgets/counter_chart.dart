import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';
import 'package:kcounter/extensions/counter_log.dart';
import 'package:kcounter/riverpod_providers/riverpod_providers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CounterChart extends ConsumerStatefulWidget {
  final CounterReadDto counter;
  final GroupMode mode;
  final Color color;
  final bool? hideAxis;
  final String? id;

  const CounterChart({
    Key? key,
    required this.counter,
    required this.mode,
    required this.color,
    this.hideAxis,
    this.id,
  }) : super(key: key);

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

    DateFormat format;
    switch (widget.mode) {
      case GroupMode.day:
        format = DateFormat("dd/MM/yyyy");
        break;
      case GroupMode.week:
        format = DateFormat("dd/MM/yyyy");
        break;
      case GroupMode.month:
        format = DateFormat("MM/yyyy");
        break;
    }
    return SfCartesianChart(
      enableAxisAnimation: true,
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
        majorGridLines: const MajorGridLines(width: 0),
        dateFormat: format,
        interval: 2,
        labelIntersectAction: AxisLabelIntersectAction.rotate90,
        isVisible: widget.hideAxis != null ? !(widget.hideAxis!) : true,
      ),
      primaryYAxis: NumericAxis(
        isVisible: widget.hideAxis != null ? !(widget.hideAxis!) : true,
      ),
      series: <ChartSeries<LineChartData, DateTime>>[
        AreaSeries(
          color: widget.color.withOpacity(0.5),
          dataSource: groupedLogs[widget.id ?? widget.counter.id] ?? [],
          xValueMapper: (value, index) => value.date,
          yValueMapper: (value, index) => value.count,
        )
      ],
    );
  }
}
