import 'package:kcounter/counters/actions/get_counter.dart';
import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';

class DecreaseCounter extends ParamsAction<String, void> {
  final CountersRepository countersRepository;

  DecreaseCounter({required this.countersRepository});

  @override
  Future<void> run(String params) async {
    final getCounterAction = GetCounter(countersRepository: countersRepository);

    final counter = await getCounterAction.run(params);

    final history = counter.history.toList();
    // sort by date asc
    history.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    history.removeLast();

    final increasedCounter = counter.copyWith(
      count: history.length,
      history: history.toList(growable: false),
    );

    await countersRepository.update(increasedCounter);
  }
}
