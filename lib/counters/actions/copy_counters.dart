import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_log.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';

/// Copies counters between repositories.
///
/// If a counter exists in both repositories, will merge its [CounterLog]s
class CopyCounters extends Action<void> {
  final CountersRepository from;
  final CountersRepository to;

  CopyCounters({
    required this.from,
    required this.to,
  });

  @override
  Future<void> run() async {
    final countersToCopy = await from
        .getAll()
        .firstWhere((element) => element.isNotEmpty)
        .timeout(const Duration(seconds: 20), onTimeout: () => []);
    final countersToPreserve = await to
        .getAll()
        .firstWhere((element) => element.isNotEmpty)
        .timeout(const Duration(seconds: 20), onTimeout: () => []);

    for (var counter in countersToCopy) {
      final counterToPreserve = countersToPreserve.cast<CounterReadDto?>().firstWhere(
            (element) => element?.id == counter.id,
            orElse: () => null,
          );
      if (counterToPreserve != null) {
        await to.create(
            counter.copyWith(history: [
              ...counter.history,
              ...counterToPreserve.history,
            ]),
            counter.id);
      } else {
        await to.create(counter, counter.id);
      }
    }
  }
}
