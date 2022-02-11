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
    final countersToDelete = await to.getAll().first;

    for (var counter in countersToDelete) {
      await to.delete(counter.id);
    }

    for (var counter in countersToCopy) {
      await to.create(counter);
    }
  }
}
