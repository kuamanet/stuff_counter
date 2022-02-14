import 'package:kcounter/counters/core/action.dart';
import 'package:kcounter/counters/core/counters_repository.dart';
import 'package:kcounter/counters/entities/counter_read_dto.dart';

class ListCountersParams {
  final bool showSecretCounters;

  ListCountersParams({required this.showSecretCounters});
}

class ListCounters extends ParamsStreamAction<ListCountersParams, List<CounterReadDto>> {
  final CountersRepository countersRepository;

  ListCounters({required this.countersRepository});

  @override
  Stream<List<CounterReadDto>> run(ListCountersParams params) {
    return countersRepository.getAll().map((event) {
      if (params.showSecretCounters) {
        return event;
      }

      return event
          .where((element) => element.secret == params.showSecretCounters)
          .toList(growable: false);
    });
  }
}
