import 'package:stuff_counter/counters/entities/counter_log.dart';

class Counter {
  final String id;

  /// The name of the counter
  final String name;

  /// Current count of the counter
  final int count;

  /// Color of the counter, in rgb format
  final String color;

  /// History of increments of this counter
  final List<CounterLog> history;

  Counter({
    required this.id,
    required this.name,
    required this.count,
    required this.color,
    required this.history,
  });
}
