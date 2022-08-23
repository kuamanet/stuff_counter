import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';

import 'package:kcounter/counters/entities/counter_log.dart';

class ListCountersParams {
  final bool showSecretCounters;

  ListCountersParams({required this.showSecretCounters});
}

class ListCounters extends ParamsStreamAction<ListCountersParams, List<CounterWithDailyReadDto>> {
  final CountersRepository countersRepository;

  ListCounters({required this.countersRepository});

  @override
  Stream<List<CounterWithDailyReadDto>> run(ListCountersParams params) {
    final today = DateTime.now();
    return countersRepository.getAll().map((event) {
      if (params.showSecretCounters) {
        return event
            .map((count) => CounterWithDailyReadDto.from(
                  dailyCount: countDayLogs(count.history, today),
                  count: count,
                ))
            .toList(growable: false);
      }

      return event
          .where((element) => element.secret == params.showSecretCounters)
          .map((count) => CounterWithDailyReadDto.from(
                dailyCount: countDayLogs(count.history, today),
                count: count,
              ))
          .toList(growable: false);
    });
  }
}

int countDayLogs(List<CounterLog> logs, DateTime day) {
  return logs
      .where((log) =>
          log.createdAt.day == day.day &&
          log.createdAt.month == day.month &&
          log.createdAt.year == day.year)
      .length;
}
