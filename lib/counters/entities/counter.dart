import 'package:stuff_counter/counters/entities/counter_log.dart';

class CounterCreateDto {
  /// The name of the counter
  final String name;

  /// Current count of the counter
  final int count;

  /// Color of the counter, in rgb format
  final String color;

  /// History of increments of this counter
  final List<CounterLog> history;

  CounterCreateDto({
    required this.name,
    required this.count,
    required this.color,
    required this.history,
  });
}

class CounterReadDto extends CounterCreateDto {
  final String id;

  CounterReadDto({
    required this.id,
    required name,
    required count,
    required color,
    required history,
  }) : super(
          name: name,
          count: count,
          color: color,
          history: history,
        );
}
