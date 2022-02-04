import 'package:kcounter/counters/entities/counter_log.dart';

class LineChartData {
  final DateTime date;
  final int count;

  const LineChartData({
    required this.date,
    required this.count,
  });
}

extension CounterLogExtension on List<List<CounterLog>> {
  List<LineChartData> get asGraphData => fold<List<LineChartData>>([], (previousValue, logs) {
        final log = logs.first;
        final count = logs.fold<int>(0, (previousValue, element) => previousValue + element.count);

        previousValue.add(LineChartData(date: log.createdAt, count: count));
        return previousValue;
      });
}
