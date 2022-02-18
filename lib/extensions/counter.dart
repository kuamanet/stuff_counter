import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';

extension CounterReadDtoExtension on CounterReadDto {
  String get lastUpdate {
    final logs = [...history];
    logs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final mostRecentLog = logs.firstOrNull;

    if (mostRecentLog != null) {
      final formatter = DateFormat("MMMM d");
      return formatter.format(mostRecentLog.createdAt);
    }

    return "--";
  }
}
