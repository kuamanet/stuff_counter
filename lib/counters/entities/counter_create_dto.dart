import 'package:equatable/equatable.dart';
import 'package:kcounter/counters/core/copyable.dart';
import 'package:kcounter/counters/entities/counter_log.dart';

class CounterCreateDto extends Equatable implements Copyable<CounterCreateDto> {
  /// The name of the counter
  final String name;

  /// Current count of the counter
  final int count;

  /// Color of the counter, in rgb format
  final String color;

  /// History of increments of this counter
  final List<CounterLog> history;

  const CounterCreateDto({
    required this.name,
    required this.count,
    required this.color,
    required this.history,
  });

  @override
  List<Object?> get props => [name, color, count];

  @override
  bool? get stringify => false;

  @override
  CounterCreateDto copyWith({
    String? name,
    int? count,
    String? color,
    List<CounterLog>? history,
  }) {
    return CounterCreateDto(
      name: name ?? this.name,
      count: count ?? this.count,
      color: color ?? this.color,
      history: history ?? this.history,
    );
  }

  Map<String, Object?> toMap() {
    return {
      "count": count,
      "name": name,
      "color": color,
      "history": history.map((e) => e.toMap()).toList(),
    };
  }
}
