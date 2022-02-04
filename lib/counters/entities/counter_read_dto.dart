import 'package:kcounter/counters/entities/counter_create_dto.dart';
import 'package:kcounter/counters/entities/counter_log.dart';

class CounterReadDto extends CounterCreateDto {
  final String id;

  const CounterReadDto({
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

  @override
  CounterReadDto copyWith(
      {String? id, String? name, int? count, String? color, List<CounterLog>? history}) {
    return CounterReadDto(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
      color: color ?? this.color,
      history: history ?? this.history,
    );
  }

  @override
  Map<String, Object?> toMap() {
    return {
      "id": id,
      "count": count,
      "name": name,
      "color": color,
      "history": history.map((e) => e.toMap()).toList(),
    };
  }

  static CounterReadDto from(Object value, String id) {
    if (value is Map<String, Object?>) {
      final historyMap = value["history"] as List<Object>;
      return CounterReadDto(
          id: id,
          name: value["name"],
          count: value["count"],
          color: value["color"],
          history: historyMap.map((e) => CounterLog.from(e)).toList());
    }

    throw ArgumentError("[CounterReadDto] Cannot parse ${value.toString()} - ${value.runtimeType}");
  }

  @override
  List<Object?> get props => [id, name, color, count];
}
