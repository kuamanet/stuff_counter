import 'package:flutter_test/flutter_test.dart';
import 'package:kcounter/counters/actions/group_counter_logs.dart';
import 'package:kcounter/counters/entities/counter_log.dart';

void main() {
  final logs = [
    // february week
    CounterLog(createdAt: DateTime.parse("2021-02-02 12:00"), count: 1),
    CounterLog(createdAt: DateTime.parse("2021-02-02 13:00"), count: 1),
    // march week
    CounterLog(createdAt: DateTime.parse("2021-03-02 14:00"), count: 1),
    CounterLog(createdAt: DateTime.parse("2021-03-03 15:00"), count: 1),
    CounterLog(createdAt: DateTime.parse("2021-03-04 16:00"), count: 1),
    // march week
    CounterLog(createdAt: DateTime.parse("2021-03-08 17:00"), count: 1),
    CounterLog(createdAt: DateTime.parse("2021-03-09 18:00"), count: 1),
    CounterLog(createdAt: DateTime.parse("2021-03-10 19:00"), count: 1),
    // april week
    CounterLog(createdAt: DateTime.parse("2020-04-04 20:00"), count: 1),
    CounterLog(createdAt: DateTime.parse("2020-04-05 12:00"), count: 1),
  ];

  test("It groups counter logs by day", () async {
    final action = GroupCounterLogs();

    final result = await action.run(GroupCounterLogsParams(logs: logs, groupMode: GroupMode.day));

    expect(result.length, 9);
    expect(result[0].length, 2);
    expect(result[1].length, 1);
  });

  test("It groups counter logs by week", () async {
    final action = GroupCounterLogs();

    final result = await action.run(GroupCounterLogsParams(logs: logs, groupMode: GroupMode.week));

    expect(result.length, 4);
    expect(result[0].length, 2);
    expect(result[1].length, 3);
    expect(result[2].length, 3);
    expect(result[3].length, 2);
  });

  test("It groups counter logs by month", () async {
    final action = GroupCounterLogs();

    final result = await action.run(GroupCounterLogsParams(logs: logs, groupMode: GroupMode.month));

    expect(result.length, 3);
    expect(result[0].length, 2);
    expect(result[1].length, 6);
    expect(result[2].length, 2);
  });
}
