import 'package:equatable/equatable.dart';

class CounterLog extends Equatable {
  final DateTime createdAt;
  final int count;

  const CounterLog({required this.createdAt, required this.count});

  Map<String, Object?> toMap() {
    return {
      "count": count,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  static CounterLog from(Object value) {
    if (value is Map<String, Object?>) {
      return CounterLog(
          createdAt: DateTime.parse(value["createdAt"].toString()),
          count: int.parse(value["count"].toString()));
    }

    throw ArgumentError("[CounterLog] Cannot parse ${value.toString()} - ${value.runtimeType}");
  }

  @override
  List<Object?> get props => [createdAt, count];
}
