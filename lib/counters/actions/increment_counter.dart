import 'package:kcounter/counters/actions/get_counter.dart';
import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_log.dart';

class IncrementCounter extends ParamsAction<String, void> {
  final CountersRepository countersRepository;

  IncrementCounter({required this.countersRepository});

  @override
  Future<void> run(String params) async {
    final getCounterAction = GetCounter(countersRepository: countersRepository);

    final counter = await getCounterAction.run(params);

    final history = counter.history.toList();
    history.add(CounterLog(createdAt: DateTime.now(), count: 1));
    final increasedCounter = counter.copyWith(
      count: history.length,
      history: history.toList(growable: false),
    );

    await countersRepository.update(increasedCounter);
  }
}
