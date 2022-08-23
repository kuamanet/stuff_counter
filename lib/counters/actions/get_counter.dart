import 'package:kcounter/counters/actions/list_counters.dart';
import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';

class GetCounter extends ParamsAction<String, CounterWithDailyReadDto> {
  final CountersRepository countersRepository;

  GetCounter({required this.countersRepository});

  @override
  Future<CounterWithDailyReadDto> run(String params) async {
    final count = await countersRepository.getOne(params);
    final today = DateTime.now();
    return CounterWithDailyReadDto.from(
      dailyCount: countDayLogs(count.history, today),
      count: count,
    );
  }
}
