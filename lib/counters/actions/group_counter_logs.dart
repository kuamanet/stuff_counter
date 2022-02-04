import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/entities/counter_log.dart';
import 'package:week_of_year/week_of_year.dart';

enum GroupMode { day, week, month }

class GroupCounterLogsParams {
  final List<CounterLog> logs;
  final GroupMode groupMode;

  GroupCounterLogsParams({required this.logs, required this.groupMode});
}

class GroupCounterLogs extends ParamsAction<GroupCounterLogsParams, List<List<CounterLog>>> {
  @override
  Future<List<List<CounterLog>>> run(GroupCounterLogsParams params) async {
    // Do heavy work inside a separate isolate
    return await compute(_isolatedGroupBy, params);
  }
}

List<List<CounterLog>> _isolatedGroupBy(GroupCounterLogsParams params) {
  DateFormat dateFormat;

  switch (params.groupMode) {
    case GroupMode.day:
      dateFormat = DateFormat("yyyy-MM-dd");
      break;
    case GroupMode.month:
    case GroupMode.week:
      dateFormat = DateFormat("yyyy-MM");
      break;
  }

  final grouped = groupBy(params.logs, (CounterLog log) {
    switch (params.groupMode) {
      case GroupMode.month:
      case GroupMode.day:
        return dateFormat.format(log.createdAt);
      case GroupMode.week:
        return "${dateFormat.format(log.createdAt)}-${log.createdAt.weekOfYear}";
    }
  });
  return grouped.values.toList().sortedBy((element) => element.first.createdAt);
}
