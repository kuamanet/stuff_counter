import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';

class CopyCounters extends Action<void> {
  final CountersRepository from;
  final CountersRepository to;

  CopyCounters({
    required this.from,
    required this.to,
  });

  @override
  Future<void> run() async {
    final countersToCopy = await from.getAll().first;
    for (var counter in countersToCopy) {
      await to.create(counter, counter.id);
    }
  }
}
